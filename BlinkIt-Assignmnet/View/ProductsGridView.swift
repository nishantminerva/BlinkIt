//
//  ProductsGridView.swift
//  BlinkIt-Assignmnet
//
//  Created by Nishant Minerva on 08/08/24.
//

import SwiftUI

struct ProductsGridView: View {
    
    let category: Category
    
    var body: some View {
        ScrollView(.vertical) {
            LazyVGrid(columns: Array(repeating: GridItem(), count: 2), content: {
                ForEach(category.items) { item in
                    ProductCard(productDetails: Item(id: item.id, name: item.name, price: item.price, discountedPrice: item.discountedPrice, deliveryTime: item.deliveryTime, weight: item.weight, image: item.image))
                       
                }
            })
            .padding(8)
        }
        .scrollIndicators(.hidden)
    }
}
