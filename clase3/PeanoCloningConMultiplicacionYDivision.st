!classDefinition: #I category: 'PeanoCloning'!
DenotativeObject subclass: #I
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PeanoCloning'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'I class' category: 'PeanoCloning'!
I class
	instanceVariableNames: ''!

!I class methodsFor: 'private' stamp: 'JFGO 3/25/2023 19:00:37'!
next
	^II.! !

!I class methodsFor: 'private' stamp: 'JFGO 3/25/2023 19:59:30'!
subtractFrom: aNaturalNumber
	^aNaturalNumber previous.! !


!I class methodsFor: 'arithmetic operations' stamp: 'sg 3/29/2023 21:38:57'!
* aNaturalNumber
	^aNaturalNumber.! !

!I class methodsFor: 'arithmetic operations' stamp: 'JFGO 3/25/2023 19:13:50'!
+ aNaturalNumber
	^aNaturalNumber next.! !

!I class methodsFor: 'arithmetic operations' stamp: 'sg 3/29/2023 22:14:44'!
/ aNaturalNumber
	(aNaturalNumber == self) ifTrue: [^self].
	^'nope'! !


!classDefinition: #II category: 'PeanoCloning'!
DenotativeObject subclass: #II
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PeanoCloning'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'II class' category: 'PeanoCloning'!
II class
	instanceVariableNames: 'next previous'!

!II class methodsFor: 'arithmetic operations' stamp: 'sg 3/29/2023 21:39:45'!
* aNaturalNumber
	^aNaturalNumber + aNaturalNumber.! !

!II class methodsFor: 'arithmetic operations' stamp: 'JFGO 3/25/2023 19:27:09'!
+ aNaturalNumber
	^self previous + aNaturalNumber next.! !

!II class methodsFor: 'arithmetic operations' stamp: 'JFGO 3/25/2023 19:58:08'!
- aNaturalNumber
	^aNaturalNumber subtractFrom: self.! !

!II class methodsFor: 'arithmetic operations' stamp: 'sg 3/30/2023 01:43:01'!
/ aNaturalNumber
	(aNaturalNumber == self) ifTrue: [^I.].
	(aNaturalNumber == I) ifTrue: [^self].
	^'nope'! !


!II class methodsFor: 'private auxiliary operations' stamp: 'JFGO 3/26/2023 11:19:10'!
next
	next ifNil: [
		next := self cloneNamed: self name, 'I'. 
		next previous: self.		
		].
	
	^next.! !

!II class methodsFor: 'private auxiliary operations' stamp: 'JFGO 3/25/2023 19:25:46'!
previous
	^previous.! !

!II class methodsFor: 'private auxiliary operations' stamp: 'JFGO 3/25/2023 19:36:52'!
previous: aNaturalNumber
	previous:=aNaturalNumber.! !

!II class methodsFor: 'private auxiliary operations' stamp: 'JFGO 3/25/2023 20:54:19'!
subtractFrom: aNaturalNumber
	^aNaturalNumber previous - self previous.! !


!II class methodsFor: '--** private fileout/in **--' stamp: 'sg 3/30/2023 01:55:25'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := III.
	previous := I.! !


!classDefinition: #III category: 'PeanoCloning'!
DenotativeObject subclass: #III
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PeanoCloning'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'III class' category: 'PeanoCloning'!
III class
	instanceVariableNames: 'next previous'!

!III class methodsFor: 'arithmetic operations' stamp: 'sg 3/29/2023 21:42:29'!
* aNaturalNumber
	^aNaturalNumber + (self previous * aNaturalNumber)! !

!III class methodsFor: 'arithmetic operations' stamp: 'sg 3/29/2023 21:39:07'!
+ aNaturalNumber
	^self previous + aNaturalNumber next.! !

!III class methodsFor: 'arithmetic operations' stamp: 'sg 3/29/2023 21:39:07'!
- aNaturalNumber
	^aNaturalNumber subtractFrom: self.! !

!III class methodsFor: 'arithmetic operations' stamp: 'sg 3/30/2023 01:46:42'!
/ aNaturalNumber
	(aNaturalNumber == self) ifTrue: [^I.].
	(aNaturalNumber == I) ifTrue: [^self].
	^'nope'! !


!III class methodsFor: 'private auxiliary operations' stamp: 'sg 3/29/2023 21:39:07'!
next
	next ifNil: [
		next := self cloneNamed: self name, 'I'. 
		next previous: self.		
		].
	
	^next.! !

!III class methodsFor: 'private auxiliary operations' stamp: 'sg 3/29/2023 21:39:07'!
previous
	^previous.! !

!III class methodsFor: 'private auxiliary operations' stamp: 'sg 3/29/2023 21:39:07'!
previous: aNaturalNumber
	previous:=aNaturalNumber.! !

!III class methodsFor: 'private auxiliary operations' stamp: 'sg 3/29/2023 21:39:07'!
subtractFrom: aNaturalNumber
	^aNaturalNumber previous - self previous.! !


!III class methodsFor: '--** private fileout/in **--' stamp: 'sg 3/30/2023 01:55:25'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := IIII.
	previous := II.! !


!classDefinition: #IIII category: 'PeanoCloning'!
DenotativeObject subclass: #IIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PeanoCloning'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIII class' category: 'PeanoCloning'!
IIII class
	instanceVariableNames: 'next previous'!

!IIII class methodsFor: 'arithmetic operations' stamp: 'sg 3/30/2023 01:47:38'!
* aNaturalNumber
	^aNaturalNumber + (self previous * aNaturalNumber)! !

!IIII class methodsFor: 'arithmetic operations' stamp: 'sg 3/30/2023 01:47:38'!
+ aNaturalNumber
	^self previous + aNaturalNumber next.! !

!IIII class methodsFor: 'arithmetic operations' stamp: 'sg 3/30/2023 01:47:38'!
- aNaturalNumber
	^aNaturalNumber subtractFrom: self.! !

!IIII class methodsFor: 'arithmetic operations' stamp: 'sg 3/30/2023 01:51:55'!
/ aNaturalNumber
	(aNaturalNumber == self) ifTrue: [^I.].
	(aNaturalNumber == I) ifTrue: [^self].
	^I + ((self - aNaturalNumber ) / aNaturalNumber ).
	! !


!IIII class methodsFor: 'private auxiliary operations' stamp: 'sg 3/30/2023 01:47:38'!
next
	next ifNil: [
		next := self cloneNamed: self name, 'I'. 
		next previous: self.		
		].
	
	^next.! !

!IIII class methodsFor: 'private auxiliary operations' stamp: 'sg 3/30/2023 01:47:38'!
previous
	^previous.! !

!IIII class methodsFor: 'private auxiliary operations' stamp: 'sg 3/30/2023 01:47:38'!
previous: aNaturalNumber
	previous:=aNaturalNumber.! !

!IIII class methodsFor: 'private auxiliary operations' stamp: 'sg 3/30/2023 01:47:38'!
subtractFrom: aNaturalNumber
	^aNaturalNumber previous - self previous.! !


!IIII class methodsFor: '--** private fileout/in **--' stamp: 'sg 3/30/2023 01:55:25'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := nil.
	previous := III.! !

II initializeAfterFileIn!
III initializeAfterFileIn!
IIII initializeAfterFileIn!