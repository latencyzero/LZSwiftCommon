//
//  OptionalAssigment.swift
//  
//
//  Created by Rick Mann on 2022-05-16.
//



/**
	Declare conformance to types to allow compact assignments of the form:
	
	```swift
	let newFoo: Optional<> = …	//	<something that might be nil>
	foo = newFoo ?? foo			//	Only assigns if newFoo is not nil,
								//	otherwise value remains unchanged.
	```
	
	With the following, more compact notation:
	
	```swift
	foo ??= newFoo
	```
*/

infix operator ??= : AssignmentPrecedence

@discardableResult
func
??=<T>(lhs: inout T, rhs: T?)
	-> Bool
	where T : Equatable
{
	var didChange = false
	
	if let v = rhs
	{
		didChange = lhs != v
		lhs = v
	}
	
	return didChange
}

/**
	In order to have `Optional` types on the left-hand side of the
	assignment, this extension is necessary.
*/

extension
Optional
{
	static
	func
	??=(lhs: inout Optional, rhs: Optional)
	{
		if let v = rhs
		{
			lhs = v
		}
	}
}

infix operator ||= : AssignmentPrecedence

func
||=(lhs: inout Bool, rhs: Bool)
{
	lhs = lhs || rhs
}
