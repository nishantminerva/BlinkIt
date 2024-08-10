//
//  BlinkIt_AssignmnetApp.swift
//  BlinkIt-Assignmnet
//
//  Created by Nishant Minerva on 08/08/24.
//

import SwiftUI

@main
struct BlinkIt_AssignmnetApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                
                Text("Nishant Minerva")
                    .font(.title)
                    .bold()
                    .fontWeight(.heavy)
                    .foregroundStyle(LinearGradient(gradient: Gradient(colors: [Constants.lgStartColor, Constants.lgEndColor]), startPoint: .leading, endPoint: .trailing))
                NavigationLink {
                    Home()
                } label: {
                    Text("Normal")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .foregroundStyle(.white)
                        .background(Color.purple)
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                       
                }
                .padding()
                
                NavigationLink {
                    Experiment()
                } label: {
                    Text("Experimental")
                        .padding()
                        .frame(maxWidth: .infinity)
                        .foregroundStyle(.white)
                        .background(Color.purple)
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                }
                .padding()
            }
        }
    }
}


enum Constants {
    
    static let lgStartColor = Color(hex: "#6446B5")
    static let lgEndColor = Color(hex: "#E9A6C2")
}

extension Color {
    init(hex: String) {
        let hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines).replacingOccurrences(of: "#", with: "")
        var rgb: UInt64 = 0
        
        Scanner(string: hexSanitized).scanHexInt64(&rgb)
        
        let r = Double((rgb & 0xFF0000) >> 16) / 255.0
        let g = Double((rgb & 0x00FF00) >> 8) / 255.0
        let b = Double(rgb & 0x0000FF) / 255.0
        
        self.init(.sRGB, red: r, green: g, blue: b, opacity: 1.0)
    }
}
