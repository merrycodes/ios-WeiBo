import UIKit

class OAuthViewController: UIViewController {
    
    public lazy var webView = UIWebView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        webView.loadRequest(URLRequest(url: NetworkTools.sharedTools.OAuthURL as URL))
    }
    
    override func loadView() {
        view = webView
        title = "登陆新浪微博"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "关闭", style: .plain, target: self, action: #selector(OAuthViewController.close))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @objc public func close(){
        dismiss(animated: true, completion: nil)
    }
    
}
