import UIKit

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
    
}

class NewFeatureCell: UICollectionViewCell {
    
    public lazy var iconView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func setUp() {
        addSubview(iconView)
        iconView.frame = bounds
    }
    
    public var imageIndex:Int = 0 {
        didSet {
            iconView.image = UIImage(named: "new_feature_\(imageIndex + 1)")
        }
    }
}
