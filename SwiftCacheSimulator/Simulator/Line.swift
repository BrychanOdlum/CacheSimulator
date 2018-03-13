//
// Created by Brychan Bennett-Odlum on 13/03/2018.
// Copyright (c) 2018 Brychan Bennett-Odlum. All rights reserved.
//

import Foundation

class Line {
	var addresses: [Address] = []
	var lastAccess: Date = Date()

	func isInLine(address: Address) -> Bool {
		for a in addresses {
			if a.tag == address.tag {
				return true
			}
		}

		return false
	}

}