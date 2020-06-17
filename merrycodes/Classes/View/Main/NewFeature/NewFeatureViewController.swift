import UIKit
import SnapKit

private let WBNewFeatureViewCellId = "WBNewFeatureViewCellId"

class NewFeatureViewController: UICollectionViewController {

    init() {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = UIScreen.main.bounds.size
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        super.init(collectionViewLayout: layout)
        collectionView?.isPagingEnabled = true
        collectionView?.bounces = false
        collectionView?.showsVerticalScrollIndicator = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public let WBNewFeatureImageCount = 4
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView!.register(NewFeatureCell.self, forCellWithReuseIdentifier: WBNewFeatureViewCellId)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return WBNewFeatureImageCount
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WBNewFeatureViewCellId, for: indexPath) as! NewFeatureCell
        cell.imageIndex = indexPath.item
        return cell
    }
    
    override func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let page = Int(scrollView.contentOffset.x / scrollView.bounds.width)
        if page != WBNewFeatureImageCount - 1{
            return
        }
        let cell = collectionView?.cellForItem(at: IndexPath(item: page, section: 0)) as! NewFeatureCell
        cell.showButtonAnim()
    }
    
}

class NewFeatureCell: UICollectionViewCell {
    
    public lazy var iconView = UIImageView()
    
    public lazy var startButton:UIButton = UIButton(title: "快速体验", color: UIColor.white, imageName: "new_feature_finish_button")
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func setUp() {
        addSubview(iconView)
        addSubview(startButton)
        iconView.frame = bounds
        startButton.snp.makeConstraints{
            (make) -> Void
            in
            make.centerX.equalTo(self.snp.centerX)
            make.bottom.equalTo(self.snp.bottom).multipliedBy(0.7)
        }
        startButton.addTarget(self, action: #selector(NewFeatureCell.clickStartButton), for: .touchUpInside)
        startButton.isHidden = true
    }
    
    public var imageIndex:Int = 0 {
        didSet {
            iconView.image = UIImage(named: "new_feature_\(imageIndex + 1)")
        }
    }
    
    public func showButtonAnim(){
        startButton.isHidden = false
        startButton.transform = CGAffineTransform(scaleX: 0, y: 0)
        startButton.isUserInteractionEnabled = false
        UIView.animate(withDuration: 1.6, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 10, options: [], animations: {() -> Void in self.startButton.transform = CGAffineTransform.identity
        }){(_) -> Void in self.startButton.isUserInteractionEnabled = true
        }
    }
    
    @objc public func clickStartButton(){
        print("开始体验")
    }
    
}
