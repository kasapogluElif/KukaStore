//
//  ProductDetailCollectionReusableView.swift
//  KUKA_Product_App
//
//  Created by Elif Kasapoglu on 8.08.2022.
//

import UIKit

class ProductDetailCollectionReusableView: UICollectionReusableView {
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var star1Image: UIImageView!
    @IBOutlet weak var star2Image: UIImageView!
    @IBOutlet weak var star3Image: UIImageView!
    @IBOutlet weak var star4Image: UIImageView!
    @IBOutlet weak var star5Image: UIImageView!
    @IBOutlet weak var rateCountLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    @IBOutlet weak var discountedPriceLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var addButton: UIButton!
    
    var delegate: AddProductButtonDelegate?
    fileprivate var id: Int?
    fileprivate var isAdded  = false {
        didSet {
            if isAdded{
                addButton.backgroundColor = .gray
                addButton.setTitle("Added to cart", for: .normal)
            }else{
                addButton.backgroundColor = .black
                addButton.setTitle("Add to cart", for: .normal)
            }
        }
    }
    
    func setData(product: Product){
        id = product.id
        isAdded = productManager.isProductOnCart(id: id)
        setPriceLabels(item: product)
        if let url = URL(string: product.image){
            productImage.af.setImage(withURL: url)
        }
        
        titleLabel.text = product.title
        setRateStars(rate: product.rating.rate)
        rateCountLabel.text = "(\(String(product.rating.count)))"
       // priceLabel.text = "\(String(product.price)) €"
        descriptionLabel.text = product.description
    }
    
    fileprivate func setPriceLabels(item: Product){
        if let discountedPrice = productManager.getDiscountedPrice(id: id){
            discountedPriceLabel.isHidden = false
            discountedPriceLabel.text = "\(String(discountedPrice)) €"
            
            let attrPrice = NSMutableAttributedString(string: "\(String(item.price)) €")
            attrPrice.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 1, range: NSMakeRange(0, attrPrice.length))
            priceLabel.attributedText = attrPrice
        }else{
            discountedPriceLabel.isHidden = true
            priceLabel.attributedText = nil
            priceLabel.text = "\(String(item.price)) €"
        }
    }
    
    fileprivate func setRateStars(rate: Double){
        let starCount = Int(rate)
        star1Image.image = starCount >= 1 ? UIImage(named: "kuka_star_fill") : UIImage(named: "kuka_star_empty")
        star2Image.image = starCount >= 2 ? UIImage(named: "kuka_star_fill") : UIImage(named: "kuka_star_empty")
        star3Image.image = starCount >= 3 ? UIImage(named: "kuka_star_fill") : UIImage(named: "kuka_star_empty")
        star4Image.image = starCount >= 4 ? UIImage(named: "kuka_star_fill") : UIImage(named: "kuka_star_empty")
        star5Image.image = starCount >= 5 ? UIImage(named: "kuka_star_fill") : UIImage(named: "kuka_star_empty")
    }
    
    @IBAction func AddButtonTapped(_ sender: Any) {
        if isAdded, productManager.removeProductFromCart(id: id){
            isAdded = false
        }else if !isAdded, productManager.addProductToCart(id: id){
            isAdded = true
        }
        delegate?.didAddButtonTapped()
    }
}
