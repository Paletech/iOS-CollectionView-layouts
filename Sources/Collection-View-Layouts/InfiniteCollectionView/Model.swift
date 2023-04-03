import UIKit

public class Model<T: Hashable, Cell: UICollectionViewCell> {
    let layout: NSCollectionLayoutSection
    let cellType: Cell.Type
    let data: [T]
    let infinite: Bool
    let configureCell: (T, Cell) -> Void
    
    public init(layout: NSCollectionLayoutSection,
                data: [T],
                infinite: Bool,
                cell: Cell.Type,
                configureCell: @escaping (T, Cell) -> Void) {
        self.layout = layout
        self.data = data
        self.infinite = infinite
        self.cellType = cell
        self.configureCell = configureCell
    }
}

public class AnySectionModel {
    let layout: NSCollectionLayoutSection
    let cellType: UICollectionViewCell.Type
    let data: [AnyHashable]
    let infinite: Bool
    private let _configureCell: (AnyHashable, UICollectionViewCell) -> Void
    
    public init<T: Hashable, Cell: UICollectionViewCell>(_ model: Model<T, Cell>) {
        self.layout = model.layout
        self.cellType = model.cellType
        self.data = model.data
        self.infinite = model.infinite
        self._configureCell = { item, cell in
            guard let item = item as? T, let cell = cell as? Cell else { return }
            model.configureCell(item, cell)
        }
    }
    
    func configureCell(_ item: AnyHashable, _ cell: UICollectionViewCell) {
        _configureCell(item, cell)
    }
}
