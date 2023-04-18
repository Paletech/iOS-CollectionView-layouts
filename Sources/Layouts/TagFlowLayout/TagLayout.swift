//
//  TagLayout.swift
//  TagLayout
//
//  Created by LEMIN DAHOVICH on 10.04.2023.
//
//

import UIKit

class TagLayout<Decorator: TagDecorator>: UICollectionViewFlowLayout {
    private var layoutAttributes: [UICollectionViewLayoutAttributes] = []
    private var contentWidth: CGFloat = 0.0
    private var contentHeight: CGFloat = 0.0
    private let decorator: Decorator
    
    private var xOffset: CGFloat
    private var yOffset: CGFloat
    private var spacing: CGFloat
    
    weak var dataSource: TagDataSource?
    
    init(decorator: Decorator, xOffset: CGFloat = 0, yOffset: CGFloat = 0, spacing: CGFloat = 8) {
        self.decorator = decorator
        self.xOffset = xOffset
        self.yOffset = yOffset
        self.spacing = spacing
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepare() {
        guard let collectionView = collectionView else { return }
        
        layoutAttributes.removeAll()
        contentWidth = 0.0
        contentHeight = 0.0
        
        let numberOfItems = collectionView.numberOfItems(inSection: 0)
        
        
        for item in 0..<numberOfItems {
            let indexPath = IndexPath(item: item, section: 0)
            let tag = dataSource?.tag(at: indexPath) ?? ""

            let cellSize = tag.preferredSize(forFont: decorator.font,
                                             horizontalPadding: decorator.horizontalPadding,
                                             verticalPadding: decorator.verticalPadding)
            
            if xOffset + cellSize.width > collectionView.bounds.width {
                xOffset = 0
                yOffset += cellSize.height + spacing
            }
            
            let frame = CGRect(x: xOffset, y: yOffset, width: cellSize.width, height: cellSize.height)
            let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            attributes.frame = frame
            layoutAttributes.append(attributes)
            
            xOffset += cellSize.width + spacing
            contentWidth = max(contentWidth, xOffset)
            contentHeight = yOffset + cellSize.height
        }
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return layoutAttributes.filter { rect.intersects($0.frame) }
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return layoutAttributes[indexPath.item]
    }
    
    override var collectionViewContentSize: CGSize {
        return CGSize(width: contentWidth, height: contentHeight)
    }
}
