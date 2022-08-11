//
//  ProductListCollectionViewCell.swift
//  KUKA_Product_App
//
//  Created by Elif Kasapoglu on 8.08.2022.
//

import UIKit
import AlamofireImage

class ProductListCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var star1Image: UIImageView!
    @IBOutlet weak var star2Image: UIImageView!
    @IBOutlet weak var star3Image: UIImageView!
    @IBOutlet weak var star4Image: UIImageView!
    @IBOutlet weak var star5Image: UIImageView!
    @IBOutlet weak var rateCountLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    func setData(product: Product){
        if let url = URL(string: product.image){
            productImage.af.setImage(withURL: url)
        }
        titleLabel.text = product.title
        setRateStars(rate: product.rating.rate)
        rateCountLabel.text = "(\(String(product.rating.count)))"
        priceLabel.text = "\(String(product.price)) €"
    }
    
    fileprivate func setRateStars(rate: Double){
        let starCount = Int(rate)
        star1Image.image = starCount >= 1 ? UIImage(named: "kuka_star_fill") : UIImage(named: "kuka_star_empty")
        star2Image.image = starCount >= 2 ? UIImage(named: "kuka_star_fill") : UIImage(named: "kuka_star_empty")
        star3Image.image = starCount >= 3 ? UIImage(named: "kuka_star_fill") : UIImage(named: "kuka_star_empty")
        star4Image.image = starCount >= 4 ? UIImage(named: "kuka_star_fill") : UIImage(named: "kuka_star_empty")
        star5Image.image = starCount >= 5 ? UIImage(named: "kuka_star_fill") : UIImage(named: "kuka_star_empty")
    }
}

