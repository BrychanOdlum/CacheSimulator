//
//  Cache.swift
//  SwiftCacheSimulator
//
//  Created by Brychan Bennett-Odlum on 13/03/2018.
//  Copyright © 2018 Brychan Bennett-Odlum. All rights reserved.
//

import Foundation

class Cache {
	var blocks: [Block] = []

	let metadata: Metadata
	
	init(metadata: Metadata) {
		self.metadata = metadata
	}
	
	func access(address: Address) -> Bool {
		// Find BLOCK with INDEX
		let index = address.index

		var block: Block! = nil

		for b in blocks {
			if b.index == index {
				block = b
				break
			}
		}

		if block == nil {
			block = Block(index: address.index, metadata: metadata)
			blocks.append(block)
		}

		return block.access(address: address)
	}
	
}
