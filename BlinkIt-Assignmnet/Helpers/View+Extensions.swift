//
//  View+Extensions.swift
//  BlinkIt-Assignmnet
//
//  Created by Nishant Minerva on 08/08/24.
//

import SwiftUI

//Offset Key
struct OffsetKey: PreferenceKey {
    static var defaultValue: CGFloat = .zero
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}


extension View {
    @ViewBuilder
    func offsetY(completion: @escaping (CGFloat) -> ()) -> some View {
        self.overlay {
            GeometryReader {
                let minY = $0.frame(in: .scrollView(axis: .vertical)).minY
                
                Color.clear
                    .preference(key: OffsetKey.self, value: minY)
                    .onPreferenceChange(OffsetKey.self, perform: completion)
            }
        }
    }
    
    //Tab bar Masking
    func tabMask(_ tabProgress: CGFloat) -> some View {
        ZStack{
            self
                .foregroundStyle(.gray)
            self
                .symbolVariant(.fill)
                .mask {
                    GeometryReader {
                        let size = $0.size
                        let rectangleHeight = size.height / CGFloat(Tab.allCases.count)
                        
                        Rectangle()
                            .frame(height: rectangleHeight)
                            .offset(x: tabProgress * (size.height - rectangleHeight))
                    }
                }
        }
    }
    
}


#Preview {
    Home()
}
