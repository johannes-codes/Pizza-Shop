//
//  ContentView.swift
//  Pizza Shop
//
//  Created by Meißner, Johannes, HSE DE on 04.10.23.
//

import SwiftUI

struct ContentView: View {
    @State private var selectedDish: Dish?
    @State private var detailViewShown: Bool = false
    @State private var checkoutViewShown: Bool = false
    @State private var hideView: (Bool, Bool) = (false, false)
    @State private var order: [Dish] = []

    var body: some View {
        NavigationStack {
            Overview(
                selectedDish: $selectedDish,
                detailViewShown: $detailViewShown,
                checkoutViewShown: $checkoutViewShown,
                order: $order
            )
            .navigationDestination(isPresented: $detailViewShown) {
                Detail(
                    dish: $selectedDish,
                    order: $order,
                    pushView: $detailViewShown,
                    hideView: $hideView
                )
            }
            .navigationDestination(isPresented: $checkoutViewShown) {
                Checkout(order: $order, checkoutViewShown: $checkoutViewShown)
                    .toolbar(.hidden, for: .navigationBar)
            }
        }
        .overlayPreferenceValue(MAnchorKey.self, { value in
            GeometryReader(content: { geometry in
                if let selectedDish, let anchor = value[selectedDish.id], !hideView.0 {
                    let rect = geometry[anchor]
                    ImageView(dish: selectedDish, size: rect.size)
                        .offset(x: rect.minX, y: rect.minY)
                        .animation(.snappy(duration: 0.35, extraBounce: 0), value: rect)
                }
            })
        })
    }
}

#Preview {
    ContentView()
}
