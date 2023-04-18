import UIKit

public class AlignedViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    var sections = Bundle.main.decode([MSection].self, from: "model.json")

    private var collectionView: UICollectionView!
    private var alignedFlowLayout: AlignedFlowLayout!
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        alignedFlowLayout = AlignedFlowLayout()
        alignedFlowLayout.itemSize = CGSize(width: 100, height: 100)
        alignedFlowLayout.minimumInteritemSpacing = 10
        alignedFlowLayout.minimumLineSpacing = 10
        alignedFlowLayout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        alignedFlowLayout.alignment = .center(nil)
        
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: alignedFlowLayout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .brown
        collectionView.register(ActiveChatCell.self, forCellWithReuseIdentifier: "Cell")
        
        view.addSubview(collectionView)
    }
    
    public override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.frame = view.bounds
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sections[0].items.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! ActiveChatCell
        cell.configure(with: sections[0].items[indexPath.item % sections[0].items.count])
        return cell
    }
}
