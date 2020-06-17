
import UIKit

class VisitorTableViewController: UITableViewController {

    public var userLogin = UserAccountViewModel.sharedUserAccount.userLogin
    
    public var visitorView : VisitorView?
    
    override func loadView() {
        userLogin ? super.loadView() : setupVisitorView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    public func setupVisitorView() {
        visitorView = VisitorView()
        view = visitorView
        
        view.backgroundColor = UIColor.white
        
        visitorView?.registerButton.addTarget(self, action: #selector(VisitorTableViewController.visitorViewRegister), for: .touchUpInside)
        visitorView?.loginButton.addTarget(self, action: #selector(VisitorTableViewController.visitorViewLogin), for: .touchUpInside)
        
        
    }
}
extension VisitorTableViewController{
    
    @objc public func visitorViewRegister(){
        print("注册")
    }
    
    @objc public func visitorViewLogin(){
        let oauthController = OAuthViewController()
        let navigation = UINavigationController(rootViewController: oauthController)
        present(navigation, animated: true, completion: nil)
    }
}
