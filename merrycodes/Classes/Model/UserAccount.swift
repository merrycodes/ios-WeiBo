import UIKit

class UserAccount: NSObject {
    
    var access_token:String?
    
    var expires_in:TimeInterval = 0
    
    var uid:String?
    
    init(dict:[String:AnyObject]){
        super.init()
        print(dict)
        self.setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        print(" forUndefinedKey：\(key):\(value)")
    }
    
    override func setValue(_ value: Any?, forKey key: String) {
        print("hello")
        print("\(key):\(value)")
        super.setValue(value,forKey:key)
    }
    
//    override var description: String{
//        let keys = ["access_token","expires_in","uid"]
//        return dictionaryWithValues(forKeys: keys).description
//    }

    

}
