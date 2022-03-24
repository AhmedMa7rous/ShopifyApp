//
//  PaymentOptionsViewController.swift
//  ShopifyApp
//
//  Created by Ahmed Mostafa on 20/03/2022.
//  Copyright © 2022 Ma7rous. All rights reserved.
//

import UIKit

class PaymentOptionsViewController: UIViewController {
    /*============================================*/
        //MARK: Outlet Connections
    @IBOutlet weak var paymentTableView: UITableView!
    
    @IBOutlet weak var CotninueToPaymentButton: UIButton!
    
    var totalPrice:String?
    /*============================================*/
        //MARK: Outlet Actions
    
    
    @IBAction func ContinueToPaymentMethod(_ sender: Any) {
        performSegue(withIdentifier: "submitOrderSegue", sender: totalPrice!)
        
    }
    /*============================================*/
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        CotninueToPaymentButton.isEnabled = false
        
    }
    
    

}
extension PaymentOptionsViewController : UITableViewDelegate, UITableViewDataSource
{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "paymentCell", for: indexPath)
        
        switch(indexPath.section)
        {
        case 0:
            
            cell.textLabel?.text = "Apple Pay"
            return cell
        case 1 :
            cell.textLabel?.text = "Cash On Dilvery"
            return cell
        default :
            cell.textLabel?.text = "Apple Pay"
            return cell
            
        }
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch(section)
        {
    case 0 :
        return "Online Payment"
    case 1 :
        return "More Payment Options"
    default :
        return ""
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell  = tableView.cellForRow(at: IndexPath.init(row: indexPath.row, section: indexPath.section))
        CotninueToPaymentButton.isEnabled = true
        switch (indexPath.section)
        {
    case 0 :
        
        if  cell?.accessoryType == .checkmark
        {
        cell?.accessoryType = .none
            tableView.cellForRow(at: IndexPath.init(row: indexPath.row, section: indexPath.section+1))?.accessoryType = .checkmark
            
        }else
        {
            cell?.accessoryType = .checkmark
            tableView.cellForRow(at: IndexPath.init(row: indexPath.row, section: indexPath.section+1))?.accessoryType = .none
        }
    case 1 :
            if  cell?.accessoryType == .checkmark
            {
            cell?.accessoryType = .none
                tableView.cellForRow(at: IndexPath.init(row: indexPath.row, section: indexPath.section-1))?.accessoryType = .checkmark
            
            }else
            {
                cell?.accessoryType = .checkmark
                tableView.cellForRow(at: IndexPath.init(row: indexPath.row, section: indexPath.section-1))?.accessoryType = .none
                
            }
        default :
            break
            
        }
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "submitOrderSegue"
        {
            let obj = segue.destination as! SubmitOrderViewController
            obj.total = self.totalPrice
        }
    }
    
}
