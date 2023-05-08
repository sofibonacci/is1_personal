!classDefinition: #CrewTest category: 'ISW1-2022-2C-1erParcial'!
TestCase subclass: #CrewTest
	instanceVariableNames: 'island1 map1 crew1'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2022-2C-1erParcial'!

!CrewTest methodsFor: 'tests' stamp: 'sg 5/7/2023 19:18:06'!
crewAt: island withMap: map withCrewMembersLocatedAt: crewPosition

	^ Crew 
			at: island 
			composedBy: (OrderedCollection with: (Corsario with: map) with: Filibustero new with: Bucanero new)
			at: crewPosition! !

!CrewTest methodsFor: 'tests' stamp: 'sg 5/7/2023 19:00:25'!
mapOf: island withCrewLocatedAt: crewPosition

	^ Map of: island crewStartsAt: crewPosition! !

!CrewTest methodsFor: 'tests' stamp: 'sg 5/8/2023 01:12:34'!
setUpScenarioWithTreesAt: treePositions digsAt: digsPositions andMapSize: aMapSize andCrewPositionedAt: crewPosition

	island1 := Island
		sized: aMapSize
		treesAt: treePositions
		digsAt: digsPositions.
	
	map1 := Map of: island1 crewStartsAt: crewPosition.
	
	crew1 := self crewAt: island1 withMap: map1 withCrewMembersLocatedAt: crewPosition
	
! !

!CrewTest methodsFor: 'tests' stamp: 'sg 5/8/2023 01:18:45'!
test01MovingCrewToTreePlaceDoesNotMove

	self setUpScenarioWithTreesAt: self treePositions digsAt: (OrderedCollection with: 2@2) andMapSize: 4 andCrewPositionedAt: self crewPosition.

	crew1 moveTo: self treePosition first.
	
	self deny: (island1 hasCrewAt: self treePosition first).
	self assert: (island1 hasCrewAt: self crewPosition).! !

!CrewTest methodsFor: 'tests' stamp: 'sg 5/8/2023 01:16:44'!
test02MovingCrewToTreePlaceFilibusteroRemovesTree

	| island crew treePosition crewPosition map |
	crewPosition := 1@1.
	treePosition := 1@2.
	self setUpScenarioWithTreesAt: (OrderedCollection with: treePosition) digsAt: ((OrderedCollection with: 3@3)) andMapSize: 3@3 andCrewPositionedAt: crewPosition.

	self deny: (island isEmptyAt: treePosition).
				
	crew moveTo: treePosition.

	self assert: (island isEmptyAt: treePosition).
	self deny: (island hasCrewAt: treePosition).
	self assert: (island hasCrewAt: crewPosition).! !

!CrewTest methodsFor: 'tests' stamp: 'sg 5/7/2023 21:28:11'!
test03MovingCrewToFreePlace

	| island crew treePosition crewPosition nextPosition map |
	
	crewPosition := 1@1.
	treePosition := 1@2.
	
	island := Island
		sized: 3@3
		treesAt: (OrderedCollection with: treePosition)
		digsAt: (OrderedCollection with: 3@3).
	
	map := Map of: island crewStartsAt: crewPosition.

	crew := self crewAt: island withMap: map withCrewMembersLocatedAt: crewPosition.

	nextPosition := 2@1.
	self assert: (island isEmptyAt: nextPosition).
	
	crew moveTo: nextPosition.

	self deny: (island hasCrewAt: crewPosition).
	self assert: (island hasCrewAt: nextPosition).! !

!CrewTest methodsFor: 'tests' stamp: 'sg 5/7/2023 21:28:30'!
test04MovingCrewToFreePlaceCorsarioWritesDirectionInMap

	| island crew treePosition crewPosition nextPosition map |
	
	crewPosition := 1@1.
	treePosition := 1@2.
	
	island := Island
		sized: 3@3
		treesAt: (OrderedCollection with: treePosition)
		digsAt: (OrderedCollection with: 3@3).
	
	map := Map of: island crewStartsAt: crewPosition.
	
	crew := self crewAt: island withMap: map withCrewMembersLocatedAt: crewPosition.
	
	nextPosition := 2@1.
	self assert: map isEmpty.

	crew moveTo: nextPosition.

	self assert: map stepsSize equals: 1. 
	self assert: map lastPosition equals: nextPosition.
! !

!CrewTest methodsFor: 'tests' stamp: 'sg 5/7/2023 21:28:51'!
test05CrewCannotBuryTreasureIfBucaneroCannotDig

	| island crew treePosition crewPosition map digPosition |
	
	crewPosition := 1@1.
	treePosition := 1@2.
	digPosition := 2@2.
	
	island := Island
		sized: 3@3
		treesAt: (OrderedCollection with: treePosition)
		digsAt: (OrderedCollection with: digPosition).
	
	map := Map of: island crewStartsAt: crewPosition.
	
	crew := self crewAt: island withMap: map withCrewMembersLocatedAt: crewPosition.

	crew moveTo: 2@1.
	
	self 
		should: [ crew buryTreasureAt: 3@1 ] 
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :error | 
			self assert: error messageText equals: Bucanero cannotDigErrorDescription.
			self deny: map hasTreasureMark ]
			
	
	
	
! !

!CrewTest methodsFor: 'tests' stamp: 'sg 5/7/2023 21:29:05'!
test06CrewCanBuryTreasureIfBucaneroCanDig

	| island crew treePosition crewPosition map digPosition |
	
	crewPosition := 1@1.
	treePosition := 1@2.
	digPosition := 2@2.
	
	island := Island
		sized: 3@3
		treesAt: (OrderedCollection with: treePosition)
		digsAt: (OrderedCollection with: digPosition).
	
	map := Map of: island crewStartsAt: crewPosition.
	
	crew := self crewAt: island withMap: map withCrewMembersLocatedAt: crewPosition.
	
	crew moveTo: 2@1.
	crew buryTreasureAt: 2@2.
	
	self assert: map hasTreasureMark.
	
			
	
	
	
! !

!CrewTest methodsFor: 'tests' stamp: 'sg 5/7/2023 21:29:13'!
test07CaptainCanUseMap

	| island crew treePosition crewPosition map digPosition pirate |
	
	crewPosition := 1@1.
	treePosition := 1@2.
	digPosition := 2@2.
	
	island := Island
		sized: 3@3
		treesAt: (OrderedCollection with: treePosition)
		digsAt: (OrderedCollection with: digPosition).
	
	map := Map of: island crewStartsAt: crewPosition.
	
	crew := self crewAt: island withMap: map withCrewMembersLocatedAt: crewPosition.

	crew moveTo: 2@1.
	crew buryTreasureAt: 2@2.

	pirate := Bucanero new.
	pirate aCaptainIWasMeantToBe.
	
	self assert: (pirate searchTreasureIn: island with: map)! !

!CrewTest methodsFor: 'tests' stamp: 'sg 5/7/2023 21:29:19'!
test08SimplePirateCannotUseMap

	| island crew treePosition crewPosition map digPosition pirate |
	
	crewPosition := 1@1.
	treePosition := 1@2.
	digPosition := 2@2.
	
	island := Island
		sized: 3@3
		treesAt: (OrderedCollection with: treePosition)
		digsAt: (OrderedCollection with: digPosition).
	
	map := Map of: island crewStartsAt: crewPosition.
	
	crew := self crewAt: island withMap: map withCrewMembersLocatedAt: crewPosition.

	crew moveTo: 2@1.
	crew buryTreasureAt: 2@2.

	pirate := Bucanero new.
	
	self 
		should: [ pirate searchTreasureIn: island with: map ] 
		raise: Error - MessageNotUnderstood 
		withMessageText: 'I am a simple pirate!!'
! !


!CrewTest methodsFor: 'support' stamp: 'sg 5/7/2023 19:14:16'!
islandWithTreesAt: treePositions sized: islandSize withDigPositionsAt: digPositions

	^ Island
		sized: islandSize
		treesAt: treePositions
		digsAt: digPositions! !


!classDefinition: #Crew category: 'ISW1-2022-2C-1erParcial'!
Object subclass: #Crew
	instanceVariableNames: 'island pirates'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2022-2C-1erParcial'!

!Crew methodsFor: 'as yet unclassified' stamp: 'sg 5/7/2023 20:25:23'!
buryTreasureAt: aPosition

	pirates do: [:pirate |
		pirate buryTreasureAt: aPosition on: island.
	]
		
	
	! !

!Crew methodsFor: 'as yet unclassified' stamp: 'sg 5/8/2023 00:21:43'!
canAllPiratesMoveTo: aPosition

	^ pirates allSatisfy: [:pirate | pirate moveTo1: true otroParametro: true ultParametro: aPosition theIsland: island.]! !

!Crew methodsFor: 'as yet unclassified' stamp: 'sg 5/8/2023 00:21:43'!
ifAllPiratesCanMoveTo: aPosition do: aBlock

	^ (self canAllPiratesMoveTo: aPosition) ifTrue: aBlock! !

!Crew methodsFor: 'as yet unclassified' stamp: 'FRT 9/17/2022 22:53:00'!
initializeWith: anIsland pirates: aPirates at: aPosition

	island := anIsland.
	pirates := aPirates.
	
	island crewAt: aPosition.! !

!Crew methodsFor: 'as yet unclassified' stamp: 'sg 5/8/2023 00:20:19'!
moveTo: aPosition
	
	self ifAllPiratesCanMoveTo: aPosition do: [ island crewAt: aPosition]
	
	"nos movemos si todos pueden moverse"
	
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Crew class' category: 'ISW1-2022-2C-1erParcial'!
Crew class
	instanceVariableNames: ''!

!Crew class methodsFor: 'as yet unclassified' stamp: 'HAW 9/18/2022 19:21:29'!
at: anIsland composedBy: aCrew at: aPosition

	^ self new initializeWith: anIsland pirates: aCrew at: aPosition ! !


!classDefinition: #Island category: 'ISW1-2022-2C-1erParcial'!
Object subclass: #Island
	instanceVariableNames: 'boardSize treesAt digsAt crewAt treasureAt'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2022-2C-1erParcial'!

!Island methodsFor: 'as yet unclassified' stamp: 'sg 5/8/2023 00:40:13'!
clearTerrainAt: aPosition

	treesAt detect: [:position | aPosition = position] ifFound: [:position | ^treesAt remove: position] ifNone: [].
! !

!Island methodsFor: 'as yet unclassified' stamp: 'FRT 9/17/2022 15:37:10'!
crewAt: aPosition

	crewAt := aPosition.! !

!Island methodsFor: 'as yet unclassified' stamp: 'FRT 9/17/2022 15:45:56'!
hasCrewAt: aPosition

	^ crewAt = aPosition.! !

!Island methodsFor: 'as yet unclassified' stamp: 'FRT 9/17/2022 15:23:00'!
initializeSized: size treesAt: treesPositions digsAt: digsPositions

	boardSize := size.
	treesAt := treesPositions.
	digsAt := digsPositions.
! !

!Island methodsFor: 'as yet unclassified' stamp: 'sg 5/8/2023 00:50:22'!
isEmptyAt: aPosition

	treesAt noneSatisfy: [:position | aPosition = position].! !

!Island methodsFor: 'as yet unclassified' stamp: 'FRT 9/17/2022 15:27:44'!
receiveTreasureAt: aPosition

	treasureAt := aPosition.! !

!Island methodsFor: 'as yet unclassified' stamp: 'sg 5/8/2023 00:56:15'!
terrainAt: aPosition

	treesAt detect: [:position | position = aPosition] ifFound: [^ #Tree] ifNone: [].
	digsAt detect: [:position | position = aPosition] ifFound: [^ #Tree] ifNone: [].
 	^ #Empty.
	
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Island class' category: 'ISW1-2022-2C-1erParcial'!
Island class
	instanceVariableNames: ''!

!Island class methodsFor: 'as yet unclassified' stamp: 'FRT 9/17/2022 15:46:50'!
sized: size treesAt: treesPositions digsAt: digsPositions

	^ self new initializeSized: size treesAt: treesPositions digsAt: digsPositions 
! !


!classDefinition: #Map category: 'ISW1-2022-2C-1erParcial'!
Object subclass: #Map
	instanceVariableNames: 'island startPosition steps treasureMarkPosition'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2022-2C-1erParcial'!

!Map methodsFor: 'as yet unclassified' stamp: 'sg 5/8/2023 00:58:42'!
hasTreasureMark

	^ treasureMarkPosition isNotNil.
	
	! !

!Map methodsFor: 'as yet unclassified' stamp: 'FRT 9/17/2022 16:30:31'!
initializeWith: anIsland crewStartsAt: aPosition

	island := anIsland.
	startPosition := aPosition.
	steps := OrderedCollection new.
	
	! !

!Map methodsFor: 'as yet unclassified' stamp: 'FRT 9/17/2022 16:43:52'!
isEmpty

	^ steps isEmpty
	
	! !

!Map methodsFor: 'as yet unclassified' stamp: 'sg 5/8/2023 01:02:15'!
lastPosition

	| acc|
	
	acc := startPosition.

	steps do: [:position | acc := acc + (steps at: position)].

	^ acc
	
	! !

!Map methodsFor: 'as yet unclassified' stamp: 'FRT 9/17/2022 16:39:01'!
nextStep: step

	^ steps add: step.
	
	! !

!Map methodsFor: 'as yet unclassified' stamp: 'FRT 9/17/2022 16:33:43'!
startPosition

	^ startPosition
	
	! !

!Map methodsFor: 'as yet unclassified' stamp: 'FRT 9/17/2022 16:32:59'!
step: ix

	^ steps at: ix.
	
	! !

!Map methodsFor: 'as yet unclassified' stamp: 'FRT 9/17/2022 16:32:23'!
stepsSize

	^ steps size.
	
	! !

!Map methodsFor: 'as yet unclassified' stamp: 'FRT 9/17/2022 19:01:06'!
treasureMarkAt: aPosition

	treasureMarkPosition := aPosition.
	
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Map class' category: 'ISW1-2022-2C-1erParcial'!
Map class
	instanceVariableNames: ''!

!Map class methodsFor: 'as yet unclassified' stamp: 'FRT 9/17/2022 16:28:38'!
of: island crewStartsAt: aPosition.

	^ self new initializeWith: island crewStartsAt: aPosition.! !


!classDefinition: #Pirate category: 'ISW1-2022-2C-1erParcial'!
Object subclass: #Pirate
	instanceVariableNames: 'rank'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2022-2C-1erParcial'!

!Pirate methodsFor: 'as yet unclassified' stamp: 'sg 5/7/2023 20:36:05'!
aCaptainIWasMeantToBe

	rank := #Captain! !

!Pirate methodsFor: 'as yet unclassified' stamp: 'sg 5/7/2023 20:27:15'!
buryTreasureAt: aPosition on: island
	
	self subclassResponsibility! !

!Pirate methodsFor: 'as yet unclassified' stamp: 'sg 5/7/2023 23:59:38'!
canMoveToDiggableTerrain
	
	self subclassResponsibility. ! !

!Pirate methodsFor: 'as yet unclassified' stamp: 'sg 5/8/2023 00:00:12'!
canMoveToEmptyTerrain
	
	^true. ! !

!Pirate methodsFor: 'as yet unclassified' stamp: 'sg 5/7/2023 23:59:49'!
canMoveToTreeTerrain
	
	self subclassResponsibility. ! !

!Pirate methodsFor: 'as yet unclassified' stamp: 'sg 5/7/2023 20:38:23'!
initialize

	self subclassResponsibility! !

!Pirate methodsFor: 'as yet unclassified' stamp: 'sg 5/8/2023 00:09:17'!
moveTo1: acc otroParametro: terrain ultParametro: aPosition theIsland: island
	
	^terrain canThisPirate: self moveTo: aPosition on: island.
	! !


!classDefinition: #Bucanero category: 'ISW1-2022-2C-1erParcial'!
Pirate subclass: #Bucanero
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2022-2C-1erParcial'!

!Bucanero methodsFor: 'as yet unclassified' stamp: 'sg 5/7/2023 20:23:44'!
buryTreasureAt: aPosition on: island

	| terrain |
	
	terrain := island terrainAt: aPosition.

	terrain = #Tree ifTrue: [ self error: 'Arrgh!! I cannot dig this type of terrain!!' ].
	terrain = #Empty ifTrue: [ self error: 'Arrgh!! I cannot dig this type of terrain!!' ]	.
	terrain = #Diggable ifTrue: [ island receiveTreasureAt: aPosition ].! !

!Bucanero methodsFor: 'as yet unclassified' stamp: 'sg 5/8/2023 00:05:47'!
canMoveToDiggableTerrain
	
	^true! !

!Bucanero methodsFor: 'as yet unclassified' stamp: 'sg 5/8/2023 00:06:14'!
canMoveToTreeTerrain
	
	^false! !

!Bucanero methodsFor: 'as yet unclassified' stamp: 'sg 5/7/2023 20:36:18'!
initialize

	rank := #SimplePirate! !

!Bucanero methodsFor: 'as yet unclassified' stamp: 'sg 5/8/2023 00:08:48'!
moveTo1: acc otroParametro: terrain ultParametro: aPosition theIsland: island
	
	^terrain canThisPirate: self moveTo: aPosition on: island.
	! !

!Bucanero methodsFor: 'as yet unclassified' stamp: 'FRT 9/18/2022 15:01:19'!
searchTreasureIn: island with: aMap

	rank = #SimplePirate ifTrue: [ self error: 'I am a simple pirate!!' ].
	rank = #Captain ifTrue: [ ^ true "Aye, Aye!! La implementación está fuera del scope del parcial." ].
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Bucanero class' category: 'ISW1-2022-2C-1erParcial'!
Bucanero class
	instanceVariableNames: ''!

!Bucanero class methodsFor: 'as yet unclassified' stamp: 'FRT 9/17/2022 17:12:39'!
cannotDigErrorDescription

	^ 'Arrgh!! I cannot dig this type of terrain!!'.! !


!classDefinition: #Corsario category: 'ISW1-2022-2C-1erParcial'!
Pirate subclass: #Corsario
	instanceVariableNames: 'map'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2022-2C-1erParcial'!

!Corsario methodsFor: 'as yet unclassified' stamp: 'sg 5/7/2023 20:24:21'!
buryTreasureAt: aPosition on: anIsland 
	
	| terrain |
	
	terrain := anIsland terrainAt: aPosition.	
	
	terrain = #Diggable ifTrue: [ 				self drawTreasureMarkAt: aPosition ]! !

!Corsario methodsFor: 'as yet unclassified' stamp: 'FRT 9/17/2022 22:43:57'!
drawDirectionTo: aPosition

	map nextStep: aPosition - (map lastPosition).
	
! !

!Corsario methodsFor: 'as yet unclassified' stamp: 'FRT 9/17/2022 19:01:22'!
drawTreasureMarkAt: aPosition

	map nextStep: aPosition - map lastPosition.
	map treasureMarkAt: aPosition.
	
! !

!Corsario methodsFor: 'as yet unclassified' stamp: 'sg 5/7/2023 20:37:06'!
initialize

	rank := #NoRank! !

!Corsario methodsFor: 'as yet unclassified' stamp: 'FRT 9/17/2022 20:32:06'!
initializeWith: aMap

	rank := #SimplePirate.
	map := aMap! !

!Corsario methodsFor: 'as yet unclassified' stamp: 'sg 5/7/2023 21:01:15'!
moveTo1: acc otroParametro: terrain ultParametro: aPosition theIsland: island
			
	| acc1 |
	
	terrain = #Tree ifTrue: [ acc1 := acc & false ].
	terrain = #Empty ifTrue: [ 
		self drawDirectionTo: aPosition.
		acc1 := acc & true 
	].
	terrain = #Diggable ifTrue: [ acc1 := acc & true ].
	
	^acc1! !

!Corsario methodsFor: 'as yet unclassified' stamp: 'FRT 9/18/2022 15:01:27'!
searchTreasureIn: island with: aMap

	rank = #SimplePirate ifTrue: [ self error: 'I am a simple pirate!!' ].
	rank = #Captain ifTrue: [ ^ true "Aye, Aye!! La implementación está fuera del scope del parcial." ].
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Corsario class' category: 'ISW1-2022-2C-1erParcial'!
Corsario class
	instanceVariableNames: ''!

!Corsario class methodsFor: 'as yet unclassified' stamp: 'FRT 9/15/2022 21:46:08'!
with: aMap

	^ self new initializeWith: aMap.! !


!classDefinition: #Filibustero category: 'ISW1-2022-2C-1erParcial'!
Pirate subclass: #Filibustero
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2022-2C-1erParcial'!

!Filibustero methodsFor: 'as yet unclassified' stamp: 'sg 5/7/2023 20:25:00'!
buryTreasureAt: aPosition on: anIsland! !

!Filibustero methodsFor: 'as yet unclassified' stamp: 'sg 5/7/2023 20:37:11'!
initialize

	rank := #SimplePirate! !

!Filibustero methodsFor: 'as yet unclassified' stamp: 'sg 5/7/2023 21:03:09'!
moveTo1: acc otroParametro: terrain ultParametro: aPosition theIsland: island
	
	| acc1|
	terrain = #Tree ifTrue: [ 
		island clearTerrainAt: aPosition.
		acc1 := acc & false
	].
	terrain = #Empty ifTrue: [ acc1 := acc & true ].
	terrain = #Diggable ifTrue: [ acc1 := acc & true ].
	
	^acc1! !

!Filibustero methodsFor: 'as yet unclassified' stamp: 'FRT 9/18/2022 15:01:34'!
searchTreasureIn: island with: aMap

	rank = #SimplePirate ifTrue: [ self error: 'I am a simple pirate!!' ].
	rank = #Captain ifTrue: [ ^ true "Aye, Aye!! La implementación está fuera del scope del parcial." ].
	! !


!classDefinition: #Terrain category: 'ISW1-2022-2C-1erParcial'!
Object subclass: #Terrain
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2022-2C-1erParcial'!

!Terrain methodsFor: 'as yet unclassified' stamp: 'sg 5/7/2023 23:48:49'!
canThisPirate: aPirate moveTo: aPosition on: anIsland
	self subclassResponsibility.! !


!classDefinition: #DiggableTerrain category: 'ISW1-2022-2C-1erParcial'!
Terrain subclass: #DiggableTerrain
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2022-2C-1erParcial'!

!DiggableTerrain methodsFor: 'as yet unclassified' stamp: 'sg 5/7/2023 23:53:04'!
canThisPirate: aPirate moveTo: aPosition on: anIsland
	
	^aPirate canMoveToDiggableTerrain.! !


!classDefinition: #EmptyTerrain category: 'ISW1-2022-2C-1erParcial'!
Terrain subclass: #EmptyTerrain
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2022-2C-1erParcial'!

!EmptyTerrain methodsFor: 'as yet unclassified' stamp: 'sg 5/7/2023 23:52:35'!
canThisPirate: aPirate moveTo: aPosition on: anIsland
	
	^aPirate canMoveToEmptyTerrain.! !


!classDefinition: #TreeTerrain category: 'ISW1-2022-2C-1erParcial'!
Terrain subclass: #TreeTerrain
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2022-2C-1erParcial'!

!TreeTerrain methodsFor: 'as yet unclassified' stamp: 'sg 5/7/2023 23:53:16'!
canThisPirate: aPirate moveTo: aPosition on: anIsland
	
	^aPirate canMoveToTreeTerrain.! !
