//
//  Dish.swift
//  Pizza Shop
//
//  Created by Meißner, Johannes, HSE DE on 06.10.23.
//

import Foundation

struct Dish: Identifiable {
    let id = UUID().uuidString
    var image: String
    var title: String
    var weight: Int
    var price: Double
    var total: Double {
        price + extras.map { $0.price }.reduce(0, +)
    }
    var nutritious = ["240 kc", "10.3 pr", "8,8 fats", "28.7 cb"]
    var extras: [Topping] = []
}

var dishes = [
    Dish(
        image: "pizza-peperoni",
        title: "Peperoni Pizza",
        weight: 320,
        price: 15.99
    ),
    Dish(
        image: "pizza-huhn",
        title: "Chicken Pizza",
        weight: 380,
        price: 16.99
    ),
    Dish(
        image: "pizza-schinken-kaese",
        title: "Ham+Cheese Pizza",
        weight: 340,
        price: 14.99
    ),
    Dish(
        image: "pizza-tomaten-oliven-peperoni",
        title: "Veggie Pizza",
        weight: 370,
        price: 17.99
    ),
    Dish(
        image: "pizza-tomaten",
        title: "Tomato Pizza",
        weight: 355,
        price: 14.99
    )
]
