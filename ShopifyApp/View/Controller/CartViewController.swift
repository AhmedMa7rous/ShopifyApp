//
//  CartViewController.swift
//  ShopifyApp
//
//  Created by Ahmed Mostafa on 13/03/2022.
//  Copyright © 2022 Ma7rous. All rights reserved.
//

import UIKit

class CartViewController: UIViewController {
    
    lazy var viewModel: CartViewControllerModel = {
              return CartViewControllerModel()
          }()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var productsInCart = [CartedProducts]()
    var lastTotal :Double = 0
    @IBOutlet var ordersTableView: UITableView!
    @IBOutlet var totalPrice: UILabel!
    @IBOutlet weak var submitButton: UIButton!
    
    
    @IBAction func goToPaymentOptions(_ sender: Any) {
        
        self.showAlertForSumbit()
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToPaymentOptions"
        {
            let obj = segue.destination as! PaymentOptionsViewController
            obj.totalPrice = self.totalPrice.text
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib(nibName: "OrderTableViewCell", bundle: nil)
        self.ordersTableView.register(nib, forCellReuseIdentifier: "orderCell")
        self.fetchFromCoreData()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        initVM()
        self.getTotalPriceFromCoreData()
        self.fetchFromCoreData()
        if productsInCart.count == 0
        {
            submitButton.isEnabled = false
        }else
        {
            submitButton.isEnabled = true
        }
        
    }
    
    func fetchFromCoreData()
    {
        if let result = try? context.fetch(CartedProducts.fetchRequest())
        {
            productsInCart = result.reversed()
        }
        if productsInCart.count == 0
        {
            submitButton.isEnabled = false
        }else
        {
            submitButton.isEnabled = true
        }
    }
    
    func initVM() {
        viewModel.reloadTableViewClosure = { [weak self] () in
                   DispatchQueue.main.async {
                       self?.ordersTableView.reloadData()
                   }
               }
        viewModel.setLabalClosure = {  [weak self] () in
            DispatchQueue.main.async { [self] in
                self?.totalPrice.text=String(self!.lastTotal)
            }
        }
               
               viewModel.fetchProductAPIWithIB()
    }
    func showAlertForSumbit()
    {
        let alert = UIAlertController(title: "Do You Want To Submit You Orders ?", message: "All products in your cart will be ordered toghether", preferredStyle: .alert)
        let action = UIAlertAction(title: "cancel", style: .cancel, handler: nil)
        let segueAction = UIAlertAction(title: "Sumbit", style: .default, handler: {_ in
            self.performSegue(withIdentifier: "goToPaymentOptions", sender: Any?.self)
        })
        alert.addAction(action)
        alert.addAction(segueAction)
        present(alert, animated: true, completion: nil)
    }
}
extension CartViewController:UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
//        return viewModel.numberOfCells
        return productsInCart.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = ordersTableView.dequeueReusableCell(withIdentifier: "orderCell", for: indexPath) as! OrderTableViewCell
//        let cellVM = viewModel.getCellViewModel( at: indexPath )
//        cell.orderTableViewCellModel = cellVM
        cell.indexpath=indexPath
        cell.delegate=self
        cell.productName.text = productsInCart[indexPath.row].productName
                cell.productImage.sd_setImage(with: URL(string: productsInCart[indexPath.row].productImage ?? ""), placeholderImage: UIImage(named: "placeholder.png"))
        let x = String(productsInCart[indexPath.row].numberOfProducts)
        cell.numberOfProuduct.text =  x
        let price = Double(productsInCart[indexPath.row].productPrice ?? "1")
        let doubleNumberOfProducts = Double(productsInCart[indexPath.row].numberOfProducts)
        let totalPricePerProduct = price! * doubleNumberOfProducts
        cell.totalPrice.text = " \(totalPricePerProduct) £"
        return cell
    }
}
extension CartViewController:OrderTableViewCellDelegate{
    
    func tapPlusButton(indexpath: IndexPath) {
        
//        viewModel.increasOrder(at: indexpath)
        let cell = ordersTableView.dequeueReusableCell(withIdentifier: "orderCell", for: indexpath) as! OrderTableViewCell
        var x = productsInCart[indexpath.row].numberOfProducts
        x = x+1
        cell.numberOfProuduct.text = "\(String(describing: x))"
        self.changeNumber(indexPath: indexpath, addOrSub: 1)
        print("plus")
        DispatchQueue.main.async {
            self.ordersTableView.reloadData()
            self.fetchFromCoreData()
        }
    }
    func tapMinsButton(indexpath: IndexPath) {
//        viewModel.deacreaseOrder(at: indexpath)
       
        let cell = ordersTableView.dequeueReusableCell(withIdentifier: "orderCell", for: indexpath) as! OrderTableViewCell
        var x = productsInCart[indexpath.row].numberOfProducts
        if x == 1
        {
            let alert = UIAlertController(title: "Are You Sure To Delete This Product From Cart", message: "product in cart must be at least one item", preferredStyle: .alert)
            let action = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            let deleteAction = UIAlertAction(title: "Delete", style: .destructive, handler: { _ in
                
                self.deleteFromCoreData(indexPath: indexpath)
               
                DispatchQueue.main.async {
    
                    self.ordersTableView.reloadData()
//                    self.ordersTableView.deleteRows(at: [indexpath], with: .right)
                }
        
            })
            alert.addAction(action)
            alert.addAction(deleteAction)
            present(alert, animated: true, completion: nil)
            
        
        }else
        {
        x = x-1
        cell.numberOfProuduct.text = "\(String(describing: x))"
        self.changeNumber(indexPath: indexpath, addOrSub: -1)
        }
        print("sub")
        DispatchQueue.main.async {
            self.ordersTableView.reloadData()
            self.fetchFromCoreData()
        }
    }
    func changeNumber(indexPath : IndexPath, addOrSub : Int){
       let carted = CartedProducts(context: context)
        if let result = try? context.fetch(CartedProducts.fetchRequest())
        {
            for i in 0..<result.count
            {
                if result[i].productID == productsInCart[indexPath.row].productID
                {
                    carted.productName = productsInCart[indexPath.row].productName
                    carted.productInfo = productsInCart[indexPath.row].productInfo
                    carted.productImage = productsInCart[indexPath.row].productImage
                    carted.productStatus = "cart"
                    carted.productPrice = productsInCart[indexPath.row].productPrice
                    carted.productID = productsInCart[indexPath.row].productID
                    carted.numberOfProducts = result[i].numberOfProducts + Int64(addOrSub)
                    context.delete(result[i])
                    do {
                        try context.save()
                        DispatchQueue.main.async {
                            
                            self.ordersTableView.reloadData()
                            self.fetchFromCoreData()
                            self.getTotalPriceFromCoreData()
                        }
                    } catch {
                        print(error.localizedDescription)
                    }
                }
            }
        }
    }
    func deleteFromCoreData(indexPath : IndexPath)
    {
        if let result = try? context.fetch(CartedProducts.fetchRequest())
        {
            for i in 0..<result.count
            {
                if result[i].productID == productsInCart[indexPath.row].productID
                {
                    context.delete(result[i])
                    do {
                        try context.save()
                        DispatchQueue.main.async {
                            self.fetchFromCoreData()
                            self.ordersTableView.reloadData()
                            self.getTotalPriceFromCoreData()
                        }
                    } catch {
                        print(error.localizedDescription)
                    }
                }
            }
        }
    }
    func getTotalPriceFromCoreData()
    {
       
        if let result = try? context.fetch(CartedProducts.fetchRequest())
        {
            lastTotal = 0
            for i in 0..<result.count
            {
                let price = Double(result[i].productPrice ?? "1")
                let doubleNumberOfProducts = Double(result[i].numberOfProducts)
                let totalPricePerProduct = price! * doubleNumberOfProducts
                lastTotal = lastTotal +  totalPricePerProduct
            }
        }
        self.totalPrice.text=String(self.lastTotal)
    }
}
