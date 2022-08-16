//
//  ProductManager.swift
//  KUKA_Product_App
//
//  Created by Elif Kasapoglu on 10.08.2022.
//

import Foundation

let productManager = ProductManager()

class ProductManager{
    fileprivate var cart = [Int]()
    fileprivate var discountItems = [DiscountItem]()
    
    func addProductToCart(id: Int?) -> Bool{
        if let productId = id{
            cart.append(productId)
            if isDiscountItem(id: id){
                setDiscountItemLevels(increase: true, id: id)
            }
            return true
        }
        return false
    }
    
    func removeProductFromCart(id: Int?) -> Bool{
        if let productId = id, let i = cart.firstIndex(where: {$0 == productId}){
            cart.remove(at: i)
            if isDiscountItem(id: id){
                setDiscountItemLevels(increase: false, id: id)
            }
            return true
        }
        return false
    }
    
    func isProductOnCart(id: Int?) -> Bool{
        if let productId = id{
            return cart.contains(where: {$0 == productId})
        }
        return false
    }

    func getDiscountItemCount() -> Int{
        return discountItems.count
    }
    
    func setDiscountItems(items: [DiscountItem]){
        self.discountItems = items
    }
    
    func isDiscountItemsEmpty() -> Bool{
        return discountItems.count == 0
    }
    
    func getDiscountItem(index: Int) -> DiscountItem?{
        if index < discountItems.count{
            return discountItems[index]
        }
        return nil
    }
    
    func getDiscountItem(id: Int?) -> DiscountItem?{
        if let productId = id, let i = discountItems.firstIndex(where: {$0.id == productId}){
            return discountItems[i]
        }
        return nil
    }

    func getDiscountedPrice(id: Int?) -> Double?{
        if let productId = id, let item = getDiscountItem(id: productId){
            return item.getDiscountedPrice(level: item.currentLevel)
        }
        return nil
    }
    
    func isDiscountItem(id: Int?) -> Bool{
        if let productId = id{
            return discountItems.contains(where: {$0.id == productId})
        }
        return false
    }
    
    func setDiscountItemLevels(increase: Bool, id: Int?){
        for item in discountItems {
            if item.id != id{
                item.changeLevel(increase: increase)
            }
        }
    }
}
