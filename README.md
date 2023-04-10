# Collection-View-Layouts

Several custom layouts for UICollectionView

<hr color="red" size="5">

## TagLayout

`TagLayout` is a custom `UICollectionViewFlowLayout` for displaying a list of tags in a `UICollectionView`. It arranges tags in a flow layout, wrapping them to the next line when necessary.

### Usage

1. In the your ViewController, create a UICollectionView instance with the custom TagLayout as its layout:

```swift
collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: TagLayout())
```
2. Implement the required delegate and data source methods.
```swift
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let tag = tags[indexPath.item]
        return TagCollectionViewCell.preferredSize(for: tag)
    }
```
4. Create a `UICollectionViewCell` class. Implement the `SizableText` protocol, which provides a static method to calculate the preferred size for the tag cell based on the text:
```swift
class TagCollectionViewCell: UICollectionViewCell, SizableText {
    ..
    static func preferredSize(for text: String) -> CGSize {
        ...
    }
}
```
4. Register the custom your cell in the `ViewController`.
5. Use the `sortedTagsBasedOnCellSize` method from the UICollectionView extension to sort the tags based on their size:
```swift
tags = collectionView.sortedTagsBasedOnCellSize(tags, cellType: TagCollectionViewCell.self)
```
Here's an example of how to create a simple tag view controller with a custom flow layout:
```swift
class TagViewController: UIViewController {
    var collectionView: UICollectionView!
    var tags: [String] = [
        "Stellar Voyage",
        "Wanderlust",
        "Infinite Horizons",
        ...
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
    }
    
    func setupCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: TagLayout())
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "TagCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "default")
        tags = collectionView.sortedTagsBasedOnCellSize(tags, cellType: TagCollectionViewCell.self)
        view.addSubview(collectionView)
    }
}
```
For the full code, see the provided Sample files.

<hr color="red" size="5">

## InfiniteCollectionView

`InfiniteCollectionView` is a custom `UICollectionView` designed to display an infinite number of elements in sections with different layouts and data. It handles both finite and infinite scrolling sections, automatically updating its layout and handling the data source methods for you.

### Usage

1. Create an instance of `InfiniteCollectionView` and add it to your view hierarchy:
```swift
let collectionView = InfiniteCollectionView(frame: view.bounds)
view.addSubview(collectionView)
```
2. Append a section with a custom layout, data, cell type, and cell configuration:
```swift
collectionView.append(SectionDataSource(layout: createActiveChatSection(),
                       data: sections[1].items,
                       infinite: false,
                       cell: ActiveChatCell.self,
                       configureCell: { item, cell in
                       cell.configure(with: item)}))
```
Add another section with a different layout, data, cell type, and cell configuration:
```swift
collectionView.append(SectionDataSource(layout: createAnotherSectionLayout(),
                       data: anotherDataArray,
                       infinite: false,
                       cell: AnotherCustomCell.self) { item, cell in
                       cell.configure(with: item)})
```
3. Remove a section at a specified index:
```swift
collectionView.remove(at: index)
```
4. Reload data for a specified section at a specified index:
```swift
collectionView.reloadSection(section)
```

Here's an example of using `InfiniteCollectionView` in a `UIViewController`:
```swift
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
```
This example demonstrates the creation of an `InfiniteCollectionView`, appending sections with custom layouts and data.

<hr color="red" size="5">

## AlignedFlowLayout
`AlignedFlowLayout` is a custom `UICollectionViewFlowLayout` designed to provide a simple way to align your `UICollectionView` cells to the left, center, or right with an optional offset. The layout handles the alignment of cells in each row, allowing you to create a visually appealing and well-organized collection view.

### Usage

1. Create an instance of `AlignedFlowLayout` and configure its properties:
```swift
let alignedFlowLayout = AlignedFlowLayout()
alignedFlowLayout.itemSize = CGSize(width: 100, height: 100)
alignedFlowLayout.minimumInteritemSpacing = 10
alignedFlowLayout.minimumLineSpacing = 10
alignedFlowLayout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
alignedFlowLayout.alignment = .left(15)
```
2. Initialize your `UICollectionView` with the `AlignedFlowLayout`:
```swift
let collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: alignedFlowLayout)
```

Here's a complete example of using `AlignedFlowLayout` in a `UIViewController`:
```swift
class AlignedViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    var sections = Bundle.main.decode([MSection].self, from: "model.json")

    private var collectionView: UICollectionView!
    private var alignedFlowLayout: AlignedFlowLayout!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        alignedFlowLayout = AlignedFlowLayout()
        alignedFlowLayout.itemSize = CGSize(width: 100, height: 100)
        alignedFlowLayout.minimumInteritemSpacing = 10
        alignedFlowLayout.minimumLineSpacing = 10
        alignedFlowLayout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        alignedFlowLayout.alignment = .left(15)
        
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: alignedFlowLayout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .white
        collectionView.register(ActiveChatCell.self, forCellWithReuseIdentifier: "Cell")
        
        view.addSubview(collectionView)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sections[0].items.count / 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! ActiveChatCell
        cell.configure(with: sections[0].items[indexPath.item % sections[0].items.count])
        return cell
    }
}
```
