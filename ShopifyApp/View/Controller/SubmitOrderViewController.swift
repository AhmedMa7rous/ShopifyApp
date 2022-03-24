//
//  SubmitOrderViewController.swift
//  ShopifyApp
//
//  Created by Ahmed Mostafa on 20/03/2022.
//  Copyright © 2022 Ma7rous. All rights reserved.
//

import UIKit

class SubmitOrderViewController: UIViewController {

    /*============================================*/
        //MARK: Outlet Connections

    @IBOutlet weak var subTotalLabel: UILabel!
    @IBOutlet weak var shippingFessLabel: UILabel!
    @IBOutlet weak var discountLabel: UILabel!
    @IBOutlet weak var garndTotalLabel: UILabel!
    @IBOutlet weak var validateButton: UIButton!
    @IBOutlet weak var couponTF: UITextField!
    var total:String?
    var subTotal :Double = 0
    var promoCode :Double = 0
    var shippingFees :Double = 0
    var grandTotal :Double = 0
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var productsInCart = [CartedProducts]()
    /*============================================*/
    //MARK: Outlet Actions
    
 
    @IBAction func validateCouponMethod(_ sender: Any) {
//        check for COUPON
        if couponTF.text == "iti2022" || couponTF.text == "jets2022"
        {
            let alert = UIAlertController(title: "You Enterd Valid Coupon Enjoy Your Discount", message: "you got discount 50.00", preferredStyle: .alert)
            let action = UIAlertAction(title: "Done", style: .cancel, handler: nil)
            alert.addAction(action)
            present(alert, animated: true, completion: nil)
            discountLabel.text = "50.00"
            self.calculateTotal()
            
        }else
        {
            let alert = UIAlertController(title: "Please Check Your Promo Code And Try Agian", message: "It's invalid promo code", preferredStyle: .alert)
            let action = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            alert.addAction(action)
            present(alert, animated: true, completion: nil)
            discountLabel.text = "00.00"
            self.calculateTotal()
        }
    }
    
    
    @IBAction func placeOrderMethod(_ sender: Any) {
        
        let alert = UIAlertController(title: "Are You Sure To Submit ?", message: "All products will be ordered toghether ", preferredStyle: .alert)
        let action = UIAlertAction(title: "Yes", style: .default, handler: { [self] _ in
      
            let ordered = OrderedProduct(context: context)
        if let result = try? context.fetch(CartedProducts.fetchRequest())
        {
            var num :Int64 = 0
            var infoAboutOrder:String = " "
            for i in 0..<result.count {
                num = 0
               num = num +  result[i].numberOfProducts
                infoAboutOrder += " \(num)-" + result[i].productName! + "--"
            }
            
                ordered.orderInfo = infoAboutOrder
                ordered.orderPrice = "\(grandTotal)"
                ordered.numberOfProducts = num
                ordered.orderStatus = "ordered"
                ordered.orderedDate = "24/3/2022 05:30PM"
                ordered.shippedDate = "29/3/2022 08:00AM"
                
                do {
                    try self.context.save()
                }catch {
                    print(error.localizedDescription)
                }
        }
            if let result = try? context.fetch(CartedProducts.fetchRequest())
            {
                for i in 0..<result.count
                {
                context.delete(result[i])
                    do {
                        try self.context.save()
                    }catch {
                        print(error.localizedDescription)
                    }
                }
            }
            self.navigationController?.popToRootViewController(animated: true)
        })
        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive, handler:nil)
        alert.addAction(cancelAction)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        }
      
    
    @IBAction func cuoponTFHasChanged(_ sender: Any) {
        validateButton.isEnabled = true
        if couponTF.text?.count == 0
        {
            validateButton.isEnabled = false
            
        }
    }
    
    /*============================================*/
        
    override func viewDidLoad() {
        super.viewDidLoad()
        self.updateUi()
        validateButton.isEnabled = false
        self.calculateTotal()
        
    }

    func updateUi()
    {
        subTotalLabel.text  = total
        shippingFessLabel.text = "10.00"
        discountLabel.text = "00.00"
        garndTotalLabel.text = "100.00"
    }
    func calculateTotal()
    {
        subTotal = Double(subTotalLabel.text!)!
        shippingFees = subTotal * 0.10
        
        promoCode = Double(discountLabel.text!)!
        grandTotal = subTotal + shippingFees - promoCode
        
        subTotalLabel.text = "\(subTotal)"
        shippingFessLabel.text = "\(shippingFees)"
        discountLabel.text = "\(promoCode)"
        garndTotalLabel.text = "\(grandTotal)"
        
    }
  

}
