//
//  Address.swift
//  SwiftCacheSumulator
//
//  Created by Brychan Bennett-Odlum on 09/03/2018.
//  Copyright © 2018 Brychan Bennett-Odlum. All rights reserved.
//

import Foundation

class Address {
	let address: UInt64
	
	let binaryAddress: String
	
	let tag: String
	let index: String
	let offset: String
	
	init(address: UInt64, metadata: Metadata) {
		self.address = address
		
		let rawAddr = String(address, radix: 2)
		let padding = String(repeating: "0", count: (metadata.bitsPerWord - rawAddr.count))
		
		binaryAddress = padding + rawAddr

		let tagLength = metadata.bitsPerWord - (metadata.indexLength + metadata.offsetLength)

		self.tag = binaryAddress[0 ..< tagLength]
		self.index = binaryAddress[tagLength ..< tagLength+metadata.indexLength]
		self.offset = binaryAddress[tagLength+metadata.indexLength ..< tagLength+metadata.indexLength+metadata.offsetLength]
	}
}

extension String {
	subscript(_ range: CountableRange<Int>) -> String {
		let lower = index(startIndex, offsetBy: range.lowerBound)
		let upper = index(startIndex, offsetBy: range.upperBound)
		return String(self[lower..<upper])
	}
}
