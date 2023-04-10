//
//  TagLayout.swift
//  TagLayout
//
//  Created by LEMIN DAHOVICH on 10.04.2023.
//
//

import UIKit

class TagLayout: UICollectionViewFlowLayout {
    private var layoutAttributes: [UICollectionViewLayoutAttributes] = []
    private var contentWidth: CGFloat = 0.0
    private var contentHeight: CGFloat = 0.0
    
    override func prepare() {
        guard let collectionView = collectionView else { return }
        
        layoutAttributes.removeAll()
        contentWidth = 0.0
        contentHeight = 0.0
        
        let numberOfItems = collectionView.numberOfItems(inSection: 0)
        var xOffset: CGFloat = 0
        var yOffset: CGFloat = 0
        let spacing: CGFloat = 8
        
        for item in 0..<numberOfItems {
            let indexPath = IndexPath(item: item, section: 0)
            let cellSize = (collectionView.delegate as? UICollectionViewDelegateFlowLayout)?.collectionView?(collectionView, layout: self, sizeForItemAt: indexPath) ?? CGSize(width: 50, height: 30)
            
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
