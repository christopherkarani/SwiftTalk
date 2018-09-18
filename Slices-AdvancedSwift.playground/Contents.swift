
extension Substring {
    /// Find the next word range from the given substring
    var nextWordRange: Range<Index> {
        // the substring with the leading spaces removed
        let start = drop(while: { $0 == " "})
        let end = start.index(where: { $0 == " "}) ?? endIndex
        return start.startIndex..<end
    }
    
    /// Find the next word in the range, where the predicate is the word boundry
    func nextWordRange(predicate: (Character) -> Bool) -> Range<Index> {
        let start = drop(while: predicate)
        let end = start.index(where: predicate ) ?? endIndex
        return start.startIndex ..< end
    }
}


/// A wrapper around Range<Substring.Index>, Used in the Words collection to find the Index of the next word in a String
/// Index's Must be Comparable, so we conform to this protocol
struct WordsIndex: Comparable {
    let range: Range<Substring.Index>
    
    init(range: Range<Substring.Index>) {
        self.range = range
    }
    
    static func <(_ lhs: WordsIndex, _ rhs: WordsIndex) -> Bool {
        return lhs.range.lowerBound < rhs.range.lowerBound
    }
    
    static func ==(_ lhs: WordsIndex, _ rhs: WordsIndex) -> Bool {
        return lhs.range == rhs.range
    }
}

struct Words: Collection {
    /// The string to be transformed into a words collection
    let string: Substring
    
    /// THe start Index of the Words Collection.
    let startIndex : WordsIndex
    
    
    /// A string initializer that calls a private initializer
    init(_ s: String) {
        self.init(s: s[...])
    }
    
    /// This collection works iwth substrings, but since String is the more common type, we cresate this private initializer to hide
    /// this implementation detail and initialize the properties of the struct
    private init(s: Substring) {
        self.string = s
        self.startIndex = WordsIndex(range: string.nextWordRange)
    }

    var endIndex: WordsIndex {
        let e = string.endIndex
        return WordsIndex(range: e..<e)
    }
}

extension Words {
    /// A subscript wrapper around the Substring property in Words Collection
    subscript(index: WordsIndex) -> Substring {
        return string[index.range]
    }
}


extension Words {
    /// The range upper bound is not included, else we take the end index.
    /// otherwise we take the substring from the upper bound onwards
    func index(after i: WordsIndex) -> WordsIndex {
        guard i.range.upperBound < string.endIndex else { return endIndex }
        let remainder = string[i.range.upperBound...]
        return WordsIndex(range: remainder.nextWordRange)
    }
}


extension Words {
    subscript (range: Range<Index>) -> Words {
        let start = range.lowerBound.range.lowerBound
        let end = range.upperBound.range.upperBound
        return Words(String(string[start..<end]))
    }
}


// Slices

let words: Words = Words("One Two Three")
let onePastStart = words.index(after: words.startIndex)
let suf = words.suffix(from: onePastStart)

struct PrefixIterator<Base: Collection>: IteratorProtocol, Sequence {
    let base: Base
    var offset: Base.Index
    
    init(_ b: Base) {
        self.base = b
        self.offset = base.startIndex
    }
    
    mutating func next() -> Base.SubSequence? {
        guard offset != base.endIndex else { return nil }
        base.formIndex(after: &offset)
        return base.prefix(upTo: offset)
    }
}
