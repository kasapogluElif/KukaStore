//
//  WebService.swift
//  KUKA_Product_App
//
//  Created by Elif Kasapoglu on 8.08.2022.
//

import Foundation
import Alamofire

struct WebService{
    
    var delegate: WebServiceDelegate?
    
    func fetchCategories(){
        AF.request(PostUrls.getCategories).responseDecodable(of: [String].self) { response in
            switch response.result {
            case .success:
                if let categories = response.value{
                    delegate?.didFetchCategories(categories: categories)
                }
            case .failure(let error):
                delegate?.didFailWithError(error: error)
            }
        }
    }
    
    func fetchProducts(categoryName: String){
        let url = (PostUrls.getProductListBase + categoryName.lowercased()).replacingOccurrences(of: " ", with: "%20")
        AF.request(url).responseDecodable(of: [Product].self) { response in
            switch response.result {
            case .success:
                if let products = response.value{
                    delegate?.didFetchProducts(products: products)
                }
            case .failure(let error):
                delegate?.didFailWithError(error: error)
            }
        }
    }
    
    func fetchAddAndDiscountItems(){
        AF.request(PostUrls.getAddAndDiscountItems).responseDecodable(of: [DiscountItemResponseModel].self) { response in
            switch response.result {
            case .success:
                if let discountItems = response.value{
                    fetchDiscountItemsInfo(discountItems: discountItems)
                }
            case .failure(let error):
                delegate?.didFailWithError(error: error)
            }
        }
    }
    
    func fetchDiscountItemsInfo(discountItems: [DiscountItemResponseModel]){
        var items = [DiscountItem]()
        AF.request(PostUrls.getProducts).responseDecodable(of: [Product].self) { response in
            switch response.result {
            case .success:
                if let products = response.value{
                    for discountitem in discountItems {
                        if let product = products.first(where: {$0.id == discountitem.id}){
                            let item = DiscountItem(id: product.id, title: product.title, price: discountitem.price, image: product.image, rating: product.rating)
                            items.append(item)
                            
                        }
                    }
                    delegate?.didFetchDiscountItems(items: items)
                }
            case .failure(let error):
                delegate?.didFailWithError(error: error)
            }
        }
    }
}
