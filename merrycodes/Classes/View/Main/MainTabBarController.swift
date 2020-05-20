import UIKit

class MainTabBarController: UITabBarController {
    private lazy var composedButtom:UIButton = UIButton(imageName: "tabbar_compose_icon_add", backgroundName: "tabbar_compose_button")

    override func viewDidLoad() {
        super.viewDidLoad()
        addChildViewControllers()
//        NetworkTools.sharedTools.request(URLString: "http://www.weather.com.cn/data/sk/101010100.html", parameters: nil)
        NetworkTools.sharedTools.request(method: .GET, URLString: "http://httpbin.org/get", parameters: ["name" : "zhangsan" as AnyObject,"age" : 18 as AnyObject], finish: {(result,error)->() in print(error!)})
         NetworkTools.sharedTools.request(method: .POST, URLString: "http://httpbin.org/post", parameters: ["name" : "zhangsan" as AnyObject,"age" : 18 as AnyObject], finish: {(result,error)->() in print(error!)})
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
extension MainTabBarController{
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBar.bringSubview(toFront: composedButtom)
    }
    
    public func addChildViewControllers() {
        tabBar.tintColor=UIColor.orange
        addChildViewController(vc: HomeTableViewController(), title: "首页", imageName: "tabbar_home")
        addChildViewController(vc: MessageTableViewController(), title: "消息", imageName: "tabbar_message_center")
        addChildViewController(UIViewController())
        addChildViewController(vc: DiscoverTableViewController(), title: "发现", imageName: "tabbar_discover")
        addChildViewController(vc: ProfileTableViewController(), title: "我", imageName: "tabbar_profile")
        setUpComposeButton()
    }
    
    private func addChildViewController(vc: UIViewController,title : String ,imageName :String) {
        vc.title = title
        vc.tabBarItem.image=UIImage(named: imageName)
        let nav = UINavigationController(rootViewController: vc)
        addChildViewController(nav)
        
    }
    public func	setUpComposeButton(){
        tabBar.addSubview(composedButtom)
        let count = childViewControllers.count
        let width = tabBar.bounds.width/CGFloat(count)-1
        composedButtom.frame=CGRect(x: 2*width, y: 0.0, width: width, height: tabBar.bounds.height)
        composedButtom.addTarget(self, action: #selector(MainTabBarController.clickComposeButton), for: .touchUpInside)
    }
    
    @objc
    private func clickComposeButton (){
        print("merrycodes")
    }
    
}
