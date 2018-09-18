import Foundation


/// An array that sorts its elements based on a given predicate
struct SortecArray<Element> {
    var elements: [Element]
    
    /// The given Predicate for this Sort
    var areInIncreasingOrder: (Element, Element) -> Bool
    
    
    /// Append an element to the elements array and sort the array again using the `areInIncreasingOrder` predicate
    mutating func append(_ element: Element) {
        elements.append(element)
        elements.sort(by: areInIncreasingOrder)
    }
    
    /// Initializer that gives the caller the power to describe their own sorting predicate.
    init<S: Sequence>(_ s: S, areInIncreasingOrder: @escaping (Element, Element) -> Bool) where S.Iterator.Element == Element {
        elements = s.sorted(by: areInIncreasingOrder)
        self.areInIncreasingOrder = areInIncreasingOrder
    }
    
}

/// conformance to COllection Protocol. Since this is a wrapper around array its very easy to use its proeperties
/// to back our new types conformance to Collection
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

/// Since our Collection is sorted we can implement some overrides to certain methods and
/// improve their perfomance characteritcs
extension SortecArray {
    /// return the first element, being the smallest, since our array is sorted from smallest to largest
    func min() -> Element? {
        return elements.first
    }
    /// return the last element, being the largest, since our array is sorted from smallest to largest
    func max() -> Element? {
        return elements.last
    }
}
/// < ascending
/// > descending

extension SortecArray where Element: Comparable {
    /// a convienience initializer that takes a sequence and sortes them in ascending order
    /// where the sequence.iterator.element is equal to element
    init<S: Sequence>(_ unordered: S) where S.Iterator.Element == Element {
        self.init(unordered, areInIncreasingOrder: <)
    }
}
