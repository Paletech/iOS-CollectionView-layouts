//
//  File.swift
//  
//
//  Created by LEMIN DAHOVICH on 10.04.2023.
//

import Foundation

public protocol SizableText {
    static func preferredSize(for text: String) -> CGSize
}
