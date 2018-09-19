import UIKit

var str = "Hello, playground"

print(str)

extension UIGraphicsImageRenderer {
    convenience init(width: CGFloat, height: CGFloat) {
        self.init(size: CGSize(width: width, height: height))
    }
}

extension UIColor {
    convenience init(red: CGFloat, green: CGFloat, blue: CGFloat) {
        self.init(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
    
     static func rgb(_ r: CGFloat, _ g: CGFloat, _ b: CGFloat, _ a: CGFloat) -> UIColor {
        return self.init(red: r/255, green: g/255, blue: b/255, alpha: a)
    }
}

func drawRectangle() {
    let area : (width: CGFloat, height: CGFloat) = (10000, 10000)
    let renderer = UIGraphicsImageRenderer(width: area.width, height: area.height)
    
    let img = renderer.image { (context) in
        UIColor.darkGray.setStroke()
        
        var count = 0
        let alphaRange : (lowerBound: CGFloat, upperBound: CGFloat) = (0.3, 0.7)
        
        while count < 10 {
            let red = CGFloat.random(in: 80...255)
            let blue = CGFloat.random(in: 80...255)
            let green = CGFloat.random(in: 80...255)
            let alpha = CGFloat.random(in: alphaRange.lowerBound...alphaRange.upperBound)
            let x = CGFloat.random(in: 0...area.width)
            let y = CGFloat.random(in: 0...area.height)
            UIColor.rgb(red, green, blue, alpha).setFill()
            context.fill(CGRect(x: x, y: y, width: 500, height: 500), blendMode: .multiply)
            
            count += 1
        }
        
        
    }
    
    
}


