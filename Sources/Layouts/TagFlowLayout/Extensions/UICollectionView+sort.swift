//
//  File.swift
//
//
//  Created by LEMIN DAHOVICH on 08.04.2023.
//

import UIKit

public extension UICollectionView {
    func sortedTagsBasedOnCellSize<T: SizableText>(_ tags: [String], cellType: T.Type) -> [String] {
        return tags.sorted { tag1, tag2 in
            let size1 = cellType.preferredSize(for: tag1)
            let size2 = cellType.preferredSize(for: tag2)
            return size1.width < size2.width
        }
    }
}
