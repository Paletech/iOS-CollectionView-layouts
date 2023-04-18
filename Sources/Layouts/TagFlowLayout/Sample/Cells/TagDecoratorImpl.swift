//
//  File.swift
//  
//
//  Created by LEMIN DAHOVICH on 18.04.2023.
//

import UIKit

class TagDecoratorImpl: TagDecorator {
    
    var horizontalPadding: CGFloat {
        40
    }
    
    var verticalPadding: CGFloat {
        15
    }
    
    var font: UIFont {
        UIFont.systemFont(ofSize: 17)
    }
    
    func applyDecoration(to cell: UICollectionViewCell) {
        guard let cell = cell as? TagCollectionViewCell else { return }
        cell.view.backgroundColor = .lightGray
        cell.view.layer.cornerRadius = cell.frame.height / 2
        cell.titleLabel.textColor = .black
    }
}
