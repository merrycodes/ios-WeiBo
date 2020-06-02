import UIKit

class OAuthViewController: UIViewController {
    
    public lazy var webView = UIWebView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        webView.loadRequest(URLRequest(url: NetworkTools.sharedTools.OAuthURL as URL))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @objc public func close(){
        dismiss(animated: true, completion: nil)
    }
    
    @objc public func autoFill(){
        var js = "document.getElementById('userId').value='';"
        js+="document.getElementById('passwd').value='';"
        webView.stringByEvaluatingJavaScript(from: js)
    }
    
}
extension OAuthViewController:UIWebViewDelegate{
    
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        guard let url = request.url , url.host == "www.baidu.com" else{
            return true
        }
        guard let query = url.query , query.hasPrefix("code=") else {
            print("取消授权")
            return false
        }
        let code = String(query["code=".endIndex...])
        NetworkTools.sharedTools.loadAccessToken(code: code){
            (result,error)->() in
            if error != nil{
                print("获取权限码错误")
                return
            }
            let account = UserAccount(dict: result as! [String:AnyObject])
            self.loadUserInfo(account: account)
        }
        return false
    }
    
    override func loadView() {
        view = webView
        webView.delegate = self
        title = "登陆新浪微博"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "关闭", style: .plain, target: self, action: #selector(OAuthViewController.close))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "自动填充", style: .plain, target: self, action: #selector(OAuthViewController.autoFill))
    }
    
    func loadUserInfo(account:UserAccount){
        NetworkTools.sharedTools.loadUserInfo(uid: account.uid!, accessToken: account.access_token!){
            (result,error)->Void in
            if error != nil{
                print("加载用户信息错误")
                return
            }
            guard let dict = result as? [String:AnyObject] else{
                print("格式错误")
                return
            }
            print(dict["screen_name"]!)
            print(dict["avatar_large"]!)
            account.screen_name = dict["screen_name"] as! String?
            account.avatar_large = dict["avatar_large"] as! String?
            print(account)
        }
    }
    
}
