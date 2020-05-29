import UIKit
import AFNetworking

class NetworkTools: AFHTTPSessionManager {
    
    public let appKey = "484370187"
    
    public let appSecre = "e02e8b21a9ab1b58598403962923d1eb"
    
    public let redirectUrl = "https://www.baidu.com"
    
    typealias HMRequsetCallBack = (AnyObject?,Error?)->()
    
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

    func request(method:HMRequestMethod, URLString:String, parameters:[String:AnyObject]?, finish:@escaping (_ result:AnyObject?,_ error:Error?)->()) {

        if method == .GET{
            get(URLString, parameters: parameters, progress: nil, success: {(_,result) in print(result!)}){(_,error) in finish (nil,error)}
        }

        if method == .POST{
            post(URLString, parameters: parameters, progress: nil, success: {(_,result) in print(result!)}){(_,error) in finish (nil,error)}
        }
    }
    
    func loadAccessToken(code:String,finished:@escaping HMRequsetCallBack){
        let urlString = "https://api.weibo.com/oauth2/access_token"
        let params = ["client_id" : appKey,"client_secret" : appSecre,"grant_type" : "authorization_code","code" : code,"redirect_uri" : redirectUrl]
        request(method: .POST, URLString: urlString, parameters: params as [String : AnyObject], finish: finished)
    }

}

enum HMRequestMethod:String{
    case GET = "GET"
    case POST = "POST"
}
