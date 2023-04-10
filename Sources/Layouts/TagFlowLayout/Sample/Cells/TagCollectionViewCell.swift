//
//  TagCollectionViewCell.swift
//  TagCollectionViewCell
//
//  Created by LEMIN DAHOVICH on 10.04.2023.
//
//

import UIKit

class TagCollectionViewCell: UICollectionViewCell, SizableText {
    
    @IBOutlet weak var view: UIView!
    @IBOutlet weak var titleLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        self.view.layer.cornerRadius = 20/2
    }
    
    func config(info: String) {
        self.titleLabel.text = info
    }
    
    static func preferredSize(for text: String) -> CGSize {
        let horizontalPadding: CGFloat = 40.0
        let verticalPadding: CGFloat = 15.0
        let label = UILabel()
        label.text = text
        return CGSize(width: label.intrinsicContentSize.width + horizontalPadding,
                      height: label.intrinsicContentSize.height + verticalPadding)
    }
}
