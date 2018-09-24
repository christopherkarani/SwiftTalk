import UIKit

var str = "Hello, playground"

let numbers = ["1","2","3","4","5", "Foo"]
//: Filteres out nil values and return an array of non - optionals
//: We make this a free function an not an extension sequence because unfortunately, there’s no way to constrain an extension on Sequence to only apply to sequences of optionals.

func flatten<S: Sequence,T>(source: S) -> [T] where S.Element == T? {
    let filtered = source.filter { $0 != nil }
    return filtered.map { $0! }
}



//: A Custom Implementation for flatMap
//: Using lazy saves the allocation of multiple buffers that would otherwise be needed to write the intermediary results into
extension Sequence {
    func flatMapIt<U>(_ transform: (Element) -> U?) -> [U] {
        return flatten(source: self.map(transform) )
    }
}


var dict : [String: Int?] = [
    "one": 1,
    "two": 2,
    "three": nil
]

dict["three"] = nil
dict.updateValue(5, forKey: "three")


