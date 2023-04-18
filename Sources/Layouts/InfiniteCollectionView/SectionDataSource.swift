import UIKit

public class SectionDataSource<T: Hashable, Cell: UICollectionViewCell> {
    let layout: NSCollectionLayoutSection
    let cellType: Cell.Type
    let data: [T]
    let imitateInfinityCount: Int?
    let configureCell: (T, Cell) -> Void
    
    public init(layout: NSCollectionLayoutSection,
                data: [T],
                imitateInfinityCount: Int? = nil,
                cell: Cell.Type,
                configureCell: @escaping (T, Cell) -> Void) {
        self.layout = layout
        self.data = data
        self.imitateInfinityCount = imitateInfinityCount
        self.cellType = cell
        self.configureCell = configureCell
    }
}

public class AnySectionDataSource {
    let layout: NSCollectionLayoutSection
    let cellType: UICollectionViewCell.Type
    var data: [AnyHashable]
    let imitateInfinityCount: Int?
    private let _configureCell: (AnyHashable, UICollectionViewCell) -> Void
    var isPrependingData: Bool = false

    public init<T: Hashable, Cell: UICollectionViewCell>(_ model: SectionDataSource<T, Cell>) {
        self.layout = model.layout
        self.cellType = model.cellType
        self.data = model.data
        self.imitateInfinityCount = model.imitateInfinityCount
        self._configureCell = { item, cell in
            guard let item = item as? T, let cell = cell as? Cell else { return }
            model.configureCell(item, cell)
        }
    }
    
    func configureCell(_ item: AnyHashable, _ cell: UICollectionViewCell) {
        _configureCell(item, cell)
    }
}
