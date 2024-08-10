//
//  Item.swift
//  BlinkIt-Assignmnet
//
//  Created by Nishant Minerva on 08/08/24.
//

import Foundation

struct Item: Codable, Identifiable {
    var id: Int
    let name: String
    let price: Int
    let discountedPrice: Int
    let deliveryTime: Int
    let weight: String
    let image: String
}
