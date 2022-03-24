//
//  ProfileViewController.swift
//  ShopifyApp
//
//  Created by Ahmed Mostafa on 13/03/2022.
//  Copyright © 2022 Ma7rous. All rights reserved.
//

import UIKit
import Firebase
class ProfileViewController: UIViewController {

    /*============================================*/
    
    //MARK: Outlet Actions
    
  
    @IBAction func goToSettings(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "showSettings", sender: Any?.self)
    }
    
    @IBAction func goToCartMethod(_ sender: Any) {
        performSegue(withIdentifier: "goToCartFromProfileSegue", sender: Any?.self)
    }
    @IBAction func moreForOrdersTableView(_ sender: Any) {
        performSegue(withIdentifier: "showAllordersSegue", sender: Any?.self)
    }
    
    @IBAction func moreForWishlistTableView(_ sender: Any) {
        performSegue(withIdentifier: "showFavFromProfile", sender: Any?.self)
    }
    
    /*============================================*/
    
    //MARK: Outlet Connection
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var orderTableView: UITableView!
    @IBOutlet weak var wishlistTableView: UITableView!
    @IBOutlet weak var cartButton: UIBarButtonItem!
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var allFavProducts = [Favourite]()
    var allCartedProducts = [OrderedProduct]()
    /*============================================*/
    
    override func viewDidLoad() {
        super.viewDidLoad()
        orderTableView.layer.cornerRadius = 15
        wishlistTableView.layer.cornerRadius = 15
        orderTableView.layer.borderWidth = 1
        wishlistTableView.layer.borderWidth = 1
        orderTableView.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        wishlistTableView.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        self.fetchFromCoredata()
       // userName.te
        }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.fetchFromCoredata()
    }
    func fetchFromCoredata()
    {
        if let result = try? context.fetch(OrderedProduct.fetchRequest())
        {
            
            allCartedProducts = result
            DispatchQueue.main.async { [self] in
                orderTableView.reloadData()
            }
        }
            
        if let result = try? context.fetch(Favourite.fetchRequest())
        {
            allFavProducts = result
            DispatchQueue.main.async { [self] in
                wishlistTableView.reloadData()
            }
        }
    }


}

extension ProfileViewController :UITableViewDataSource , UITableViewDelegate
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == orderTableView
        {
            if allCartedProducts.count > 2
            {
                return 2
            }else
            {
            return allCartedProducts.count
            }
        
        }else if tableView == wishlistTableView
        {
            if allFavProducts.count > 2
            {
                return 2
            }else
            {
            return allFavProducts.count
            }
        }else
        {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == orderTableView
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ordersCell", for: indexPath)
            cell.textLabel?.text = allCartedProducts[indexPath.row].orderInfo
            return cell
        }else if tableView == wishlistTableView
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "wishlistCell", for: indexPath)
            cell.textLabel?.text = allFavProducts[indexPath.row].productInfo!
            return cell
        }else
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "wishlistCell", for: indexPath)
            return cell
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    
    
}
