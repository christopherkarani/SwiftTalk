import UIKit

protocol Optionable {}

extension Optional: Optionable {}
var str = "Hello, playground"

let numbers = ["1","2","3","4","5", "Foo"]
//: Filteres out nil values and return an array of non - optionals
//: We make this a free function an not an extension sequence because unfortunately, there’s no way to constrain an extension on Sequence to only apply to sequences of optionals.

//extension Sequence where Element == T? {
//    func flatten() -> [Element] {
//        let filtered = self.filter { $0 != nil }
//        return filtered.map { $0! }
//    }
//
//
//    //: A Custom Implementation for flatMap
//    //: Using lazy saves the allocation of multiple buffers that would otherwise be needed to write the intermediary results into
//    func flatMapIt<U>(_ transform: (Element) -> U?) -> [U] {
//        return flatten()
//    }
//}


func flatten<S: Sequence,T>(source: S) -> [T] where S.Element == T? {
    let filtered = source.filter { $0 != nil }
    return filtered.map { $0! }
}




extension Sequence {

}


var dict : [String: Int?] = [
    "one": 1,
    "two": 2,
    "three": nil
]

let ages = [
    "Tim": 53, "Angela": 54, "Craig": 44,
    "Jony": 47, "Chris": 37, "Michael": 34,
]

//: FOrce unwrap because we know that the value will always be there
let below50 = ages.keys.filter { ages[$0]! < 50 }.sorted()

//: This Version has possible performance benefits becuase it avoids unnecesary lookups
let under50 = ages.filter { $0.value < 50 }.map { $0.key }.sorted()





infix operator !!


/// Optional Unwrapping With a more descriptive Error
func !!<T>(wrapped: T?, errorMessage: @autoclosure () -> String) -> T {
    if let value = wrapped { return value }
    fatalError(errorMessage())
}

let val = "Foo"

protocol PresenterProtocol {
    func doSomething()
}
class Presenter  {
    
    init() {
    }
}

class VC: UIViewController {
    
}
