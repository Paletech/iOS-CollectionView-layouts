import UIKit
import Combine

/**
 `InfiniteCollectionView` is a custom `UICollectionView` that can display an infinite number of sections with different layouts and data. It is designed to handle both finite and infinite scrolling sections.
 The `InfiniteCollectionView` automatically updates its layout and handles the data source methods for you.
 
 How to use:
 
Initialize the `InfiniteCollectionView` and add it to the view hierarchy:
 ````
 let collectionView = InfiniteCollectionView(frame: view.bounds)
 view.addSubview(collectionView)
 ````
 
Append a section with a custom layout, data, cell type, and cell configuration:
 ````
 collectionView.append(SectionDataSource(layout: createActiveChatSection(),
                            data: sections[1].items,
                            infinite: false,
                            cell: ActiveChatCell.self,
                            configureCell: { item, cell in
                            cell.configure(with: item)})
 ````
 
 Add another section with a different layout, data, cell type, and cell configuration:
 ````
 collectionView.append(SectionDataSource(layout: createAnotherSectionLayout(),
                            data: anotherDataArray,
                            infinite: false,
                            cell: AnotherCustomCell.self) { item, cell in
                            cell.configure(with: item)})
 ````

 */
open class InfiniteCollectionView: UICollectionView, UICollectionViewDataSource {
    
    private var sections: [AnySectionDataSource] = []
    private var layout: UICollectionViewCompositionalLayout!
    
    convenience init(frame: CGRect) {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex, environment) -> NSCollectionLayoutSection? in
            return nil
        }
        self.init(frame: frame, collectionViewLayout: layout)
    }
    
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        self.layout = layout as? UICollectionViewCompositionalLayout
        self.dataSource = self
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /**
     Sets up a new section in the collection view with the provided model.
        \nParameters for required Model
     
     - Parameters: 
       - layout: The `NSCollectionLayoutSection` that represents the layout of the section.
       - data: An array of items (of type `T`) that represent the data for the section.
       - infinite: A boolean value indicating whether the section should be displayed infinitely.
       - cell: The type of `UICollectionViewCell` to be used in the section.
       - configureCell: A closure that takes an item of type `T` and a cell of type `Cell` and configures the cell with the item.
     */
    public func append<T: Hashable, Cell: UICollectionViewCell>(_ sectionModel: SectionDataSource<T, Cell>) {
        let anyModel = AnySectionDataSource(sectionModel)
        sections.append(anyModel)
        register(anyModel.cellType, forCellWithReuseIdentifier: String(describing: anyModel.cellType))
        updateLayout()
        scrollToMiddle()
    }
    
    /**
        Removes section at specified index
     */
    public func remove(at index: Int) {
        sections.remove(at: index)
        updateLayout()
    }
    
    /**
        Reloads data specified section at specified index
     */
    public func reloadSection(_ section: Int) {
        collectionViewLayout.invalidateLayout()
        reloadSections(IndexSet(integer: section))
    }
    
    /**
        Reload collectionView
     */
    public func reload() {
        reloadData()
    }
    
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sections.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let sectionData = sections[section]
        
        if let imitateInfinityCount = sectionData.imitateInfinityCount {
            return sectionData.data.count * imitateInfinityCount
        } else {
            return sectionData.data.count
        }
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let sectionModel = sections[indexPath.section]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: sectionModel.cellType), for: indexPath)
        let item = sectionModel.data[indexPath.item % sectionModel.data.count]
        sectionModel.configureCell(item, cell)
        return cell
    }
    
    // MARK: - Private
    
    private func scrollToMiddle(animated: Bool = false) {
        guard let firstSection = sections.first, let imitateInfinityCount = firstSection.imitateInfinityCount else { return }

        let middleIndex = firstSection.data.count * imitateInfinityCount / 2
        let middleIndexPath = IndexPath(item: middleIndex, section: 0)
        scrollToItem(at: middleIndexPath, at: .centeredHorizontally, animated: animated)
    }
    
    private func updateLayout() {
        layout = UICollectionViewCompositionalLayout { [weak self] (sectionIndex, environment) -> NSCollectionLayoutSection? in
            return self?.sections[sectionIndex].layout
        }
        
        collectionViewLayout = layout
    }
}
