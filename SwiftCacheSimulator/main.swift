//
//  main.swift
//  SwiftCacheSumulator
//
//  Created by Brychan Bennett-Odlum on 09/03/2018.
//  Copyright © 2018 Brychan Bennett-Odlum. All rights reserved.
//

import Foundation


let debug = false

print("Running...")

let baseDir = URL(fileURLWithPath: "/Users/brychan/Developer/SwiftCacheSumulator/SwiftCacheSumulator/data/", isDirectory: true)

let inputDir = baseDir.appendingPathComponent("in", isDirectory: true)
let outputDir = baseDir.appendingPathComponent("out", isDirectory: true)

let fm = FileManager.default

do {

	let files = try fm.contentsOfDirectory(at: inputDir, includingPropertiesForKeys: nil, options: [])
	
	for file in files {
		let s = try String(contentsOf: file)
		
		var lines = s.split(separator: "\n")
		
		// HEADER DATA: W C B k
		let header = lines[0].split(separator: " ")
		let head_bitsPerWord = Int(header[0])!		// W - number of bits per word; multiple of 8
		let head_cacheSize = UInt64(header[1])!		// C - number of data bytes in cache; power of 2
		let head_bytesPerBlock = UInt64(header[2])!	// B - number of bytes per block; divisor of C
		let head_linesPerBlock = UInt64(header[3])!	// k - number of lines per block; divisor of B
		
		let bytesPerLine = head_bytesPerBlock / head_linesPerBlock

		let indexLength = Int(log2(Double(head_cacheSize / head_bytesPerBlock)))
		let offsetLength = Int(log2(Double(head_bytesPerBlock / head_linesPerBlock)))

		print("Index length: \(indexLength)")
		print("Offset length: \(offsetLength)")

		let metadata = Metadata(
				bitsPerWord: head_bitsPerWord,
				cacheSize: head_cacheSize,
				bytesPerBlock: head_bytesPerBlock,
				linesPerBlock: head_linesPerBlock,
				bytesPerLine: bytesPerLine,
				indexLength: indexLength,
				offsetLength: offsetLength
		)
		
		// MEMORY ACCESSES:
		let accesses = lines[1..<lines.count].map {
			Address(address: UInt64($0)!, metadata: metadata)
		}

		let cache = Cache(metadata: metadata)

		var output = ""
		for access in accesses {
			let res = cache.access(address: access)
			output += res ? "C" : "M"
			output += "\n"
		}

		let outputFile = outputDir.appendingPathComponent(String(file.pathComponents.last!.split(separator: ".")[0]) + ".out")
		print(outputFile.absoluteString)
		try output.write(to: outputFile, atomically: false, encoding: .utf8)

		
		if debug {
			break
		}
	}
	
} catch {
	print("Whoopsies, looks like you dun gone goofed up.")
	print(error)
}
