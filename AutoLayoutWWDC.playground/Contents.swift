 import UIKit

var str = "Hello, playground"

 
 class TestView: UIView {
    var  myConstraints = [NSLayoutConstraint]()
    override func updateConstraints() {
        NSLayoutConstraint.deactivate(myConstraints)
        
        
        super.updateConstraints()
    }
 }
