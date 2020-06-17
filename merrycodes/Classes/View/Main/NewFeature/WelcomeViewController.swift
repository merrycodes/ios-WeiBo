import UIKit
import SDWebImage

class WelcomeViewController: UIViewController {

    public lazy var backImageView:UIImageView = UIImageView(imageName: "ad_background")
    
    public lazy var iconView:UIImageView = {
        let imageView = UIImageView(imageName: "avatar_default_big")
        imageView.layer.cornerRadius = 45
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    public lazy var welcomeLabel:UILabel = UILabel(title:"欢迎归来")
    
    override func loadView() {
        view = backImageView
        setupUI()
        iconView.sd_setImage(with: UserAccountViewModel.sharedUserAccount.avatarUrl as URL, placeholderImage: UIImage(named: "avatar_default_big"))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        iconView.snp.makeConstraints {
            (make) in
            make.bottom.equalTo(view.snp.bottom).offset(-view.bounds.height + 200)
        }
        welcomeLabel.alpha = 0
        UIView.animate(withDuration: 1.2, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 10, options: [], animations: {() -> () in self.view.layoutIfNeeded()}) {
            (_) in
            UIView.animate(withDuration: 0.8, animations: {self.welcomeLabel.alpha = 1}) {
                (_) in 
            }
        }
    }

}

extension WelcomeViewController {
    
    public func setupUI() {
        view.addSubview(iconView)
        view.addSubview(welcomeLabel)
        
        iconView.snp.makeConstraints {
            (make) in
            make.centerX.equalTo(view.snp.centerX)
            make.bottom.equalTo(view.snp.bottom).offset(-200)
            make.width.equalTo(90)
            make.height.equalTo(90)
        }
        welcomeLabel.snp.makeConstraints{
            (make) in
            make.centerX.equalTo(iconView.snp.centerX)
            make.top.equalTo(iconView.snp.bottom).offset(14)
        }
    }
    
}
