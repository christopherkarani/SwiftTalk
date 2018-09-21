import UIKit

var str = "Hello, playground"
print(str)


class Temperature: NSObject {
    var celcius : Double
    var farenheit: Double {
        get { return celcius * 9 / 5 + 32  }
        set { celcius = (newValue - 32) * 5/9 }
    }
    
    init(celcius: Double) {
        self.celcius = celcius
    }
}


/// Sieve of Eratosthenenes
/// parameter
func primes(upTo x: Int) -> [Int] {
    // this is an array from 2 to, but not including, n
    var numbers = [Int](2..<x)
    // why minues 2 from n
    for i in 0..<x-2 {
        let prime = numbers[i]
        guard prime > 0 else { continue }
        // set all the multiples to 0, because if your a multiple your not a prime number
        for multiple in stride(from: 2 * prime - 2, to: x - 2, by: prime) {
            numbers[multiple] = 0
        }
    }
    
    return numbers.filter { $0 > 0 }
}


primes(upTo: 100)

let numbers = (1...100).map { $0 }
print(numbers.endIndex)
primes(upTo: numbers[numbers.count - 1])

func sieve(numbers: [Int]) -> [Int] {
    guard !numbers.isEmpty else { return [] }
    let p = numbers[0]
    return [p] + sieve(numbers: numbers[1..<numbers.endIndex].filter { $0 % p > 0} )
}


sieve(numbers: numbers)


let temp = Temperature(celcius: 400)

class House {
    var thermostat: Double = 0
    var oven : Double = 0
}

let house = House()




protocol Shape {
    var boundingRect:  CGRect { get }
    
    /// Draw the shape using a CGContext
    func draw(context: CGContext)
}

extension Shape {
    /// Render the shape as a UIImage
    func image() -> UIImage {
        let renderer = UIGraphicsImageRenderer(bounds: boundingRect)
        return renderer.image(actions: { draw(context: $0.cgContext)} )
    }
}


struct Rectangle: Shape {
    var origin: CGPoint
    var size: CGSize
    var color: UIColor = .yellow
    
    // Initializer
    init(size: CGSize, origin: CGPoint) {
        self.size = size
        self.origin = origin
    }
    
    var boundingRect: CGRect {
        return CGRect(origin: origin, size: size)
    }
    
    func draw(context: CGContext) {
        context.setFillColor(color.cgColor)
        context.fill(boundingRect)
    }
}



struct Point {
    var x: CGFloat
    var y: CGFloat
}

extension Point {
    static var zero : Point {
        return self.init(x: 0, y: 0)
    }
}

let point = Point(x: 400, y: 100)
point.x
point.y

struct Circle: Shape {
    var center: Point
    var radius: CGFloat
    var color: UIColor
    
    var boundingRect: CGRect {
        return CGRect(x: center.x - radius, y: center.y - radius, width: radius * 2, height: radius * 2)
    }
    
    func draw(context: CGContext) {
        context.setFillColor(color.cgColor)
        context.fillEllipse(in: boundingRect)
    }
}


let rectangle = Rectangle(size: CGSize(width: 100, height: 100), origin: .zero)
rectangle.image()


let circle = Circle(center: .zero, radius: 40, color: .red)
circle.image()



extension UIColor {
    convenience init(_ r: CGFloat, _ g: CGFloat, _ b: CGFloat) {
        self.init(red: r/255, green: g/255, blue: b/255, alpha: 0.7)
    }
}

let renderer = UIGraphicsImageRenderer(bounds: CGRect(x: 0, y: 0, width: 300, height: 300))

let img = renderer.image { (gContext) in
    let context = gContext.cgContext
    
    UIColor(red: 255/255, green: 240/255, blue: 245/255, alpha: 1).setFill()
    context.fill(CGRect(x: 0, y: 0, width: 100, height: 100))
    

    UIColor(193, 205, 193).setFill()
    context.fillEllipse(in: CGRect(x: 0, y: 0, width: 100, height: 100))
    
    UIColor(240, 248, 255).setFill()
    context.fill(CGRect(x: 40, y: 40, width: 100, height: 100))
    
    
    UIColor(255, 250, 105).setFill()
    context.fill(CGRect(x: 80, y: 80, width: 100, height: 100))
    
    UIColor(244, 238, 224).setFill()
    context.fill(CGRect(x: 120, y: 120, width: 100, height: 100))
    
    UIColor(238, 130, 238).setFill()
    context.fill(CGRect(x: 160, y: 160, width: 100, height: 100))
    
    UIColor(255, 222, 173).setFill()
    context.fill(CGRect(x: 200, y: 200, width: 100, height: 100))
    
    
}

img
