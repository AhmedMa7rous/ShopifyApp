//
//  AllOrdersTableViewController.swift
//  ShopifyApp
//
//  Created by Ahmed Mostafa on 20/03/2022.
//  Copyright © 2022 Ma7rous. All rights reserved.
//

import UIKit

class AllOrdersTableViewController: UITableViewController {

    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var allCartedProducts = [OrderedProduct]()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.fetchFromCoredata()

    }

    // MARK: - Table view data source

  
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return allCartedProducts.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "allOrdersCell", for: indexPath) as! AllOrdersTableViewCell
        cell.infoLabel.text = " Products : " + allCartedProducts[indexPath.row].orderInfo!
        cell.priceLabel.text = " Price : " + allCartedProducts[indexPath.row].orderPrice!
        cell.orderDateLabel.text = " Ordered Date : " + allCartedProducts[indexPath.row].orderedDate!
        cell.shippingDateLabel.text = " Shipping Date : " + allCartedProducts[indexPath.row].shippedDate!
        return cell
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
    func fetchFromCoredata()
    {
        if let result = try? context.fetch(OrderedProduct.fetchRequest())
        {
                allCartedProducts = result
            }
            DispatchQueue.main.async { [self] in
                tableView.reloadData()
            }
    }
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
      if editingStyle == .delete {
        print("Deleted")

          
          if let result = try? context.fetch(OrderedProduct.fetchRequest())
          {
              if result.count < 2
              {
                  if allCartedProducts[indexPath.row].orderInfo == result[0].orderInfo
                  {
                      context.delete(result[0])
                          do {
                              try self.context.save()
                          }catch {
                              print(error.localizedDescription)
                          }
                      
                  }
                  
              }else
              {
                for i in 0..<result.count
              {
                    if allCartedProducts[indexPath.row].orderInfo == result[i].orderInfo
                    {
                        context.delete(result[i])
                            do {
                                try self.context.save()
                            }catch {
                                print(error.localizedDescription)
                            }
                        
                    }
                    
                }
          }
      }
    }
        allCartedProducts.remove(at: indexPath.row)
      self.tableView.deleteRows(at: [indexPath], with: .automatic)
    }
    
}
