//
//  HomeViewController.swift
//  ShopifyApp
//
//  Created by Ma7rous on 3/16/22.
//  Copyright © 2022 Ma7rous. All rights reserved.
//
import UIKit

class HomeViewController: UIViewController {
/*=====================================================================*/
    //MARK: Constants & Variables
    lazy var homeViewModelObject: HomeViewModel = {
        return HomeViewModel()
    }()
    
/*=====================================================================*/
    //MARK: Outlet Connections
    @IBOutlet weak var salesCollectionView: UICollectionView!
    @IBOutlet weak var brandsCollectionView: UICollectionView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    /*=====================================================================*/
    //MARK: ViewController LifeCycle Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
        initViewModel()
    }
/*=====================================================================*/
     //MARK: Action Connections
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
        
        // Register Collections Cells
        salesCollectionView.register(SalesCollectionViewCell.nib, forCellWithReuseIdentifier: SalesCollectionViewCell.identifier)
        brandsCollectionView.register(BrandsCollectionViewCell.nib, forCellWithReuseIdentifier: BrandsCollectionViewCell.identifier)
        
        // Set delegate and DataSource for Collections
        let bransLayout = brandsCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
        bransLayout.minimumLineSpacing = 15.0
        bransLayout.minimumInteritemSpacing = 15.0
        let salesLayout = salesCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
        salesLayout.minimumLineSpacing = 15.0
        salesLayout.minimumInteritemSpacing = 15.0
        
        salesCollectionView.delegate = self
        salesCollectionView.dataSource = self
        brandsCollectionView.delegate = self
        brandsCollectionView.dataSource = self
        brandsCollectionView.layer.cornerRadius = 15
        salesCollectionView.layer.cornerRadius = 15
        brandsCollectionView.layer.borderWidth = 1
        salesCollectionView.layer.borderWidth = 1
        brandsCollectionView.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        salesCollectionView.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        
        // Set Title
        self.navigationItem.title = "Home"
         
        //create barButtonitem and add to navigation Bar
        let searchButton = UIBarButtonItem(image: UIImage(systemName: "magnifyingglass"), style: .plain, target: self, action: #selector(goToSearch(_:)))
        let favoriteButton = UIBarButtonItem(image: UIImage(systemName: "heart.fill"), style: .plain, target: self, action: #selector(goToFavorite(_:)))
        favoriteButton.tintColor = .red
        let cartButton = UIBarButtonItem(image: UIImage(systemName: "cart.fill"), style: .plain, target: self, action: #selector(goToCart(_:)))
        navigationItem.rightBarButtonItems = [favoriteButton, cartButton]
        navigationItem.leftBarButtonItem = searchButton
    }
    
    
    func onSuccessUpdateView() {
        
        self.brandsCollectionView.reloadData()
    }
    
    func onFailureUpdateView(errorMessage: String) {
        let alert = UIAlertController(title: "Connection Error!", message: errorMessage, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func initViewModel() {
        homeViewModelObject.showAlertClosure = { [weak self] () in
            DispatchQueue.main.async {
                if let message = self?.homeViewModelObject.alertMessage {
                    self?.onFailureUpdateView(errorMessage: message)
                }
            }
        }
        
        homeViewModelObject.updateLoadingStatus = { [weak self] () in
            guard let self = self else {
                return
            }
            
            DispatchQueue.main.async { [weak self] in
                guard let self = self else {
                    return
                }
                switch self.homeViewModelObject.state {
                case .empty, .error:
                    self.activityIndicator.stopAnimating()
                    self.activityIndicator.alpha = 0.0
                    UIView.animate(withDuration: 0.2, animations: {
                        self.brandsCollectionView.alpha = 0.0
                    })
                case .loading:
                    self.activityIndicator.startAnimating()
                    self.activityIndicator.alpha = 1.0
                    UIView.animate(withDuration: 0.2, animations: {
                        self.brandsCollectionView.alpha = 0.0
                    })
                case .populated:
                    self.activityIndicator.stopAnimating()
                    self.activityIndicator.alpha = 0.0
                    UIView.animate(withDuration: 0.2, animations: {
                        self.brandsCollectionView.alpha = 1.0
                    })
                }
            }
        }
        
        homeViewModelObject.reloadCollectionViewClosure = { [weak self] () in
            DispatchQueue.main.async {
                self?.brandsCollectionView.reloadData()
            }
        }
        
        homeViewModelObject.initFetch()
        
    }
}

/*======================================================================*/
    //MARK: CollectionView Functions
extension  HomeViewController : UICollectionViewDelegate , UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch (collectionView)
        {
        case salesCollectionView :
            return 1
        case brandsCollectionView :
            return homeViewModelObject.numberOfItems
        default :
            return 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch (collectionView)
        {
        case salesCollectionView :
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SalesCollectionViewCell.identifier, for: indexPath) as! SalesCollectionViewCell
            
            return cell
        case brandsCollectionView :
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BrandsCollectionViewCell.identifier, for: indexPath) as? BrandsCollectionViewCell else {
                fatalError("Cell not exists in XIP Modules!")
            }
            let cellVM = homeViewModelObject.getCellViewModel(at: indexPath)
            cell.brandCellViewModel = cellVM
            cell.updateCellUi(forCell: cell)
            return cell
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BrandsCollectionViewCell.identifier, for: indexPath) as! BrandsCollectionViewCell
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
      
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding: CGFloat =  35
        let collectionViewSize = collectionView.frame.size.width - padding
        return CGSize(width: collectionViewSize/2, height: 180)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        cell.alpha = 0.2
        UIView.animate(withDuration: 0.8) {
        cell.alpha = 1
        }
    }
}
