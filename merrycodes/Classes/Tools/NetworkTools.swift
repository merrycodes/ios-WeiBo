import UIKit
import AFNetworking

class NetworkTools: AFHTTPSessionManager {
    
    public let appKey = "484370187"
    
    public let appSecre = "e02e8b21a9ab1b58598403962923d1eb"
    
    public let redirectUrl = "https://www.baidu.com"
    
    typealias HMRequsetCallBack = (AnyObject?,Error?)->()
    
    public var accessToken:[String:AnyObject]? {
        if let token = UserAccountViewModel.sharedUserAccount.account?.access_token {
            return ["access_token":token as AnyObject]
        }
        return nil
    }
    
    var OAuthURL:NSURL{
        let url = "https://api.weibo.com/oauth2/authorize?client_id=\(appKey)&redirect_uri=\(redirectUrl)"
        return NSURL(string:url)!
    }
    
    static let sharedTools:NetworkTools = {
        let tools =  NetworkTools(baseURL: nil)
        tools.responseSerializer.acceptableContentTypes?.insert("text/html")
        tools.responseSerializer.acceptableContentTypes?.insert("text/plain")
        return tools
    }()

}
extension NetworkTools{

    func request(method:HMRequestMethod, URLString:String, parameters:[String:AnyObject]?, finished:@escaping HMRequsetCallBack) {

        let success = {
            (task:URLSessionDataTask?,result:Any?)->Void in finished(result as AnyObject?,nil)
        }
        
        let failure = {
            (task:URLSessionDataTask?,error:Error)->Void in finished(nil,error)
        }
        
        if method == .GET{
            get(URLString, parameters: parameters, progress: nil, success: success, failure: failure)
        }

        if method == .POST{
            post(URLString, parameters: parameters, progress: nil, success: success, failure: failure)
        }
    }
    
    func loadAccessToken(code:String,finished:@escaping HMRequsetCallBack){
        let urlString = "https://api.weibo.com/oauth2/access_token"
        let params = ["client_id" : appKey,"client_secret" : appSecre,"grant_type" : "authorization_code","code" : code,"redirect_uri" : redirectUrl]
        request(method: .POST, URLString: urlString, parameters: params as [String : AnyObject], finished: finished)
    }
        
    func loadUserInfo(uid:String,finished:@escaping HMRequsetCallBack){
        guard var params = accessToken else {
            finished(nil,NSError(domain: "error", code: -1001, userInfo: ["message":"token为空"]))
            return
        }
        let urlString = "https://api.weibo.com/2/users/show.json"
        params["uid"] = uid as AnyObject?
        request(method: .GET, URLString: urlString, parameters: params as [String : AnyObject], finished: finished)
    }

}

enum HMRequestMethod:String{
    case GET = "GET"
    case POST = "POST"
}
