//
//  OptionalAssigment.swift
//  
//
//  Created by Rick Mann on 2022-05-16.
//



/**
	Assigns to the left-hand side only if the right-hand side is non-nil.
	
	This operator allows assignments of the form
	
	```swift
	let newFoo: Optional<> = …	//	<something that might be nil>
	foo = newFoo ?? foo			//	Only assigns if newFoo is not nil,
								//	otherwise value remains unchanged.
	```
	
	to be written with the following, more compact notation:
	
	```swift
	foo ??= newFoo
	```
*/

@discardableResult
public
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

infix operator ??= : AssignmentPrecedence


public
extension
Optional
{
	/**
		In order to have `Optional` types on the left-hand side of the
		assignment, this extension is necessary.
	*/

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

/**
	Shortcut for logical-or assignment.
	
	This should move elsewhere.
*/

public
func
||=(lhs: inout Bool, rhs: Bool)
{
	lhs = lhs || rhs
}

infix operator ||= : AssignmentPrecedence

