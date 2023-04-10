//
//  File.swift
//  
//
//  Created by LEMIN DAHOVICH on 05.04.2023.
//

import UIKit

public class AlignedFlowLayout: UICollectionViewFlowLayout {
    
    enum Alignment {
        case left(Int?)
        case center(Int?)
        case right(Int?)
    }
    
    var alignment: Alignment = .left(5)
    
    public override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        guard let layoutAttributes = super.layoutAttributesForElements(in: rect) else { return nil }
        
        var alignedAttributes: [UICollectionViewLayoutAttributes] = []
        var currentRowAttributes: [UICollectionViewLayoutAttributes] = []
        var currentRowY: CGFloat = -1
        
        for attribute in layoutAttributes {
            if currentRowY != attribute.frame.origin.y {
                alignedAttributes.append(contentsOf: align(attributes: currentRowAttributes))
                currentRowAttributes.removeAll()
                currentRowY = attribute.frame.origin.y
            }
            currentRowAttributes.append(attribute)
        }
        
        alignedAttributes.append(contentsOf: align(attributes: currentRowAttributes))
        
        return alignedAttributes
    }
    
    private func align(attributes: [UICollectionViewLayoutAttributes]) -> [UICollectionViewLayoutAttributes] {
        guard !attributes.isEmpty else { return [] }
        
        var updatedAttributes: [UICollectionViewLayoutAttributes] = []
        
        for attribute in attributes {
            guard let copiedAttribute = attribute.copy() as? UICollectionViewLayoutAttributes else { continue }
            
            switch alignment {
            case .left(let offset):
                let padding = sectionInset.left + CGFloat(offset ?? 0)
                copiedAttribute.frame = copiedAttribute.frame.offsetBy(dx: padding, dy: 0)
            case .center(let offset):
                let totalWidth = attributes.reduce(0) { (result, attribute) -> CGFloat in
                    return result + attribute.frame.width + minimumInteritemSpacing
                }
                let padding = (collectionViewContentSize.width - totalWidth) / 2 + CGFloat(offset ?? 0)
                copiedAttribute.frame = copiedAttribute.frame.offsetBy(dx: padding, dy: 0)
            case .right(let offset):
                let totalWidth = attributes.reduce(0) { (result, attribute) -> CGFloat in
                    return result + attribute.frame.width + minimumInteritemSpacing
                }
                let padding = collectionViewContentSize.width - totalWidth - sectionInset.right + CGFloat(offset ?? 0)
                copiedAttribute.frame = copiedAttribute.frame.offsetBy(dx: padding, dy: 0)
            }
            
            updatedAttributes.append(copiedAttribute)
        }
        
        return updatedAttributes
    }
}
