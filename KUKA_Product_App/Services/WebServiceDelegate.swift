//
//  WebServiceDelegate.swift
//  KUKA_Product_App
//
//  Created by Elif Kasapoglu on 8.08.2022.
//

import Foundation

protocol WebServiceDelegate {
    func didFetchCategories(categories: [String])
    func didFetchProducts(products: [Product])
    func didFetchDiscountItems(items: [DiscountItem])
    func didFailWithError(error: Error)
}

extension WebServiceDelegate{
    func didFetchCategories(categories: [String]){}
    
    func didFetchProducts(products: [Product]){}
    
    func didFetchDiscountItems(items: [DiscountItem]){}
    
    func didFailWithError(error: Error){
        print("Something went wrong: \(error)")
    }
}
