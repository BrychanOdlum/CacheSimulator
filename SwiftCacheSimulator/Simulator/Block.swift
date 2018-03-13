//
//  Block.swift
//  SwiftCacheSimulator
//
//  Created by Brychan Bennett-Odlum on 13/03/2018.
//  Copyright © 2018 Brychan Bennett-Odlum. All rights reserved.
//

import Foundation

class Block {
	let index: String
	var lines: [Line] = []

	let metadata: Metadata
	
	init(index: String, metadata: Metadata) {
		self.index = index
		self.metadata = metadata
	}
	
	func access(address: Address) -> Bool {
		var found = false

		// Find line if in block, update last access
		for line in lines {
			if line.isInLine(address: address) {
				line.lastAccess = Date()
				found = true
			}
		}

		// Add line if not in block
		if !found {
			let line = Line()
			line.addresses.append(address)
			lines.append(line)
		}

		lines.sort(by: { $0.lastAccess > $1.lastAccess })

		// If block is too big then remove smallest row.
		if lines.count > metadata.linesPerBlock {
			lines.removeLast()
		}

		return found
	}
	
}
