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
    
    convenience init(title:String,color:UIColor,imageName:String){
        self.init()
        setTitle(title, for: .normal)
        setTitleColor(color, for: .normal)
        setBackgroundImage(UIImage(named: imageName), for: .normal)
        sizeToFit()
    }
    
}
