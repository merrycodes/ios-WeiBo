import UIKit

extension UILabel {
    
    convenience init(title: String, fontSize: CGFloat = 14, color: UIColor = UIColor.darkGray) {
        self.init()
        text = title
        textColor = color
        font = UIFont.systemFont(ofSize: fontSize)
        numberOfLines = 0
        textAlignment = NSTextAlignment.center
    }
    
}
