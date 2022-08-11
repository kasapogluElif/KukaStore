//
//  ProductListPageViewController.swift
//  KUKA_Product_App
//
//  Created by Elif Kasapoglu on 8.08.2022.
//

import UIKit

class ProductListPageViewController: UIViewController {
    
    @IBOutlet weak var productListCollectionView: UICollectionView!
    
    fileprivate var webService = WebService()
    fileprivate var isSortedDesc = false
    fileprivate var selectedProduct: Product?
    var products: [Product]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNavigationBar()
        
        productListCollectionView.delegate = self
        productListCollectionView.dataSource = self
        webService.delegate = self
    }
    
    fileprivate func setNavigationBar(){
        //title
        navigationItem.title = products?.first?.category.capitalized
        
        //Sort Button
        navigationItem.rightBarButtonItem = UIBarButtonItem(image:UIImage(named: "kuka_sort")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(onSortTap))
        
        //Back Button
        navigationController?.navigationBar.backIndicatorImage = UIImage(named: "kuka_back")?.withRenderingMode(.alwaysOriginal)
        navigationController?.navigationBar.backIndicatorTransitionMaskImage = UIImage(named: "kuka_back")?.withRenderingMode(.alwaysOriginal)
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
    @objc func onSortTap() {
        if isSortedDesc{
            products = products?.sorted{$0.price < $1.price}
        }else{
            products = products?.sorted{$0.price > $1.price}
        }
        
        isSortedDesc = !isSortedDesc
        
        DispatchQueue.main.async {
            self.productListCollectionView.reloadData()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "PDP", let pdpVC = segue.destination as? ProductDetailPageViewController{
            pdpVC.product = selectedProduct
        }
    }
}

extension ProductListPageViewController: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedProduct = products?[indexPath.row]
        if productManager.isDiscountItemsEmpty(){
            webService.fetchAddAndDiscountItems()
        }else{
            self.performSegue(withIdentifier: "PDP", sender: self)
        }
    }
}

extension ProductListPageViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return products?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "listCell", for: indexPath) as? ProductListCollectionViewCell,
           let product = products?[indexPath.row]{
            cell.setData(product: product)
            return cell
        }
        else{ return UICollectionViewCell() }
    }
}

extension ProductListPageViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 20, bottom: 0, right: 20)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemWidth = (collectionView.bounds.width - 50)/2
        return CGSize(width:itemWidth, height:300)
    }
}

extension ProductListPageViewController: WebServiceDelegate{
    func didFetchDiscountItems(items: [DiscountItem]) {
        productManager.setDiscountItems(items: items)
        self.performSegue(withIdentifier: "PDP", sender: self)
    }
}
