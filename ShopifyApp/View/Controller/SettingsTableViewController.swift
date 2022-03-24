//
//  SettingsTableViewController.swift
//  ShopifyApp
//
//  Created by Ahmed Mostafa on 13/03/2022.
//  Copyright © 2022 Ma7rous. All rights reserved.
//

import UIKit
import SafariServices
import Firebase

struct CellModel{
    let title:String
    let handeler: ()->Void
    
}

enum settingTypeUrl {
    case privacy
    case terms
    case help
}

class SettingsTableViewController: UITableViewController {
    @IBOutlet weak var addressLabel: UILabel!
    let userDefaults = UserDefaults.standard

    private var cellData = [[CellModel]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureCellModel()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        addressLabel.text = userDefaults.string(forKey: "myAddrees")
    }
    
    func configureCellModel(){
        // section 1
        cellData.append([
        CellModel(title: "Edit Address", handeler: { [weak self] in
            self?.editAddressPressed()
        }),
     
        CellModel(title: "Favorite Products", handeler: { [weak self] in
            self?.goToFavoriteProductPressed()
        })
        ])
        // section 2
        cellData.append([
            CellModel(title: "Terms of Services", handeler: { [weak self] in
                self?.openUrl(type: .terms)
            }),
            CellModel(title: "Privacy Policy", handeler: { [weak self] in
                self?.openUrl(type: .privacy)
            }),
            CellModel(title: "Help/Feedback", handeler: { [weak self] in
                self?.openUrl(type: .help)
            })
        ])
        // Section 3
        cellData.append([
            CellModel(title: "Log out", handeler: { [weak self] in
                self?.logOutPressed()
            })
        ])
    }
    
    func editAddressPressed(){
        var field : UITextField = UITextField()
        let alert = UIAlertController(title: "Edit address", message: "", preferredStyle: .alert)
        alert.addTextField { textField in
            textField.placeholder = "edit address"
            field = textField

        }
        alert.addAction(UIAlertAction(title: "Edit", style: .default, handler: { _ in
            self.addressLabel.text = field.text
            self.userDefaults.set( field.text, forKey: "myAddrees")
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .destructive, handler: nil))
        present(alert, animated: true)
    }
    
    func openUrl(type:settingTypeUrl){

        let urlString : String

        switch type {
        case .help:
            urlString = "https://help.shopify.com/en/manual/products/product-reviews"
        case .privacy:
            urlString = "https://www.shopify.com/legal/privacy"
        case .terms:
            urlString = "https://www.shopify.com/legal/terms#Cancellation"
        }

        guard let url = URL(string: urlString) else{
            return
        }
        let vc = SFSafariViewController(url: url)
        present(vc, animated: true, completion: nil)
        
    }
    
    func logOutPressed(){
        let actionSheet = UIAlertController(title: "Log out", message: "Are you sure you want Log out", preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Log out", style: .destructive, handler: { _ in
            
            do{
               try Auth.auth().signOut()
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "SplashViewController") as! SplashViewController
                vc.modalPresentationStyle = .overCurrentContext
                self.present(vc, animated: true, completion: nil)
                self.tabBarController?.tabBar.isHidden = true
            }catch{
                print(error)
            }
            
            
        }))
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        present(actionSheet, animated: true, completion: nil)
    }
    
    func goToFavoriteProductPressed(){
        performSegue(withIdentifier: "goToFavoriteFromSettings", sender: self)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return cellData.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return cellData[section].count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "settingsCell", for: indexPath)

        // Configure the cell...
        cell.textLabel?.text = cellData[indexPath.section][indexPath.row].title

        return cell
    }
  
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        cellData[indexPath.section][indexPath.row].handeler()
        tableView.deselectRow(at: indexPath, animated: true)
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
