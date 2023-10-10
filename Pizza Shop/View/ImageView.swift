//
//  ImageView.swift
//  Pizza Shop
//
//  Created by Meißner, Johannes, HSE DE on 06.10.23.
//

import SwiftUI

struct ImageView: View {
    var dish: Dish
    var size: CGSize

    private let screen = UIScreen.main.bounds.size

    var body: some View {
        Image(dish.image)
            .resizable()
            .renderingMode(.original)
            .scaledToFill()
            .frame(width: size.width, height: size.height, alignment: .bottomLeading)
            .clipped()
            .dropShadow()
    }
}
#Preview {
    ContentView()
}
