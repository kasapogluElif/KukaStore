//
//  DiscountItem.swift
//  KUKA_Product_App
//
//  Created by Elif Kasapoglu on 9.08.2022.
//

import Foundation

class DiscountItem{
    let id: Int
    let title: String
    let price: Price
    let image: String
    let rating: Rating

    var currentLevel: Int
    
    init(id: Int, title: String, price: Price, image: String, rating: Rating){
        self.id = id
        self.title = title
        self.price = price
        self.image = image
        self.rating = rating
        self.currentLevel = 1
    }
    
    func changeLevel(increase: Bool){
        if increase{
            currentLevel += 1
        }else{
            currentLevel -= 1
        }
    }
    
    func getDiscountedPrice(level: Int) -> Double?{
        return price.discountLevels.first(where: {$0.level == level})?.discountedPrice
    }
}
