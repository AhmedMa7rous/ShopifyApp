//
//  CategoriesViewController.swift
//  ShopifyApp
//
//  Created by Ma7rous on 3/16/22.
//  Copyright © 2022 Ma7rous. All rights reserved.
//
import UIKit
import FavoriteButton


class CategoriesViewController: UIViewController {
/*=======================================================================*/
    //MARK: Constants & Variables
    lazy var categoriesViewModelObject: CategoriesViewModel = {
        return CategoriesViewModel()
    }()
    
/*=======================================================================*/
    //MARK: Outlet Connections
    @IBOutlet weak var categoryFilterSegmentControl: UISegmentedControl!
    @IBOutlet weak var categoriesCollectionView: UICollectionView!
    @IBOutlet weak var favouriteView: UIView!
    @IBOutlet weak var favouritesStateLbl: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    /*=======================================================================*/
    //MARK: ViewController LifeCycle Functions
    override func viewWillAppear(_ animated: Bool) {
        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Register Collections Cells
        categoriesCollectionView.register(CategoriesCollectionViewCell.nib, forCellWithReuseIdentifier: CategoriesCollectionViewCell.identifier)
        
        // Set delegate and DataSource for Collections
        categoriesCollectionView.delegate = self
        categoriesCollectionView.dataSource = self
        updateUI()
        initViewModel()
    }
/*=======================================================================*/
    //MARK: Action Connections
    @IBAction func categoryFilterSegmentSelected(_ sender: UISegmentedControl) {
        
        switch categoryFilterSegmentControl.selectedSegmentIndex {
        case 0:
            print("1")
        case 1:
            print("2")
        case 2:
            print("3")
        default:
            print("4")
        }
    }
/*=======================================================================*/
    //MARK: Action Functions
    @objc func addToFavorites(_ sender: FavoriteButton){
        if sender.isSelected == true {
            self.showFavouriteState(state: "save")
            //TODO: Save product in CoreData and add to favourites Controller
            print("save")
    
        } else {
            self.showFavouriteState(state: "delete")
            //TODO: Delete product from CoreData and favourites controller
        
            print("delete")
        }
    }
    
    @objc func goToFavorite(_ sender: UIBarButtonItem) {
       let vc = FavoritesViewController()
       navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func goToCart(_ sender: UIBarButtonItem) {
        let vc = CartViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    @objc func goToSearch(_ sender: UIBarButtonItem) {
        let vc = SearchViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
/*======================================================================*/
    //MARK: Services Functions
    func updateUI() {
        categoriesCollectionView.layer.borderWidth = 2.0
        categoriesCollectionView.layer.borderColor = #colorLiteral(red: 0.2023005321, green: 0.1819013293, blue: 0.1702587172, alpha: 1)
        let Layout = categoriesCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
        Layout.minimumLineSpacing = 15.0
        Layout.minimumInteritemSpacing = 15.0
    
        
        //set title
        self.navigationItem.title = "Categories"
            
        //create barButtonitem and add to navigation Bar
        let searchButton = UIBarButtonItem(image: UIImage(systemName: "magnifyingglass"), style: .plain, target: self, action: #selector(goToSearch(_:)))
        let favoriteButton = UIBarButtonItem(image: UIImage(systemName: "heart.fill"), style: .plain, target: self, action: #selector(goToFavorite(_:)))
        favoriteButton.tintColor = .red
        let cartButton = UIBarButtonItem(image: UIImage(systemName: "cart.fill"), style: .plain, target: self, action: #selector(goToCart(_:)))
            navigationItem.rightBarButtonItems = [favoriteButton, cartButton]
            navigationItem.leftBarButtonItem = searchButton
    }
    
    func initViewModel() {

        categoriesViewModelObject.showAlertClosure = { [weak self] () in
            DispatchQueue.main.async {
                if let message = self?.categoriesViewModelObject.alertMessage {
                    self?.onFailureUpdateView(errorMessage: message)
                }
            }
        }
        
        categoriesViewModelObject.updateLoadingStatus = { [weak self] () in
            guard let self = self else {
                return
            }
                    
            DispatchQueue.main.async { [weak self] in
                guard let self = self else {
                    return
                }
                switch self.categoriesViewModelObject.state {
                case .empty, .error:
                    self.activityIndicator.stopAnimating()
                    self.activityIndicator.alpha = 0.0
                    UIView.animate(withDuration: 0.2, animations: {
                        self.categoriesCollectionView.alpha = 0.0
                    })
                case .loading:
                    self.activityIndicator.startAnimating()
                    self.activityIndicator.alpha = 1.0
                    UIView.animate(withDuration: 0.2, animations: {
                        self.categoriesCollectionView.alpha = 0.0
                    })
                case .populated:
                    self.activityIndicator.stopAnimating()
                    self.activityIndicator.alpha = 0.0
                    UIView.animate(withDuration: 0.2, animations: {
                        self.categoriesCollectionView.alpha = 1.0
                    })
                }
            }
        }
                
        categoriesViewModelObject.reloadCollectionViewClosure = { [weak self] () in
            DispatchQueue.main.async {
                self?.categoriesCollectionView.reloadData()
            }
        }
            
        categoriesViewModelObject.initFetch()
            
    }
    
    func onSuccessUpdateView() {
        
        self.categoriesCollectionView.reloadData()
    }
    
    func onFailureUpdateView(errorMessage: String) {
        let alert = UIAlertController(title: "Connection Error!", message: errorMessage, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }

    func showFavouriteState(state: String) {
        self.favouriteView.layer.cornerRadius = 15
        UIView.animate(withDuration: 1, delay: 0, options: [.transitionCurlUp], animations: {
            if state == "delete" {
                self.favouriteView.isHidden = false
                self.favouriteView.backgroundColor = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
                self.favouritesStateLbl.text = "Product Deleted From Favourites!"
                DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                    self.favouriteView.isHidden = true
                }
            }else if state == "save" {
                self.favouriteView.isHidden = false
                self.favouriteView.backgroundColor = #colorLiteral(red: 0, green: 0.9768045545, blue: 0, alpha: 1)
                self.favouritesStateLbl.text = "Product Added To Favourites!"
                DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                    self.favouriteView.isHidden = true
                }
            }
        }, completion: nil)
    }
}

/*======================================================================*/
    //MARK: CollectionView Functions
extension CategoriesViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categoriesViewModelObject.numberOfItems
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoriesCollectionViewCell.identifier, for: indexPath) as? CategoriesCollectionViewCell else {
            fatalError("Cell not exists in XIP Modules!")
        }
        let cellVM = categoriesViewModelObject.getCellViewModel(at: indexPath)
        cell.categoryCellViewModel = cellVM
        cell.updateCellUi(forCell: cell)
        cell.favouriteProductButton.addTarget(self, action: #selector(addToFavorites(_:)), for: .touchUpInside)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding: CGFloat =  55
        let collectionViewSize = collectionView.frame.size.width - padding
        return CGSize(width: collectionViewSize/3, height: 150)
    }
       
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        cell.alpha = 0.2
        UIView.animate(withDuration: 0.8) {
        cell.alpha = 1
        }
    }
}
