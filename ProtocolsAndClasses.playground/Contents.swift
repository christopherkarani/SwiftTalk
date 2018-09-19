import UIKit

var str = "Hello, playground"

protocol Shape {
    func draw(context: CGContext)
    var  boundingBox: CGRect { get }
}

extension Shape {
    func image() -> UIImage {
        let renderer = UIGraphicsImageRenderer(bounds: boundingBox)
        return renderer.image(actions: { draw(context: $0.cgContext)} )
    }
    
    func rotated(by angle: CGFloat) -> Shape {
        return TransformedShape(original: self, transfrom: CGAffineTransform(rotationAngle: angle))
    }
}

struct TransformedShape {
    let original: Shape
    let transfrom: CGAffineTransform
}

extension TransformedShape: Shape {
    var boundingBox: CGRect {
        return original.boundingBox.applying(transfrom)
    }
    
    func draw(context: CGContext){
        // because context is mutable we must save the state so that it doesnt affect other draw methods
        context.saveGState()
        // rotate the context
        context.concatenate(transfrom)
        original.draw(context: context)
        context.restoreGState()
    }
}

struct Rectangle: Shape {
    var origin: CGPoint
    var size: CGSize
    var color: UIColor = .red
    
    init(size: CGSize, origin: CGPoint) {
        self.size = size
        self.origin = origin
    }
    
    var boundingBox: CGRect {
        return CGRect(origin: origin, size: size)
    }
    
    func draw(context: CGContext) {
        context.setFillColor(color.cgColor)
        context.fill(boundingBox)
    }
}

struct Circle: Shape {
    var center: CGPoint
    var radius: CGFloat
    var color: UIColor = .yellow
    
    init(center: CGPoint, radius: CGFloat) {
        self.center = center
        self.radius = radius
    }
    
    var boundingBox: CGRect {
        return CGRect(x: center.x - radius, y: center.y - radius, width: radius * 2, height: radius * 2)
    }
    
    func draw(context: CGContext) {
        context.setFillColor(color.cgColor)
        context.fillEllipse(in: boundingBox)
    }
}


let size = CGSize(width: 100, height: 200)
let rectangle = Rectangle(size: size, origin: .zero)
let rectImage = rectangle.image()

let circle: Shape = Circle(center: .zero, radius: 100)
let circleImage = circle.image()




rectangle.rotated(by: CGFloat(CGFloat.pi/6)).image()
