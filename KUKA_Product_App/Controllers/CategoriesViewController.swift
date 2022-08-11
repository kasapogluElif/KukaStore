//
//  CategoriesViewController.swift
//  KUKA_Product_App
//
//  Created by Elif Kasapoglu on 8.08.2022.
//

import UIKit
import Alamofire

class CategoriesViewController: UIViewController {
    
    @IBOutlet weak var categoriesTableView: UITableView!
    fileprivate var webService = WebService()
    fileprivate var categories: [String]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNavigationBar()
        
        categoriesTableView.delegate = self
        categoriesTableView.dataSource = self
        
        webService.delegate = self
        webService.fetchCategories()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    fileprivate func setNavigationBar(){
        //back button
        navigationController?.navigationBar.backIndicatorImage = UIImage(named: "kuka_back")?.withRenderingMode(.alwaysOriginal)
        navigationController?.navigationBar.backIndicatorTransitionMaskImage = UIImage(named: "kuka_back")?.withRenderingMode(.alwaysOriginal)
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "PLP", let plpVC = segue.destination as? ProductListPageViewController, let products = sender as? [Product]{
            plpVC.products = products
        }
    }
}

extension CategoriesViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        if let categoryName = cell?.textLabel?.text{
            webService.fetchProducts(categoryName: categoryName)
        }
        categoriesTableView.deselectRow(at: indexPath, animated: true)
    }
}

extension CategoriesViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "categoryCell", for: indexPath)
        cell.textLabel?.text = categories?[indexPath.row].capitalized
        cell.accessoryView = UIImageView(image: UIImage(named: "kuka_right"))
        return cell
    }
}

extension CategoriesViewController: WebServiceDelegate{
    func didFetchCategories(categories: [String]) {
        DispatchQueue.main.async {
            self.categories = categories
            self.categoriesTableView.reloadData()
        }
    }
    
    func didFetchProducts(products: [Product]) {
        performSegue(withIdentifier: "PLP", sender: products)
    }
}

