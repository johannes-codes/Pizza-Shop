//
//  Topping.swift
//  Pizza Shop
//
//  Created by Meißner, Johannes, HSE DE on 08.10.23.
//

import Foundation

struct Topping: Identifiable {
    let id = UUID().uuidString
    var name: String
    var image: String
    var price: Double
}

var toppings = [
    Topping(
        name: "Cheese",
        image: "cheese",
        price: 1.0
    ),
    Topping(
        name: "Mushrooms",
        image: "mushroom",
        price: 1.0
    ),
    Topping(
        name: "Onion",
        image: "onion",
        price: 1.0
    ),
    Topping(
        name: "Paprika",
        image: "paprika",
        price: 1.0
    ),
    Topping(
        name: "Tomato",
        image: "tomato",
        price: 1.0
    )
]
