//
//  ProductDetailsViewController.swift
//  ShopifyApp
//
//  Created by Ahmed Mostafa on 15/03/2022.
//  Copyright © 2022 Ma7rous. All rights reserved.
//

import UIKit
import SDWebImage
import CoreData

class ProductDetailsViewController: UIViewController
{
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    /*============================================*/
        //MARK: Outlet Connections

    @IBOutlet weak var productPageControl: UIPageControl!
    
    @IBOutlet weak var imagesCollectionView: UICollectionView!
    @IBOutlet weak var productInfo: UILabel!
    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet weak var productRating: UILabel!
    @IBOutlet weak var productDesc: UITextView!
    @IBOutlet weak var productColor: UILabel!
    @IBOutlet weak var favouritButton: UIBarButtonItem!
    @IBOutlet weak var cartButton: UIBarButtonItem!
    
    @IBAction func favouritButtonPressed(_ sender: UIBarButtonItem) {
        if isFavourit {
          saveProducts()
            showAlert(alertMessage: "Item Added to Favourite ")
            favouritButton.image = UIImage(systemName: "heart.fill")
            favouritButton.tintColor = .systemRed
            isFavourit = false
        }else{
            deleteProduct()
            showAlert(alertMessage: "Item Removed From Favourite ")
            favouritButton.image = UIImage(systemName: "heart.circle.fill")
            favouritButton.tintColor = .white
            isFavourit = true
        }
        
    }
    @IBAction func cartButtonPressed(_ sender: Any) {
        if isCarted {
          saveProductsToCart()
            showAlertForCart(alertMessage: "Item Added to Cart ")
            cartButton.image = UIImage(systemName: "cart.fill.badge.plus")
            cartButton.tintColor = .systemPink
            isCarted = false
        }else
        {
        deleteProductsToCart()
            showAlertForCart(alertMessage: "Item Removed From Cart ")
            cartButton.image = UIImage(systemName: "cart")
            cartButton.tintColor = .white
            isCarted = true
        }
   
    }
    
    var isCarted:Bool = true
    var isFavourit:Bool = true
    var productName:String?
    var product4Segue : Products?
   
    /*============================================*/

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        fetchfromcoredata()
        self.fetchFavoritFromCoreData()
        imagesCollectionView.register(UINib(nibName: "PoductsImagesCollectionViewCell", bundle: .main), forCellWithReuseIdentifier: "imageCell")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.updateUi()
        self.fetchfromcoredata()
        self.fetchFavoritFromCoreData()
        imagesCollectionView.register(UINib(nibName: "PoductsImagesCollectionViewCell", bundle: .main), forCellWithReuseIdentifier: "imagesCell")
       
    }
    
    func saveProducts(){
       let favoritProduct = Favourite(context: context)
        favoritProduct.productName = product4Segue?.vendor
        favoritProduct.productInfo = product4Segue?.title
        favoritProduct.productImage = product4Segue?.image?.src
        favoritProduct.productID =  Int64((product4Segue?.id)!)
       save()

    }
    
    func deleteProduct(){
        if let result = try? context.fetch(Favourite.fetchRequest()) {
            if let deletedItem = result.last {
                context.delete(deletedItem)
            }
           
          
        }
       save()
    }
    
    
    func fetchFavoritFromCoreData()
    {
        if let result = try? context.fetch(Favourite.fetchRequest()) {
            
                for i in 0..<result.count
                {
                    if result[i].productID == (product4Segue?.id)!
                    {
                        isFavourit = false

                    }
                }
            }
    }
   
    
    func saveProductsToCart(){
       let carted = CartedProducts(context: context)
        
        carted.productName = product4Segue?.title
        carted.productInfo = product4Segue?.body_html
        carted.productImage = product4Segue?.image?.src
        carted.productStatus = "cart"
        carted.productPrice = product4Segue?.variants![0].price
        let id = Int64((product4Segue?.id)!)
        carted.productID = id
        carted.numberOfProducts = 1
        save()
        
        }
    
    // delete from carts in DB
    func deleteProductsToCart(){
        if let result = try? context.fetch(CartedProducts.fetchRequest()) {
            if result.count == 1
            {
                if result[0].productID == (product4Segue?.id)!
                {
                    context.delete(result[0])
                    save()
                }
            }else
            {
                for i in 0..<result.count
                {
                    if result[i].productID == (product4Segue?.id)!
                    {
                    context.delete(result[i])
                    save()
                    }
                }
            }
            }
    }
    
    // fetch  carts From core data
    func fetchfromcoredata()
    {
        if let result = try? context.fetch(CartedProducts.fetchRequest()) {
            
            if result.count == 1
            {
                if result[0].productID == (product4Segue?.id)!
                {
                    cartButton.image = UIImage(systemName: "cart.fill.badge.minus")
                    cartButton.tintColor = .red
                    isCarted = false

                }
            }else
            {
                for i in 0..<result.count
                {
                    if result[i].productID == (product4Segue?.id)!
                    {
                        cartButton.image = UIImage(systemName: "cart.fill.badge.minus")
                        isCarted = false

                    }
                }
            }
    }
    }
    
    
    // save any Changes to Core Data
    func save(){
        do {
            try context.save()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func showAlert(alertMessage:String){
        let alert = UIAlertController(title: "Want To Check You Favourite ?", message: alertMessage, preferredStyle: .alert)
        let action = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let segueAction = UIAlertAction(title: "Go To Favourite", style: .default, handler: {_ in
            self.performSegue(withIdentifier: "goToFavFromProduct", sender: Any?.self)
        })
        alert.addAction(action)
        alert.addAction(segueAction)
        present(alert, animated: true, completion: nil)
    }
    
    func showAlertForCart(alertMessage:String)
    {
        let alert = UIAlertController(title: "Want To Check You Cart ?", message: alertMessage, preferredStyle: .alert)
        let action = UIAlertAction(title: "Continue", style: .cancel, handler: nil)
        let segueAction = UIAlertAction(title: "Go To Cart", style: .default, handler: {_ in
            self.performSegue(withIdentifier: "goToCartFromProduct", sender: Any?.self)
        })
        alert.addAction(action)
        alert.addAction(segueAction)
        present(alert, animated: true, completion: nil)
    }

   
    func updateUi (){
        imagesCollectionView.layer.cornerRadius = 15
        imagesCollectionView.layer.borderWidth = 1
        imagesCollectionView.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        
        productDesc.layer.cornerRadius = 15
        productDesc.layer.borderWidth = 1
        productDesc.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        self.navigationItem.title = product4Segue?.vendor
        productPrice.text = "Price : \(String(describing: (product4Segue?.variants![0].price)!) ?? "89.00  £")  £ "
        productDesc.text = product4Segue?.body_html
        productInfo.text = product4Segue?.title
        productColor.text = "Color : " + (product4Segue?.variants![0].title ?? "One Color")
        productRating.text = "Rating : 4.1 "
        
    }

}

extension ProductDetailsViewController: UICollectionViewDataSource , UICollectionViewDelegate , UICollectionViewDelegateFlowLayout , UIScrollViewDelegate
{
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == imagesCollectionView
        {
            productPageControl.numberOfPages = (product4Segue?.images!.count)!
            return (product4Segue?.images!.count)!
        }else
        {
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == imagesCollectionView
        {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "imageCell", for: indexPath) as! PoductsImagesCollectionViewCell
            collectionView.isPagingEnabled = true
            cell.productImage.sd_setImage(with: URL(string: (product4Segue?.images![indexPath.row].src)!), placeholderImage: UIImage(named: "placeholder.png"))
            cell.updateCellUi(forCell: cell)
        return cell
        }
        else
        {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "imageCell", for: indexPath)
            return cell
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize (width: collectionView.frame.size.width , height: collectionView.frame.size.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        cell.alpha = 0.2
        UIView.animate(withDuration: 0.8) {
        cell.alpha = 1
        }
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
                let pageWidth = self.imagesCollectionView.frame.size.width
        productPageControl.currentPage = Int(self.imagesCollectionView.contentOffset.x / pageWidth)
            }
    
}
