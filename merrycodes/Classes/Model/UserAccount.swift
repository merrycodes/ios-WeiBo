import UIKit

class UserAccount: NSObject {
    
    @objc var access_token:String?
    
    @objc var uid:String?

    @objc var expires_in:TimeInterval = 0{
        didSet{
            expiresDate = NSDate(timeIntervalSinceNow: expires_in)
        }
    }
    
    @objc var expiresDate:NSDate?
    
    @objc var screen_name:String?
    
    @objc var avatar_large:String?
    
    
    init(dict:[String:AnyObject]){
        super.init()
        self.setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {

    }
    
    override var description: String{
        let keys = ["access_token","expires_in","expiresDate","uid","screen_name","avatar_large"]
        return dictionaryWithValues(forKeys: keys).description
    }

    

}
