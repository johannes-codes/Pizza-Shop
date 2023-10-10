//
//  Overview.swift
//  Pizza Shop
//
//  Created by Meißner, Johannes, HSE DE on 06.10.23.
//

import SwiftUI

struct Overview: View {
    @Binding var selectedDish: Dish?
    @Binding var detailViewShown: Bool
    @Binding var checkoutViewShown: Bool
    @Binding var order: [Dish]

    @State private var selectedCategory: String = "pizza"

    var body: some View {
        VStack {
            // MARK: Header
            HStack {
                Image(systemName: "location")
                    .templateImage(width: 17.0, color: Constant.primary)
                
                Text("Boston, MA")
                    .font(.system(size: 15.0, weight: .regular))
                    .foregroundColor(Constant.text)
                
                Spacer()
                
                Image(systemName: "magnifyingglass")
                    .templateImage(width: 22.0, color: Constant.text)
            }
            .padding(.horizontal, 16.0)
            .padding(.top, 15.0)
            
            // MARK: Previous Order
            VStack(alignment: .leading, spacing: 5.0) {
                Text("Order again?")
                    .font(.system(size: 15.0, weight: .semibold))
                    .foregroundColor(Constant.text)
                Text("Hot Salami Pizza, Cole Slow, Pepsi")
                    .font(.system(size: 12.0, weight: .light))
                    .foregroundColor(.gray)
                
                HStack(alignment: .center, spacing: 10.0) {
                    ZStack {
                        Image("pizza-peperoni")
                            .resizable()
                            .renderingMode(.original)
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 35.0)
                            .padding(0.5)
                            .background(Constant.white)
                            .overlay {
                                RoundedRectangle(cornerRadius: 20.0)
                                    .stroke(.gray, lineWidth: 0.5)
                            }
                            .clipShape(RoundedRectangle(cornerRadius: 20.0))
                            .zIndex(3)
                        
                        Image("pizza-peperoni")
                            .resizable()
                            .renderingMode(.original)
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 35.0)
                            .padding(0.5)
                            .background(Constant.white)
                            .overlay {
                                RoundedRectangle(cornerRadius: 20.0)
                                    .stroke(.gray, lineWidth: 0.5)
                            }
                            .clipShape(RoundedRectangle(cornerRadius: 20.0))
                            .zIndex(2)
                            .offset(x: 25.0)
                        
                        Image("pizza-peperoni")
                            .resizable()
                            .renderingMode(.original)
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 35.0)
                            .padding(0.5)
                            .background(Constant.white)
                            .overlay {
                                RoundedRectangle(cornerRadius: 20.0)
                                    .stroke(.gray, lineWidth: 0.5)
                            }
                            .clipShape(RoundedRectangle(cornerRadius: 20.0))
                            .zIndex(1)
                            .offset(x: 50.0)
                    }
                    
                    Text("$24,99")
                        .font(.system(size: 12.0, weight: .bold))
                        .foregroundColor(Constant.white)
                        .padding(.vertical, 5.0)
                        .padding(.horizontal, 5.0)
                        .background(Constant.primary)
                        .cornerRadius(5.0)
                        .offset(x: 50.0)
                    
                    Spacer()
                    
                    Image(systemName: "plus")
                        .templateImage(width: 13.0, color: Constant.primary)
                        .padding(5.0)
                        .overlay {
                            RoundedRectangle(cornerRadius: 5.0)
                                .stroke(Constant.primary, lineWidth: 1.5)
                        }
                }
            }
            .padding(15.0)
            .background(Constant.white)
            .cornerRadius(15.0)
            .dropShadow()
            .padding(.horizontal, 16.0)
            .padding(.bottom, 20.0)
            
            // MARK: Menu Categories
            ScrollView(.horizontal, showsIndicators: false) {
                let categories = ["pizza", "burger", "sidings", "drinks", "warm drinks"]
                
                HStack(spacing: 15.0) {
                    ForEach(Array(categories.enumerated()), id: \.offset) { index, category in
                        let selected = category == selectedCategory
                        
                        VStack(alignment: .center) {
                            Image(category)
                                .originalImage(width: 64.0)
                            Text(category.capitalized)
                                .font(.system(size: 12.0, weight: .regular))
                                .foregroundColor(selected ? Constant.white : Constant.text)
                                .bold(selected)
                        }
                        .padding(.vertical, 10.0)
                        .padding(.horizontal, 15.0)
                        .background(selected ? Constant.primary : Constant.white)
                        .cornerRadius(20.0)
                        .dropShadow()
                        .padding(.bottom, 15.0)
                        .offset(x: 16.0)
                        .onTapGesture {
                            withAnimation {
                                selectedCategory = category
                            }
                        }
                    }
                }
            }
            
            // MARK: Dishes
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: -25.0) {
                    ForEach(Array(dishes.enumerated()), id: \.offset) { index, dish in
                        Button(action: {
                            selectedDish = dish
                            detailViewShown.toggle()
                        }, label: {
                            let lastWhileOrderVisible = (index == (dishes.count - 1) && !order.isEmpty)
                            HStack(alignment: .center) {
                                // MARK: Dish Image
                                let size = UIScreen.main.bounds.size.width * 0.55
                                Color.clear
                                    .frame(width: size, height: size)
                                    .anchorPreference(key: MAnchorKey.self, value: .bounds, transform: { anchor in
                                        return [dish.id: anchor]
                                    })
                                    .offset(x: -22.0)
                                
                                Spacer()
                                
                                // MARK: Dish Details
                                VStack(alignment: .leading) {
                                    Text(dish.title)
                                        .font(.system(size: 14.0, weight: .semibold))
                                        .foregroundColor(Constant.text)
                                    Text("\(dish.weight)g")
                                        .font(.system(size: 14.0, weight: .light))
                                        .foregroundColor(.gray)
                                    HStack {
                                        Text(dish.price.formatted(.currency(code: "USD")))
                                            .font(.system(size: 12.0, weight: .regular))
                                            .foregroundColor(Constant.white)
                                            .padding(.vertical, 3.0)
                                            .padding(.horizontal, 5.0)
                                            .background(Constant.primary)
                                            .cornerRadius(5.0)
                                        
                                        Spacer()
                                        
                                        Image(systemName: "plus")
                                            .templateImage(width: 13.0, color: Constant.primary)
                                            .padding(5.0)
                                            .overlay {
                                                RoundedRectangle(cornerRadius: 5.0)
                                                    .stroke(Constant.primary, lineWidth: 1.5)
                                            }
                                            .onTapGesture {
                                                withAnimation(.easeOut) {
                                                    order.append(dish)
                                                }
                                            }
                                    }
                                    .padding(.trailing, 5.0)
                                }
                            }
                            .padding(.bottom, lastWhileOrderVisible ? 85.0 : 0.0)
                        })
                    }
                }
            }
            .fadeOutTop(fadeLength: 65.0)
            .padding(.horizontal, 16.0)
            .edgesIgnoringSafeArea(.bottom)
            .overlay(alignment: .bottom, content: {
                // MARK: Basket
                if !order.isEmpty {
                    HStack(spacing: 25.0) {
                        VStack(alignment: .leading) {
                            let total = order.map { $0.total }.reduce(0, +)
                            Text(total.formatted(.currency(code: "USD")))
                                .font(.system(size: 18.0, weight: .bold))
                                .foregroundColor(Constant.primary)
                            
                            Text("\(order.count) Items")
                                .font(.system(size: 10.0, weight: .light))
                                .foregroundColor(.gray)
                        }
                        
                        Text("Go to Cart")
                            .font(.system(size: 18.0, weight: Font.Weight.medium))
                            .foregroundColor(Constant.white)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 15.0)
                            .background(Constant.primary)
                            .cornerRadius(15.0)
                            .onTapGesture {
                                checkoutViewShown.toggle()
                            }
                    }
                    .frame(maxWidth: .infinity)
                    .frame(height: 50.0)
                    .padding(.top, 15.0)
                    .padding(.horizontal, 26.0)
                    .edgesIgnoringSafeArea(.bottom)
                    .background(Constant.background)
                    .transition(.move(edge: .bottom))
                    .overlay(
                        Rectangle()
                            .frame(width: nil, height: 1, alignment: .top)
                            .foregroundColor(Color.gray.opacity(0.3))
                        , alignment: .top
                    )
                }
            })
            .overlayPreferenceValue(MAnchorKey.self, { value in
                GeometryReader(content: { geometry in
                    ForEach(dishes) { dish in
                        if let anchor = value[dish.id], selectedDish?.id != dish.id {
                            let rect = geometry[anchor]
                            ImageView(dish: dish, size: rect.size)
                                .offset(x: rect.minX, y: rect.minY)
                                .allowsHitTesting(false)
                        }
                    }
                })
            })
        }
    }
}

#Preview {
    ContentView()
}
