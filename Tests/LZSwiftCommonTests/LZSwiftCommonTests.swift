import Testing
@testable import LZSwiftCommon






@Test
func
optionalAssignment()
	async
	throws
{
	var foo = 123
	var bar: Optional<Int> = 123
	var newVal: Optional<Int> = nil
	
	foo ??= newVal
	bar ??= newVal
	#expect(foo == 123)
	#expect(bar == 123)
	
	newVal = 321
	foo ??= newVal
	bar ??= newVal
	#expect(foo == 321)
	#expect(bar == 321)
}
