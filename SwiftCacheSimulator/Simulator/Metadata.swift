//
// Created by Brychan Bennett-Odlum on 13/03/2018.
// Copyright (c) 2018 Brychan Bennett-Odlum. All rights reserved.
//

import Foundation

struct Metadata {
	let bitsPerWord: Int
	let cacheSize: UInt64
	let bytesPerBlock: UInt64
	let linesPerBlock: UInt64

	let bytesPerLine: UInt64

	let indexLength: Int
	let offsetLength: Int
}