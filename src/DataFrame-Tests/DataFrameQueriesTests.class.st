Class {
	#name : #DataFrameQueriesTests,
	#superclass : #TestCase,
	#instVars : [
		'df'
	],
	#category : 'DataFrame-Tests'
}

{ #category : #initialization }
DataFrameQueriesTests >> setUp [

	df := DataFrame fromRows: #(
		(x 10 0.25 0.1)
		(y 20 0.75 0.4)
		(x 40 0.3 0.2)
		(y 35 0.15 0.1)
		(x 10 0 0)).
		
	df columnNames: #(a b c d).
]

{ #category : #initialization }
DataFrameQueriesTests >> testGroupbyAggregate [

	| actual expected |
	
	actual := df groupBy: #a aggregate: #sum.
	
	expected := DataFrame fromRows: #(
		(60 0.55 0.3)
		(55 0.9 0.5)).
		
	expected columnNames: #(b c d).
	expected rowNames: #(x y).
	
	self assert: actual closeTo: expected.
]

{ #category : #initialization }
DataFrameQueriesTests >> testSelect [

	| actual expected |
	
	actual := df
		select: [ :row |
			(row atKey: #a) = 'x' and: (row atKey: #b) < 30 ].
		
	expected := DataFrame fromRows: #(
		(x 10 0.25 0.1)
		(x 10 0 0)).
	expected columnNames: #(a b c d).
	expected rowNames: #(1 5).
	
	self assert: actual equals: expected.
]