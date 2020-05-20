import UIKit

extension UIButton{
    convenience init(imageName:String,backgroundName:String){
        self.init()
        setImage(UIImage(named:imageName), for: .normal)
        setImage(UIImage(named:imageName+"_highlighted"), for: .highlighted)
        
        setBackgroundImage(UIImage(named:backgroundName), for: .normal)
        setBackgroundImage(UIImage(named:backgroundName+"_highlighted"), for: .highlighted)
        sizeToFit()
    }
}
