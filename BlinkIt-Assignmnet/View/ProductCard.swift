//
//  ProductCard.swift
//  BlinkIt-Assignmnet
//
//  Created by Nishant Minerva on 08/08/24.
//

import SwiftUI

struct ProductCard: View {
    
    let productDetails: Item
    
    var body: some View {
        ZStack(alignment: .topLeading){
            VStack(spacing: 0) {
                AsyncImage(url: URL(string: "https://picsum.photos/id/\(Int.random(in: 1..<100))/200/300")) { Image in
                    Image
                        .resizable()
                        .frame(height: UIScreen.main.bounds.height * 0.15 )
                } placeholder: {
                    ProgressView()
                        .frame(height: UIScreen.main.bounds.height * 0.15 )
                }
                
                
                
                VStack(alignment: .leading) {
                    Text("〄 \(productDetails.deliveryTime) mins")
                        .font(.system(size: 10))
                        .bold()
                        .textCase(.uppercase)
                        .padding(2.5)
                        .background(.gray.opacity(0.2))
                        .clipShape(Capsule())
                    Text(productDetails.name)
                        .fontWeight(.semibold)
                        .font(.system(size: 13))
                    Text("\(productDetails.weight)")
                        .foregroundStyle(.gray)
                        .font(.system(size: 12))
                    
                    HStack{
                        VStack{
                            Text("₹\(productDetails.discountedPrice)")
                                .bold()
                                .font(.system(size: 12))
                            Text("₹\(productDetails.price)")
                                .bold()
                                .strikethrough()
                                .font(.system(size: 12))
                                .foregroundStyle(.gray)
                        }
                        Spacer()
                        
                        Button {} label: {
                            Text("ADD")
                                .font(.system(size: 13))
                                .foregroundStyle(.green)
                                .padding(.horizontal)
                                .padding(.vertical, 5)
                                .background {
                                    RoundedRectangle(cornerRadius: 8)
                                        .stroke(Color.green, lineWidth: 1)
                                }
                        }
                    }
                    
                    
                }
                .padding(6)
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            HStack{
                Image("disBatch")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 40,height: 40)
            }
        }
        .background(.white)
        .cornerRadius(8)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}


#Preview {
    Home()
}
