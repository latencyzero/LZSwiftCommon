// The Swift Programming Language
// https://docs.swift.org/swift-book

import Foundation


public
extension
UUID
{
	/**
		Returns a ``UUID`` as ``Data``.
	*/
	
	var
	data: Data
	{
		return withUnsafePointer(to: self.uuid)
		{
			Data(bytes: $0, count: MemoryLayout.size(ofValue: self.uuid))
		}
	}
}

public
extension
Data
{
	/**
		Creates a string of formatted hex bytes for the data.
	*/
	
	func
	hexCharDump(bytesPerLine inBPL: Int = 16)
		-> String
	{
//		let conv = String("␀␁␂␃␄␅.................␗␙.......〿!\"#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_`abcdefghijklmnopqrstuvwxyz{|}~")
		let conv = String("................................ !\"#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_`abcdefghijklmnopqrstuvwxyz{|}~")
		
		var dump = ""
		
		let maxCount = Swift.min(self.count, 256)
		
		let bpl = inBPL > 0 ? inBPL : 8
		let lines = maxCount / bpl + (maxCount % bpl > 0 ? 1 : 0)
		for line in 0 ..< lines
		{
			let start = line * bpl
			let count = Swift.min(maxCount - start, bpl)
			let end = start + count
			
			//	Dump the hex bytes…
			
			var dumpLine = String(format: "%08llx: ", start)
			for c in start ..< start + bpl
			{
				if c < end
				{
					dumpLine += String(format: "%02x ", self[c])
				}
				else
				{
					dumpLine += "   "
				}
				
				if (c+1) % 8 == 0
				{
					dumpLine += "  "
				}
			}
			
//			dumpLine += ""
			
			//	Dump the ASCII…
			
			for c in start ..< end
			{
				let ch: Character
				if c < conv.count
				{
					ch = conv[conv.index(conv.startIndex, offsetBy: c)]
				}
				else
				{
					ch = "."
				}
				
				dumpLine.append(ch)
				
				if (c+1) % 8 == 0
				{
					dumpLine += " "
				}
			}
			
			//	Append the line…
			
			dump += dumpLine + "\n"
		}
		
		if self.count > maxCount
		{
			dump += "…\(self.count - maxCount) bytes omitted…\n"
		}
		return dump
	}
	
	/**
		Creates a simple hex representation of the data.
		
		From [SO](https://stackoverflow.com/a/62465044/251914).
	*/
	
	var
	hexEncodedString: String
	{
		return self.reduce(into:"")
		{ result, byte in
			result.append(String(byte >> 4, radix: 16))
			result.append(String(byte & 0x0f, radix: 16))
		}
	}
}
