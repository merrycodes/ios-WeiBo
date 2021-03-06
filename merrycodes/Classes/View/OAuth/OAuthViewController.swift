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
        js += "document.getElementById('passwd').value='';"
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
        UserAccountViewModel.sharedUserAccount.loadAccessToken(code: code){
            (isSuccecced)->() in
            if isSuccecced == true {
                print("获取权限码成功")
                print(UserAccountViewModel.sharedUserAccount.account!)
            }else{
                print("获取权限码错误")
            }
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
    
}
