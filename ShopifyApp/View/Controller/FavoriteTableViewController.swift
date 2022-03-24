//
//  FavoriteTableViewController.swift
//  ShopifyApp
//
//  Created by Ahmed Mostafa on 13/03/2022.
//  Copyright © 2022 Ma7rous. All rights reserved.
//

import UIKit
import CoreData
import SDWebImage
class FavoriteTableViewController: UITableViewController {

    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var favProducts = [Favourite]()
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchFavoriteProducts()
    }
    
    
    func fetchFavoriteProducts(){
        do{
         favProducts = try context.fetch(Favourite.fetchRequest())
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }catch{
            print(error)
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return favProducts.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "favCell", for: indexPath) as! FavouriteTableViewCell

        // Configure the cell...
        cell.productNameLabel.text = favProducts[indexPath.row].productName
        cell.productInfoLabel.text = favProducts[indexPath.row].productInfo
        cell.productImage.sd_setImage(with: URL(string: favProducts[indexPath.row].productImage ?? ""), placeholderImage: UIImage(systemName: "photo"))
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }

   
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }


    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let alert = UIAlertController(title: "", message: "Are you Sure want to delete this item from favourite", preferredStyle: .alert)
        let doneAction = UIAlertAction(title: "Delete", style: .destructive) { alert in
            if editingStyle == .delete {
                self.context.delete(self.favProducts[indexPath.row])
                self.favProducts.remove(at: indexPath.row)
                self.save()
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
        }
        let caneleAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(caneleAction)
        alert.addAction(doneAction)
        
        present(alert, animated: true, completion: nil)
       
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        
    }
    
    func save(){
        do{
            try context.save()
        }catch {
            print(error.localizedDescription)
        }
    }
}
