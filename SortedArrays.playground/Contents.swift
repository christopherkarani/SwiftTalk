import Foundation

struct SortecArray<Element> {
    var elements: [Element]
    var areInIncreasingOrder: (Element, Element) -> Bool
    
    
    mutating func append(_ element: Element) {
        elements.append(element)
        elements.sort(by: areInIncreasingOrder)
    }
    
    init<S: Sequence>(_ s: S, areInIncreasingOrder: @escaping (Element, Element) -> Bool) where S.Iterator.Element == Element {
        elements = s.sorted(by: areInIncreasingOrder)
        self.areInIncreasingOrder = areInIncreasingOrder
    }
    
}

extension SortecArray : Collection {
    var startIndex: Int {
        return elements.startIndex
    }
    
    var endIndex: Int {
        return elements.endIndex
    }
    
    subscript(index: Int) -> Element? {
        return elements[index]
    }
    
    func index(after i: Int) -> Int {
        return elements.index(after: i)
    }
}


extension SortecArray {
    func min() -> Element? {
        return elements.first
    }
    
    func max() -> Element? {
        return elements.last
    }
}

extension SortecArray where Element: Comparable {
    init<S: Sequence>(_ unordered: S) where S.Iterator.Element == Element {
        self.init(unordered, areInIncreasingOrder: <)
    }
}
