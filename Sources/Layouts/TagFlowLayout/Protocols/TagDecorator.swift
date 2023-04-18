//
//  File.swift
//  
//
//  Created by LEMIN DAHOVICH on 18.04.2023.
//

import UIKit

protocol TagDecorator {
    var font: UIFont { get }
    var horizontalPadding: CGFloat { get }
    var verticalPadding: CGFloat { get }
    func applyDecoration(to cell: UICollectionViewCell)
}
