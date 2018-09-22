import Foundation

var str = "Hello, playground"


print("hello world")

var dict: [String:Any] = [
    "airports": [
        "germany": ["FRA", "MUC", "HAM", "TXL"]
    ]
]

extension Dictionary {
    
    subscript(value key: Key) -> Value {
        get {
            return self[key]!
        }
        
        set {
            self[key] = newValue
        }
    }
        
    
    subscript(jsonDict key: Key) -> [String : Any] {
        get {
             return self[key] as? [String : Any] ?? [:]
        }
        set {
            self[key] = newValue as? Value
        }
    }
}


dict["countries"]






(dict as NSDictionary).value(forKeyPath: "airports.germany")
dict[jsonDict: "airports"][jsonDict: "germany"]

