//
//  DiscountItemResponseModel.swift
//  KUKA_Product_App
//
//  Created by Elif Kasapoglu on 9.08.2022.
//

import Foundation

struct DiscountItemResponseModel : Codable {
    let id: Int
    let title: String
    let price: Price
}

struct Price : Codable {
    let originalPrice: Double
    let discountLevels: [DiscountLevel]
}

struct DiscountLevel : Codable {
    let level: Int
    let discountedPrice: Double
}
