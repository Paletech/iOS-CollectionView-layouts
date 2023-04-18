//
//  File.swift
//  
//
//  Created by LEMIN DAHOVICH on 18.04.2023.
//

import Foundation

protocol TagDataSource: AnyObject {
    func tag(at indexPath: IndexPath) -> String
}
