import UIKit

extension UIImageView{
    
    convenience init(imageName:String){
        self.init(image:UIImage(named: imageName))
    }
    
}
