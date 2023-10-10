//
//  Detail.swift
//  Pizza Shop
//
//  Created by Meißner, Johannes, HSE DE on 06.10.23.
//

import SwiftUI

struct Detail: View {
    @Binding var dish: Dish?
    @Binding var order: [Dish]
    @Binding var pushView: Bool
    @Binding var hideView: (Bool, Bool)
    @State private var bottomVisible = false
    
    private let screen = UIScreen.main.bounds.size
    
    var body: some View {
        if let dish {
            ZStack {
                GeometryReader(content: { geometry in
                    let size = geometry.size
                    VStack {
                        if hideView.0 {
                            ImageView(dish: dish, size: size)
                                .overlay(alignment: .top) {
                                    ZStack {
                                        Button(action: {
                                            hideView.0 = false
                                            hideView.1 = false
                                            pushView = false
                                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.45) {
                                                self.dish = nil
                                            }
                                        }, label: {
                                            Image(systemName: "arrow.backward")
                                                .templateImage(width: 22.0, color: Constant.text)
                                        })
                                        .padding(15)
                                        .padding(.top, 40)
                                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                                        .contentShape(Rectangle())
                                        .offset(y: (screen.width / 2.5))
                                    }
                                    .opacity(hideView.1 ? 1 : 0)
                                    .animation(.snappy, value: hideView.1)
                                }
                                .onAppear(perform: {
                                    DispatchQueue.main.asyncAfter(deadline: .now()) {
                                        hideView.1 = true
                                    }
                                })
                        } else {
                            Color.clear
                        }
                    }
                    .anchorPreference(key: MAnchorKey.self, value: .bounds, transform: { anchor in
                        return [dish.id: anchor]
                    })
                })
                .frame(width: screen.width, height: screen.width * 1.5)
                .offset(y: -(screen.width * 0.77))
                .toolbar(.hidden, for: .navigationBar)
                .ignoresSafeArea()
                .onAppear(perform: {
                    withAnimation(.snappy(duration: 0.5, extraBounce: 0.0)) {
                        bottomVisible = true
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        hideView.0 = true
                    }
                })

                VStack {
                    Spacer()
                    if bottomVisible {
                        VStack {
                            VStack(alignment: .leading, spacing: 15.0) {
                                VStack(alignment: .leading, spacing: 2.0) {
                                    Text("\(dish.weight)g")
                                        .font(.system(size: 18.0, weight: .semibold))
                                        .foregroundColor(Constant.primary)
                                    
                                    Text(dish.title)
                                        .font(.system(size: 35.0, weight: .semibold))
                                        .foregroundColor(Constant.text)
                                }
                                
                                HStack {
                                    ForEach(dish.nutritious, id: \.self) { nutrition in
                                        ZStack {
                                            Rectangle()
                                                .fill(Color.white)
                                            Text(nutrition)
                                                .font(.system(size: 16.0, weight: .light))
                                                .foregroundColor(Constant.text)
                                        }
                                        .frame(height: 35.0)
                                        .frame(maxWidth: .infinity)
                                        .cornerRadius(15.0)
                                    }
                                }
                                .frame(maxWidth: .infinity)
                                
                                Rectangle()
                                    .fill(.gray.opacity(0.5))
                                    .frame(maxWidth: .infinity)
                                    .frame(height: 0.5)
                                
                                Text("Spicy pepperoni, increased portion of mozzarella, tomatoes, specialty tomato sauce.")
                                    .lineLimit(5)
                                    .font(.system(size: 16.0, weight: .regular))
                                    .foregroundColor(Constant.text)
                                
                                HStack(spacing: 8.0) {
                                    Text("Toppings:")
                                        .font(.system(size: 18.0, weight: .semibold))
                                        .foregroundColor(Constant.text)
                                    
                                    Text("+$1.00")
                                        .font(.system(size: 18.0, weight: .semibold))
                                        .foregroundColor(Constant.primary)
                                }
                            }
                            .padding(.horizontal, 16.0)
                            
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: 10.0) {
                                    ForEach(toppings) { topping in
                                        let selected = self.dish?.extras.map { $0.id }.contains(topping.id) ?? false
                                        VStack(alignment: .center, spacing: 10.0) {
                                            Image(topping.image)
                                                .originalImage(width: 64.0)
                                            Text(topping.name.capitalized)
                                                .font(.system(size: 14.0, weight: .regular))
                                                .foregroundColor(selected ? Constant.white : Constant.text)
                                        }
                                        .frame(width: 110, height: 120)
                                        .background(selected ? Constant.primary : Constant.white)
                                        .cornerRadius(20.0)
                                        .dropShadow()
                                        .padding(.bottom, 15.0)
                                        .offset(x: 16.0)
                                        .onTapGesture {
                                            selected ? self.dish?.extras.removeAll(where: { $0.id == topping.id }) : self.dish?.extras.append(topping)
                                        }
                                    }
                                }
                            }
                            
                            HStack(spacing: 25.0) {
                                VStack(alignment: .leading) {
                                    let total = dish.price + dish.extras.compactMap { $0.price }.reduce(0, +)
                                    Text(total.formatted(.currency(code: "USD")))
                                        .font(.system(size: 20.0, weight: .bold))
                                        .foregroundColor(Constant.primary)
                                }

                                Button {
                                    order.append(dish)

                                    hideView.0 = false
                                    hideView.1 = false
                                    pushView = false
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.45) {
                                        self.dish = nil
                                    }
                                } label: {
                                    Text("Add to Cart")
                                        .font(.system(size: 18.0, weight: Font.Weight.medium))
                                        .foregroundColor(Constant.white)
                                        .frame(maxWidth: .infinity)
                                        .padding(.vertical, 20.0)
                                        .background(Constant.primary)
                                        .cornerRadius(15.0)
                                }
                            }
                            .frame(maxWidth: .infinity)
                            .frame(height: 50.0)
                            .padding(.top, 15.0)
                            .padding(.horizontal, 20.0)
                            .edgesIgnoringSafeArea(.bottom)
                            .transition(.move(edge: .bottom))
                            .overlay(
                                Rectangle()
                                    .frame(width: nil, height: 1, alignment: .top)
                                    .foregroundColor(Color.gray.opacity(0.3))
                                , alignment: .top
                            )
                        }
                        .frame(height: screen.height * 0.6, alignment: .bottom)
                        .transition(.move(edge: .bottom))
                        .zIndex(1)
                    } else {
                        Color.clear
                    }
                }
            }
            .background(Constant.background)
        }
    }
}

#Preview {
    ContentView()
}
