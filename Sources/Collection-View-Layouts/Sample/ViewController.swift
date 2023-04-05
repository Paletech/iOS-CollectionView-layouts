import Collection_View_Layouts
import UIKit

class ViewController: UIViewController {

    var collectionView: InfiniteCollectionView!
    var viewModel: ViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .orange
        setupCollectionView()
    }
    
    func setupCollectionView() {
        collectionView = InfiniteCollectionView(frame: view.bounds)
        
        collectionView.append(viewModel!.getFirstModel())
        collectionView.append(viewModel!.getSecondModel())
        
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.backgroundColor = #colorLiteral(red: 0.968627451, green: 0.9725490196, blue: 0.9921568627, alpha: 1)
        view.addSubview(collectionView)
    }
}
