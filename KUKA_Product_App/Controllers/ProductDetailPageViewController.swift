//
//  ProductDetailPageViewController.swift
//  KUKA_Product_App
//
//  Created by Elif Kasapoglu on 8.08.2022.
//

import UIKit

protocol AddProductButtonDelegate{
    func didAddButtonTapped()
}

class ProductDetailPageViewController: UIViewController {
    
    @IBOutlet weak var discountCollectionView: UICollectionView!
    var product: Product?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = product?.title.capitalized
        discountCollectionView.delegate = self
        discountCollectionView.dataSource = self
    }
}

extension ProductDetailPageViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return productManager.getDiscountItemCount()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "discountCell", for: indexPath) as? DiscountItemCollectionViewCell, let discountItem = productManager.getDiscountItem(index: indexPath.row){
            cell.delegate = self
            cell.setData(item: discountItem)
            return cell
        }
        else{ return UICollectionViewCell() }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            if let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "detailHeader", for: indexPath) as? ProductDetailCollectionReusableView, let product = product{
                headerView.delegate = self
                headerView.setData(product: product)
                return headerView
                
            }
            return UICollectionReusableView()
        default:
            assert(false, "Unexpected element kind")
        }
    }
}

extension ProductDetailPageViewController: UICollectionViewDelegateFlowLayout{
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
        return CGSize(width:itemWidth, height:320)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        
        let indexPath = IndexPath(row: 0, section: section)
        let headerView = self.collectionView(collectionView, viewForSupplementaryElementOfKind: UICollectionView.elementKindSectionHeader, at: indexPath)
        
        return headerView.systemLayoutSizeFitting(CGSize(width: collectionView.frame.width, height: UIView.layoutFittingExpandedSize.height),withHorizontalFittingPriority: .required, verticalFittingPriority: .fittingSizeLevel)
    }
}

extension ProductDetailPageViewController: AddProductButtonDelegate{
    func didAddButtonTapped() {
        discountCollectionView.reloadData()
    }
}
