//
//  File.swift
//  
//
//  Created by LEMIN DAHOVICH on 10.04.2023.
//

import UIKit

extension String {
    func preferredSize(forFont font: UIFont,
                       horizontalPadding: CGFloat,
                       verticalPadding: CGFloat) -> CGSize {
        let label = UILabel()
        label.font = font
        label.text = self
        return CGSize(width: label.intrinsicContentSize.width + horizontalPadding,
                      height: label.intrinsicContentSize.height + verticalPadding)
    }
}
