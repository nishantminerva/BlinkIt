//
//  Home.swift
//  BlinkIt-Assignmnet
//
//  Created by Nishant Minerva on 08/08/24.
//

import SwiftUI

struct Home: View {
    @Environment(\.dismiss) var dismiss
    // View Properties
    @State private var selectedTab: Tab? = .all
    @Environment(\.colorScheme) private var scheme
    //Tab Progress
    @State private var tabProgress: CGFloat = 0.5
    
    var body: some View {
        VStack(spacing: 15){
            HStack{
                Button(action: {
                    dismiss()
                }) {
                    HStack{
                        Image(systemName: "chevron.left")
                            .foregroundStyle(.black)
                        Text("Vegetables & Fruits")
                            .foregroundStyle(.black)
                            .bold()
                    }
                }
                Spacer()
                Image(systemName: "magnifyingglass")
            }
            .padding(.top)
            .padding(.leading)
            .padding(.trailing)
            .padding(.bottom,0)
            
            HStack(spacing: 0) {
                //Custom Vertical tab
                CustomVerticalTab()
                    .frame(width: UIScreen.main.bounds.width * 0.15)
                
                // Tab Items Content
                // Paging View
                GeometryReader { geometry in
                    let size = geometry.size
                    
                    ScrollView(.vertical) {
                        LazyVStack(spacing: 0) {
                            ForEach(Tab.allCases, id: \.self) { i in
                                ProductsGridView(category:
                                                i.category)
                                .id(i)
                                .containerRelativeFrame(.vertical)
                            }
                        }
                        .scrollTargetLayout()
                        .offsetY { value in
                           // Converting Offset into Progress for selected tab indication
//                            print(value)
                            let progress = -value / (size.height * CGFloat(Tab.allCases.count - 1))
                            //Capping Progress BTW 0-1
                            tabProgress = max(min(progress, 1), 0)
                        }
                    }
                   
                    .scrollPosition(id: $selectedTab)
                    .scrollIndicators(.hidden)
                    .scrollTargetBehavior(.paging)
                    .background(.gray.opacity(0.1))
//                    .scrollClipDisabled()
                    .ignoresSafeArea()
                }
                .frame(width: UIScreen.main.bounds.width * 0.85)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .navigationBarBackButtonHidden(true)

    }

    @ViewBuilder
    func CustomVerticalTab() -> some View {
        ScrollViewReader { proxy in
            ScrollView(showsIndicators: false) {
                VStack(spacing: 5) {
                    ForEach(Tab.allCases, id: \.self) { tab in
                        VStack {
                            Image(tab.images)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 45, height: 45)
                                .background(selectedTab == tab ? Color.green.opacity(0.5) : Color.gray.opacity(0.1))
                                .clipShape(Circle())
                            Text(tab.rawValue)
                                .font(.system(size: 8))
                                .multilineTextAlignment(.center)
                                .foregroundStyle(selectedTab == tab ? Color.black : Color.gray)
                        }
                        .padding(.horizontal, 6)
                        .onTapGesture {
                            withAnimation(.snappy) {
                                selectedTab = tab
                            }
                        }
                        .id(tab) // Set ID for each tab for scrollTo functionality
                    }
                }
                .background(GeometryReader { geometry in
                    let heightPerTab = geometry.size.height / CGFloat(Tab.allCases.count)
                    let index = Tab.allCases.firstIndex(of: selectedTab ?? .all) ?? 0
                    let yPosition = CGFloat(index) * heightPerTab

                    // Active tab indicator
                    HStack{
                        Spacer()
                        
                        UnevenRoundedRectangle(cornerRadii: .init(
                            topLeading: 50.0,
                            bottomLeading: 10.0,
                            bottomTrailing: 0,
                            topTrailing: 0),
                                               style: .continuous)
                            .foregroundStyle(scheme == .dark ? Color.black : Color.green)
                            .frame(width: 5, height: heightPerTab)
                            .offset(y: yPosition)
                            .animation(.default, value: selectedTab)
                    }
                })
                .onChange(of: selectedTab) {
                        withAnimation {
                            proxy.scrollTo(selectedTab, anchor: .center) // Scroll to the new value
                        }
                }
            }
        }

    }

}


#Preview {
    Home()
}

enum Tab: String, CaseIterable {
    case all = "All"
    case freshVegetables = "Fresh \nVegetables"
    case freshFruit = "Fresh \nFruits"
    case flowersAndLeaves = "Flowers \n& Leaves"
    case corianderOthers = "Corlandar \n& Others"
    case exotics = "Excotics"
    case mangoesMelons = "Mangoes & Melons"
    case seasonal = "Seasonal"
    case freshlyCutSprouts = "Freshly Cut \n& Sprouts"
    case frozenVeg = "Frozen \nVeg"
    
    var category: Category {
        switch self {
        case .all:
            Category(
                categoryName: "Fresh Fruits",
                categoryImage: "fresh_fruits.png",
                items: [
                    Item(id: 1, name: "Apple", price: 50, discountedPrice: 45, deliveryTime: 24, weight: "1 kg", image: "apple.png"),
                    Item(id: 2, name: "Banana", price: 30, discountedPrice: 25, deliveryTime: 24, weight: "1 kg", image: "banana.png"),
                    Item(id: 3, name: "Daisy", price: 80, discountedPrice: 75, deliveryTime: 24, weight: "10 stems", image: "daisy.png"),
                    Item(id: 4, name: "Lavender", price: 150, discountedPrice: 145, deliveryTime: 24, weight: "10 stems", image: "lavender.png"),
                    Item(id: 11, name: "Chives", price: 25, discountedPrice: 20, deliveryTime: 24, weight: "50 g", image: "chives.png"),
                    Item(id: 133, name: "Cilantro", price: 15, discountedPrice: 10, deliveryTime: 24, weight: "100 g", image: "cilantro.png"),
                    Item(id: 151, name: "Fiddleheads", price: 200, discountedPrice: 190, deliveryTime: 24, weight: "250 g", image: "fiddleheads.png"),
                    Item(id: 12, name: "Black Truffle", price: 1000, discountedPrice: 950, deliveryTime: 24, weight: "100 g", image: "black_truffle.png"),
                    Item(id: 9, name: "Frozen Green Beans", price: 45, discountedPrice: 40, deliveryTime: 48, weight: "500 g", image: "frozen_green_beans.png"),
                    Item(id: 10, name: "Frozen Bell Peppers", price: 70, discountedPrice: 65, deliveryTime: 48, weight: "500 g", image: "frozen_bell_peppers.png"),
                    Item(id: 112, name: "Frozen Corn on the Cob", price: 60, discountedPrice: 55, deliveryTime: 48, weight: "4 cobs", image: "frozen_corn_cob.png"),
                    Item(id: 122, name: "Frozen Peas and Carrots", price: 50, discountedPrice: 45, deliveryTime: 48, weight: "500 g", image: "frozen_peas_carrots.png")

                ]
            )
        case .freshFruit:
            Category(
                categoryName: "Fresh Fruits",
                categoryImage: "fresh_fruits.png",
                items: [
                    Item(id: 1, name: "Apple", price: 50, discountedPrice: 45, deliveryTime: 24, weight: "1 kg", image: "apple.png"),
                    Item(id: 2, name: "Banana", price: 30, discountedPrice: 25, deliveryTime: 24, weight: "1 kg", image: "banana.png"),
                    Item(id: 3, name: "Orange", price: 40, discountedPrice: 35, deliveryTime: 24, weight: "1 kg", image: "orange.png"),
                    Item(id: 4, name: "Grapes", price: 60, discountedPrice: 55, deliveryTime: 24, weight: "500 g", image: "grapes.png"),
                    Item(id: 5, name: "Pear", price: 50, discountedPrice: 45, deliveryTime: 24, weight: "1 kg", image: "pear.png"),
                    Item(id: 6, name: "Cherry", price: 120, discountedPrice: 110, deliveryTime: 24, weight: "500 g", image: "cherry.png"),
                    Item(id: 7, name: "Peach", price: 70, discountedPrice: 65, deliveryTime: 24, weight: "1 kg", image: "peach.png"),
                    Item(id: 8, name: "Plum", price: 80, discountedPrice: 75, deliveryTime: 24, weight: "500 g", image: "plum.png"),
                    Item(id: 9, name: "Kiwi", price: 150, discountedPrice: 140, deliveryTime: 24, weight: "500 g", image: "kiwi.png"),
                    Item(id: 10, name: "Pineapple", price: 90, discountedPrice: 85, deliveryTime: 24, weight: "1 each", image: "pineapple.png"),
                    Item(id: 11, name: "Mango", price: 100, discountedPrice: 95, deliveryTime: 24, weight: "1 kg", image: "mango.png"),
                    Item(id: 12, name: "Blueberries", price: 200, discountedPrice: 190, deliveryTime: 24, weight: "250 g", image: "blueberries.png")

                ]
            )
        case .flowersAndLeaves:
            Category(
                categoryName: "Flowers & Leaves",
                categoryImage: "flowers_leaves.png",
                items: [
                    Item(id: 1, name: "Rose", price: 100, discountedPrice: 90, deliveryTime: 24, weight: "10 stems", image: "rose.png"),
                    Item(id: 2, name: "Tulip", price: 150, discountedPrice: 140, deliveryTime: 24, weight: "10 stems", image: "tulip.png"),
                    Item(id: 3, name: "Daisy", price: 80, discountedPrice: 75, deliveryTime: 24, weight: "10 stems", image: "daisy.png"),
                    Item(id: 4, name: "Lavender", price: 150, discountedPrice: 145, deliveryTime: 24, weight: "10 stems", image: "lavender.png"),
                    Item(id: 5, name: "Sunflower", price: 100, discountedPrice: 95, deliveryTime: 24, weight: "5 stems", image: "sunflower.png"),
                    Item(id: 6, name: "Orchid", price: 220, discountedPrice: 210, deliveryTime: 24, weight: "5 stems", image: "orchid.png"),
                    Item(id: 7, name: "Lilies", price: 180, discountedPrice: 175, deliveryTime: 24, weight: "5 stems", image: "lilies.png"),
                    Item(id: 8, name: "Chrysanthemum", price: 110, discountedPrice: 100, deliveryTime: 24, weight: "10 stems", image: "chrysanthemum.png"),
                    Item(id: 9, name: "Hydrangea", price: 250, discountedPrice: 240, deliveryTime: 24, weight: "3 stems", image: "hydrangea.png"),
                    Item(id: 10, name: "Peonies", price: 300, discountedPrice: 290, deliveryTime: 24, weight: "5 stems", image: "peonies.png"),
                    Item(id: 11, name: "Carnations", price: 90, discountedPrice: 85, deliveryTime: 24, weight: "10 stems", image: "carnations.png"),
                    Item(id: 12, name: "Marigold", price: 70, discountedPrice: 65, deliveryTime: 24, weight: "15 stems", image: "marigold.png")

                ]
            )
        case .corianderOthers:
            Category(
                categoryName: "Coriander & Others",
                categoryImage: "coriander_others.png",
                items: [
                    Item(id: 1, name: "Coriander", price: 20, discountedPrice: 15, deliveryTime: 24, weight: "100 g", image: "coriander.png"),
                    Item(id: 2, name: "Parsley", price: 25, discountedPrice: 20, deliveryTime: 24, weight: "100 g", image: "parsley.png"),
                    Item(id: 3, name: "Mint", price: 15, discountedPrice: 10, deliveryTime: 24, weight: "100 g", image: "mint.png"),
                    Item(id: 4, name: "Thyme", price: 30, discountedPrice: 25, deliveryTime: 24, weight: "50 g", image: "thyme.png"),
                    Item(id: 5, name: "Basil", price: 20, discountedPrice: 18, deliveryTime: 24, weight: "100 g", image: "basil.png"),
                    Item(id: 6, name: "Oregano", price: 25, discountedPrice: 20, deliveryTime: 24, weight: "50 g", image: "oregano.png"),
                    Item(id: 7, name: "Rosemary", price: 40, discountedPrice: 35, deliveryTime: 24, weight: "50 g", image: "rosemary.png"),
                    Item(id: 8, name: "Sage", price: 30, discountedPrice: 25, deliveryTime: 24, weight: "50 g", image: "sage.png"),
                    Item(id: 9, name: "Lemongrass", price: 20, discountedPrice: 15, deliveryTime: 24, weight: "100 g", image: "lemongrass.png"),
                    Item(id: 10, name: "Dill", price: 15, discountedPrice: 12, deliveryTime: 24, weight: "50 g", image: "dill.png"),
                    Item(id: 11, name: "Chives", price: 25, discountedPrice: 20, deliveryTime: 24, weight: "50 g", image: "chives.png"),
                    Item(id: 12, name: "Cilantro", price: 15, discountedPrice: 10, deliveryTime: 24, weight: "100 g", image: "cilantro.png")

                ]
            )
        case .exotics:
            Category(
                categoryName: "Exotics",
                categoryImage: "exotics.png",
                items: [
                    Item(id: 1, name: "Dragon Fruit", price: 200, discountedPrice: 180, deliveryTime: 48, weight: "500 g", image: "dragon_fruit.png"),
                    Item(id: 2, name: "Kiwi", price: 150, discountedPrice: 140, deliveryTime: 24, weight: "500 g", image: "kiwi.png"),
                    Item(id: 3, name: "Passion Fruit", price: 250, discountedPrice: 240, deliveryTime: 48, weight: "500 g", image: "passion_fruit.png"),
                    Item(id: 4, name: "Rambutan", price: 220, discountedPrice: 210, deliveryTime: 48, weight: "500 g", image: "rambutan.png"),
                    Item(id: 5, name: "Lychee", price: 180, discountedPrice: 170, deliveryTime: 24, weight: "500 g", image: "lychee.png"),
                    Item(id: 6, name: "Durian", price: 300, discountedPrice: 290, deliveryTime: 48, weight: "1 kg", image: "durian.png"),
                    Item(id: 7, name: "Guava", price: 60, discountedPrice: 55, deliveryTime: 24, weight: "1 kg", image: "guava.png"),
                    Item(id: 8, name: "Papaya", price: 50, discountedPrice: 45, deliveryTime: 24, weight: "1 kg", image: "papaya.png"),
                    Item(id: 9, name: "Star Fruit", price: 100, discountedPrice: 95, deliveryTime: 24, weight: "500 g", image: "star_fruit.png"),
                    Item(id: 10, name: "Mangosteen", price: 250, discountedPrice: 240, deliveryTime: 24, weight: "500 g", image: "mangosteen.png"),
                    Item(id: 11, name: "Pomegranate", price: 150, discountedPrice: 140, deliveryTime: 24, weight: "1 kg", image: "pomegranate.png"),
                    Item(id: 12, name: "Fig", price: 180, discountedPrice: 175, deliveryTime: 24, weight: "500 g", image: "fig.png")

                ]
            )
        case .mangoesMelons:
            Category(
                categoryName: "Mangoes & Melons",
                categoryImage: "mangoes_melons.png",
                items: [
                    Item(id: 1, name: "Mango", price: 100, discountedPrice: 90, deliveryTime: 24, weight: "1 kg", image: "mango.png"),
                    Item(id: 2, name: "Watermelon", price: 30, discountedPrice: 25, deliveryTime: 24, weight: "5 kg", image: "watermelon.png"),
                    Item(id: 3, name: "Cantaloupe", price: 60, discountedPrice: 55, deliveryTime: 24, weight: "1 each", image: "cantaloupe.png"),
                    Item(id: 4, name: "Honeydew Melon", price: 65, discountedPrice: 60, deliveryTime: 24, weight: "1 each", image: "honeydew.png"),
                    Item(id: 5, name: "Bitter Melon", price: 40, discountedPrice: 35, deliveryTime: 24, weight: "500 g", image: "bitter_melon.png"),
                    Item(id: 6, name: "Alphonso Mango", price: 120, discountedPrice: 110, deliveryTime: 24, weight: "1 kg", image: "alphonso_mango.png"),
                    Item(id: 7, name: "Green Mango", price: 50, discountedPrice: 45, deliveryTime: 24, weight: "1 kg", image: "green_mango.png"),
                    Item(id: 8, name: "Muskmelon", price: 70, discountedPrice: 65, deliveryTime: 24, weight: "1 each", image: "muskmelon.png"),
                    Item(id: 9, name: "Galia Melon", price: 60, discountedPrice: 55, deliveryTime: 24, weight: "1 each", image: "galia_melon.png"),
                    Item(id: 10, name: "Kesar Mango", price: 130, discountedPrice: 120, deliveryTime: 24, weight: "1 kg", image: "kesar_mango.png"),
                    Item(id: 11, name: "Charentais Melon", price: 90, discountedPrice: 85, deliveryTime: 24, weight: "1 each", image: "charentais_melon.png"),
                    Item(id: 12, name: "Yellow Watermelon", price: 50, discountedPrice: 45, deliveryTime: 24, weight: "5 kg", image: "yellow_watermelon.png")

                ]
            )
        case .seasonal:
            Category(
                categoryName: "Seasonal",
                categoryImage: "seasonal.png",
                items: [
                    Item(id: 1, name: "Strawberries", price: 120, discountedPrice: 100, deliveryTime: 24, weight: "500 g", image: "strawberries.png"),
                    Item(id: 2, name: "Cherries", price: 200, discountedPrice: 180, deliveryTime: 24, weight: "500 g", image: "cherries.png"),
                    Item(id: 3, name: "Persimmon", price: 150, discountedPrice: 140, deliveryTime: 24, weight: "500 g", image: "persimmon.png"),
                    Item(id: 4, name: "Quince", price: 120, discountedPrice: 110, deliveryTime: 24, weight: "1 kg", image: "quince.png"),
                    Item(id: 5, name: "Currants", price: 200, discountedPrice: 190, deliveryTime: 24, weight: "250 g", image: "currants.png"),
                    Item(id: 6, name: "Gooseberries", price: 180, discountedPrice: 170, deliveryTime: 24, weight: "250 g", image: "gooseberries.png"),
                    Item(id: 7, name: "Pumpkin", price: 50, discountedPrice: 45, deliveryTime: 48, weight: "1 kg", image: "pumpkin.png"),
                    Item(id: 8, name: "Rhubarb", price: 90, discountedPrice: 85, deliveryTime: 24, weight: "500 g", image: "rhubarb.png"),
                    Item(id: 9, name: "Asparagus", price: 150, discountedPrice: 140, deliveryTime: 24, weight: "250 g", image: "asparagus.png"),
                    Item(id: 10, name: "Artichoke", price: 120, discountedPrice: 110, deliveryTime: 48, weight: "500 g", image: "artichoke.png"),
                    Item(id: 11, name: "Fiddleheads", price: 200, discountedPrice: 190, deliveryTime: 24, weight: "250 g", image: "fiddleheads.png"),
                    Item(id: 12, name: "Black Truffle", price: 1000, discountedPrice: 950, deliveryTime: 24, weight: "100 g", image: "black_truffle.png")

                ]
            )
        case .freshlyCutSprouts:
            Category(
                categoryName: "Freshly Cut & Sprouts",
                categoryImage: "freshly_cut_sprouts.png",
                items: [
                    Item(id: 1, name: "Bean Sprouts", price: 60, discountedPrice: 50, deliveryTime: 24, weight: "250 g", image: "bean_sprouts.png"),
                    Item(id: 2, name: "Alfalfa Sprouts", price: 70, discountedPrice: 60, deliveryTime: 24, weight: "250 g", image: "alfalfa_sprouts.png"),
                    Item(id: 3, name: "Mixed Sprouts", price: 60, discountedPrice: 55, deliveryTime: 24, weight: "250 g", image: "mixed_sprouts.png"),
                    Item(id: 4, name: "Broccoli Sprouts", price: 70, discountedPrice: 65, deliveryTime: 24, weight: "250 g", image: "broccoli_sprouts.png"),
                    Item(id: 5, name: "Radish Sprouts", price: 65, discountedPrice: 60, deliveryTime: 24, weight: "250 g", image: "radish_sprouts.png"),
                    Item(id: 6, name: "Pea Shoots", price: 50, discountedPrice: 45, deliveryTime: 24, weight: "250 g", image: "pea_shoots.png"),
                    Item(id: 7, name: "Wheatgrass", price: 80, discountedPrice: 75, deliveryTime: 24, weight: "250 g", image: "wheatgrass.png"),
                    Item(id: 8, name: "Microgreens", price: 90, discountedPrice: 85, deliveryTime: 24, weight: "100 g", image: "microgreens.png"),
                    Item(id: 9, name: "Sunflower Sprouts", price: 70, discountedPrice: 65, deliveryTime: 24, weight: "250 g", image: "sunflower_sprouts.png"),
                    Item(id: 10, name: "Mustard Sprouts", price: 50, discountedPrice: 45, deliveryTime: 24, weight: "250 g", image: "mustard_sprouts.png"),
                    Item(id: 11, name: "Cress", price: 40, discountedPrice: 35, deliveryTime: 24, weight: "100 g", image: "cress.png"),
                    Item(id: 12, name: "Kale Sprouts", price: 80, discountedPrice: 75, deliveryTime: 24, weight: "250 g", image: "kale_sprouts.png")

                ]
            )
        case .frozenVeg:
            Category(
                categoryName: "Frozen Veg",
                categoryImage: "frozen_veg.png",
                items: [
                    Item(id: 1, name: "Frozen Peas", price: 50, discountedPrice: 45, deliveryTime: 48, weight: "500 g", image: "frozen_peas.png"),
                    Item(id: 2, name: "Frozen Corn", price: 40, discountedPrice: 35, deliveryTime: 48, weight: "500 g", image: "frozen_corn.png"),
                    Item(id: 3, name: "Frozen Mixed Vegetables", price: 60, discountedPrice: 55, deliveryTime: 48, weight: "500 g", image: "frozen_mixed_vegetables.png"),
                    Item(id: 4, name: "Frozen Broccoli", price: 50, discountedPrice: 45, deliveryTime: 48, weight: "500 g", image: "frozen_broccoli.png"),
                    Item(id: 5, name: "Frozen Spinach", price: 40, discountedPrice: 35, deliveryTime: 48, weight: "500 g", image: "frozen_spinach.png"),
                    Item(id: 6, name: "Frozen Carrots", price: 40, discountedPrice: 35, deliveryTime: 48, weight: "500 g", image: "frozen_carrots.png"),
                    Item(id: 7, name: "Frozen Cauliflower", price: 50, discountedPrice: 45, deliveryTime: 48, weight: "500 g", image: "frozen_cauliflower.png"),
                    Item(id: 8, name: "Frozen Edamame", price: 80, discountedPrice: 75, deliveryTime: 48, weight: "500 g", image: "frozen_edamame.png"),
                    Item(id: 9, name: "Frozen Green Beans", price: 45, discountedPrice: 40, deliveryTime: 48, weight: "500 g", image: "frozen_green_beans.png"),
                    Item(id: 10, name: "Frozen Bell Peppers", price: 70, discountedPrice: 65, deliveryTime: 48, weight: "500 g", image: "frozen_bell_peppers.png"),
                    Item(id: 11, name: "Frozen Corn on the Cob", price: 60, discountedPrice: 55, deliveryTime: 48, weight: "4 cobs", image: "frozen_corn_cob.png"),
                    Item(id: 12, name: "Frozen Peas and Carrots", price: 50, discountedPrice: 45, deliveryTime: 48, weight: "500 g", image: "frozen_peas_carrots.png")

                ]
            )
        case .freshVegetables:
            Category(
                categoryName: "Fresh Vegetables",
                categoryImage: "fresh_vegetables.png",
                items: [
                    Item(id: 1, name: "Tomato", price: 30, discountedPrice: 25, deliveryTime: 24, weight: "1 kg", image: "tomato.png"),
                    Item(id: 2, name: "Cucumber", price: 20, discountedPrice: 15, deliveryTime: 24, weight: "1 kg", image: "cucumber.png"),
                    Item(id: 3, name: "Carrot", price: 25, discountedPrice: 20, deliveryTime: 48, weight: "1 kg", image: "carrot.png"),
                    Item(id: 4, name: "Broccoli", price: 60, discountedPrice: 50, deliveryTime: 24, weight: "500 g", image: "broccoli.png"),
                    Item(id: 5, name: "Spinach", price: 35, discountedPrice: 30, deliveryTime: 24, weight: "500 g", image: "spinach.png"),
                    Item(id: 6, name: "Peas", price: 40, discountedPrice: 35, deliveryTime: 48, weight: "500 g", image: "peas.png"),
                    Item(id: 7, name: "Bell Pepper", price: 50, discountedPrice: 45, deliveryTime: 24, weight: "500 g", image: "bell_pepper.png"),
                    Item(id: 8, name: "Onion", price: 20, discountedPrice: 15, deliveryTime: 24, weight: "1 kg", image: "onion.png"),
                    Item(id: 9, name: "Garlic", price: 100, discountedPrice: 90, deliveryTime: 24, weight: "250 g", image: "garlic.png"),
                    Item(id: 10, name: "Ginger", price: 120, discountedPrice: 110, deliveryTime: 48, weight: "250 g", image: "ginger.png"),
                    Item(id: 11, name: "Mushroom", price: 70, discountedPrice: 65, deliveryTime: 24, weight: "250 g", image: "mushroom.png"),
                    Item(id: 12, name: "Lettuce", price: 30, discountedPrice: 25, deliveryTime: 24, weight: "250 g", image: "lettuce.png"),
                    Item(id: 13, name: "Sweet Potato", price: 40, discountedPrice: 35, deliveryTime: 48, weight: "1 kg", image: "sweet_potato.png"),
                    Item(id: 14, name: "Beetroot", price: 25, discountedPrice: 20, deliveryTime: 48, weight: "500 g", image: "beetroot.png"),
                    Item(id: 15, name: "Radish", price: 20, discountedPrice: 15, deliveryTime: 24, weight: "500 g", image: "radish.png")
                ]
            )
        }
    }
    
    var images: String {
        switch self {
        case .all:
            "f1"
        case .freshFruit:
            "f2"
        case .flowersAndLeaves:
            "f3"
        case .corianderOthers:
            "f1"
        case .exotics:
            "f2"
        case .mangoesMelons:
            "f3"
        case .seasonal:
            "f1"
        case .freshlyCutSprouts:
            "f2"
        case .frozenVeg:
            "f3"
        case .freshVegetables:
            "f1"
        }
    }
}

