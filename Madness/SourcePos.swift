//  Copyright (c) 2014 Josh Vera. All rights reserved.

import Prelude

public typealias Line = Int
public typealias Column = Int

public struct SourcePos<Index: ForwardIndexType>: Equatable {

	public let line: Line
	public let column: Column
	public let index: Index
	
	public init(index: Index) {
		line = 1
		column = 1
		self.index = index
	}
	
	public init(line: Line, column: Column, index: Index) {
		self.line = line
		self.column = column
		self.index = index
	}

}
	
public func ==<Index>(first: SourcePos<Index>, other: SourcePos<Index>) -> Bool {
	return first.line == other.line && first.column == other.line && first.line == other.line
}

public func updateIndex<Index: ForwardIndexType>(pos: SourcePos<Index>, _ index: Index) -> SourcePos<Index> {
	return SourcePos.init(line: pos.line, column: pos.column, index: index)
}

public func updatePosCharacter(pos: SourcePos<String.Index>, _ char: Character) -> SourcePos<String.Index> {
	let nextIndex = pos.index.successor()
	if char == "\n" {
		return SourcePos(line: pos.line + 1, column: pos.column, index: nextIndex)
	} else if char == "\t" {
		return SourcePos(line: pos.line, column: pos.column + 8 - ((pos.column - 1) % 8), index: nextIndex)
	} else {
		return SourcePos(line: pos.line, column: pos.column + 1, index: nextIndex)
	}
}

func updatePosString(pos: SourcePos<String.Index>, string: String) -> SourcePos<String.Index> {
	return string.characters.reduce(pos, combine: updatePosCharacter)
}