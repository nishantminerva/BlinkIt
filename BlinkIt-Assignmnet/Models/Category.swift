//
//  Category.swift
//  BlinkIt-Assignmnet
//
//  Created by Nishant Minerva on 08/08/24.
//

import Foundation

struct Category : Codable {
    let categoryName: String
    let categoryImage: String
    let items: [Item]
}

