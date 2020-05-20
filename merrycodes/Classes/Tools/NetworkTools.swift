import UIKit
import AFNetworking

class NetworkTools: AFHTTPSessionManager {
    
    public let appKey = "484370187"
    
    public let appSecre = "e02e8b21a9ab1b58598403962923d1eb"
    
    public let redirectUrl = "https://www.baidu.com"
    
    var OAuthURL:NSURL{
        let url = "https://api.weibo.com/oauth2/authorize?client_id=\(appKey)&redirect_uri=\(redirectUrl)"
        return NSURL(string:url)!
    }
    
    static let sharedTools:NetworkTools = {
        let tools =  NetworkTools(baseURL: nil)
        tools.responseSerializer.acceptableContentTypes?.insert("text/html")
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

}

enum HMRequestMethod:String{
    case GET = "GET"
    case POST = "POST"
}
