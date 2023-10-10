//
//  Checkout.swift
//  Pizza Shop
//
//  Created by Meißner, Johannes, HSE DE on 09.10.23.
//

import SwiftUI

struct Checkout: View {
    @Binding var order: [Dish]
    @Binding var checkoutViewShown: Bool
    
    @Namespace var animation
    @State private var currentTab = "Delivery"
    
    var body: some View {
        VStack {
            // MARK: Navigation Bar
            HStack {
                Button(action: {
                    checkoutViewShown.toggle()
                }, label: {
                    Image(systemName: "arrow.backward")
                        .templateImage(width: 22.0, color: Constant.text)
                })
                .frame(width: 45.0, height: 45.0)
                .background(Constant.white)
                .cornerRadius(15.0)
                .contentShape(Rectangle())
                
                Spacer()
                
                Text("My Order")
                    .font(.system(size: 16.0, weight: .semibold))
                
                Spacer()
                
                Button(action: {
                    
                }, label: {
                    Image(systemName: "ellipsis")
                        .templateImage(width: 22.0, color: Constant.text)
                })
                .frame(width: 45.0, height: 45.0)
                .background(Constant.white)
                .cornerRadius(15.0)
                .contentShape(Rectangle())
            }
            .frame(maxWidth: .infinity)
            .padding(.horizontal, 16.0)
            
            ScrollView(.vertical) {
                // MARK: Segment Control
                HStack(alignment: .center, spacing: 0.0) {
                    ZStack {
                        let selected = currentTab == "Delivery"
                        if selected {
                            Constant.primary
                                .cornerRadius(15.0)
                                .matchedGeometryEffect(id: "TAB", in: animation)
                        }
                        
                        Text("Delivery")
                            .font(.system(size: 20.0, weight: .medium))
                            .foregroundColor(selected ? Constant.white : Constant.text)
                    }
                    .frame(height: 45.0)
                    .frame(maxWidth: .infinity)
                    .padding(5.0)
                    .onTapGesture {
                        withAnimation(.interactiveSpring(response: 0.5, dampingFraction: 0.6, blendDuration: 0.6)) {
                            currentTab = "Delivery"
                        }
                    }
                    
                    ZStack {
                        let selected = currentTab == "Takeaway"
                        
                        if selected {
                            Constant.primary
                                .cornerRadius(15.0)
                                .matchedGeometryEffect(id: "TAB", in: animation)
                        }
                        
                        Text("Takeaway")
                            .font(.system(size: 20.0, weight: .medium))
                            .foregroundColor(selected ? Constant.white : Constant.text)
                    }
                    .frame(height: 45.0)
                    .frame(maxWidth: .infinity)
                    .padding(5.0)
                    .onTapGesture {
                        withAnimation(.interactiveSpring(response: 0.5, dampingFraction: 0.6, blendDuration: 0.6)) {
                            currentTab = "Takeaway"
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .background(.white)
                .cornerRadius(15.0)
                .padding(.horizontal, 16.0)
                
                // MARK: Order Overview
                VStack(spacing: 0.0) {
                    ForEach(Array(order.enumerated()), id: \.offset) { index, dish in
                        VStack(spacing: 0.0) {
                            HStack(spacing: 20.0) {
                                ImageView(dish: dish, size: CGSize(width: 130.0, height: 130.0))
                                    .frame(width: 100.0, height: 100.0)
                                    .dropShadow()
                                    .padding(.leading, 10.0)
                                
                                VStack {
                                    HStack(alignment: .top) {
                                        VStack(alignment: .leading) {
                                            Text(dish.title)
                                                .font(.system(size: 16.0, weight: .semibold))
                                                .foregroundColor(Constant.text)
                                            
                                            Text("\(dish.weight)g")
                                                .font(.system(size: 14.0, weight: .light))
                                                .foregroundColor(.gray)
                                        }
                                        
                                        Spacer()
                                        
                                        Image(systemName: "xmark")
                                            .resizable()
                                            .frame(width: 12.0, height: 12.0)
                                            .foregroundColor(.gray)
                                            .padding(15.0)
                                            .offset(y: -7.5)
                                            .contentShape(Rectangle())
                                    }
                                    
                                    Spacer()
                                    
                                    VStack {
                                        HStack {
                                            HStack {
                                                Text(dish.price.formatted(.currency(code: "USD")))
                                                    .font(.system(size: 16.0, weight: .regular))
                                                    .foregroundColor(Constant.white)
                                                    .padding(.vertical, 5.0)
                                                    .padding(.horizontal, 8.0)
                                                    .background(Constant.primary)
                                                    .cornerRadius(5.0)
                                            }
                                            
                                            Spacer()
                                            
                                            HStack {
                                                Text("-")
                                                    .font(.system(size: 28.0))
                                                    .foregroundStyle(Constant.primary)
                                                    .frame(width: 28.0, height: 28.0)
                                                    .overlay(
                                                        RoundedRectangle(cornerRadius: 10.0)
                                                            .stroke(Constant.primary, lineWidth: 2.0)
                                                    )
                                                
                                                Text("1")
                                                    .font(.system(size: 20.0))
                                                    .foregroundStyle(Constant.primary)
                                                
                                                Text("+")
                                                    .font(.system(size: 28.0))
                                                    .foregroundStyle(Constant.primary)
                                                    .frame(width: 28.0, height: 28.0)
                                                    .overlay(
                                                        RoundedRectangle(cornerRadius: 10.0)
                                                            .stroke(Constant.primary, lineWidth: 2.0)
                                                    )
                                            }
                                        }
                                        .padding(.trailing, 10.0)
                                    }
                                }
                                .frame(height: 50.0)
                            }
                            .padding(.top, index == 0 ? 15.0 : 0.0)
                            .padding(.bottom, index == (order.count - 1) ? 15.0 : 0.0)

                            if index < (order.count - 1) {
                                Rectangle()
                                    .frame(height: 1.0)
                                    .foregroundColor(.gray.opacity(0.3))
                                    .padding(.leading, 130.0)
                                    .padding(.vertical, 15.0)
                            }
                        }
                    }
                }
                .background(Constant.white)
                .cornerRadius(15.0)
                .padding(.horizontal, 16.0)
                
                // MARK: Deliver Time / Cost
                if currentTab == "Delivery" {
                    VStack {
                        HStack {
                            Text("Delivery")
                                .font(.system(size: 20.0, weight: .semibold))
                                .foregroundColor(Constant.text)
                            
                            Spacer()
                            
                            Text("30-40min")
                                .font(.system(size: 16.0))
                                .foregroundStyle(.gray)
                                .padding(.trailing, 10.0)
                            Text("$1.99")
                                .font(.system(size: 18.0, weight: .semibold))
                                .foregroundStyle(Constant.primary)
                        }
                        .padding(.horizontal, 20.0)
                        
                        HStack(alignment: .center) {
                            VStack(alignment: .leading) {
                                Text("Delivery Address")
                                    .font(.system(size: 16.0))
                                    .foregroundStyle(Color.gray)
                                
                                Text("Huntington Ave, Boston, MA")
                                    .font(.system(size: 16.0, weight: .medium))
                                    .foregroundStyle(Constant.text)
                            }
                            
                            Spacer()
                            
                            Image(systemName: "chevron.right")
                        }
                        .padding()
                        .background(Constant.white)
                        .cornerRadius(15.0)
                        .padding(.horizontal, 16.0)
                    }
                    .padding(.top, 15.0)
                }
                
            }
            
            // MARK: Checkout Button
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
                
                Text("Checkout")
                    .font(.system(size: 18.0, weight: Font.Weight.medium))
                    .foregroundColor(Constant.white)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 15.0)
                    .background(Constant.primary)
                    .cornerRadius(15.0)
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
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Constant.background)
    }
}

#Preview {
    Checkout(order: .constant(Array(dishes)), checkoutViewShown: .constant(false))
        .background(Constant.background)
}
