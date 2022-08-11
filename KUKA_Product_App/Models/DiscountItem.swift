//
//  DiscountItem.swift
//  KUKA_Product_App
//
//  Created by Elif Kasapoglu on 9.08.2022.
//

import Foundation

struct DiscountItem{
    let id: Int
    let title: String
    let price: Price
    let image: String
    let rating: Rating

    func getDiscountedPrice(level: Int) -> Double?{
        return price.discountLevels.first(where: {$0.level == level})?.discountedPrice
    }
}
