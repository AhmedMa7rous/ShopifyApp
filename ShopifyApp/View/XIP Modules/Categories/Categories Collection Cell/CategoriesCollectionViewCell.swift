//
//  CategoriesCollectionViewCell.swift
//  ShopifyApp
//
//  Created by Ma7rous on 3/21/22.
//  Copyright © 2022 Ma7rous. All rights reserved.
//

import UIKit
import SDWebImage
import FavoriteButton

class CategoriesCollectionViewCell: UICollectionViewCell {
/*===============================================*/
    //MARK: Constants & Variables
    var categoryCellViewModel: CategoryCellViewModel? {
        didSet {
            guard let imgUrl = URL(string: categoryCellViewModel!.imageUrl) else {return}
            self.productImageView.sd_setImage(with: imgUrl, completed: nil)
            self.productPriceLabel.text = "\(categoryCellViewModel!.price) EGP"
        }
    }
/*==================================================*/
    //MARK: Outlet Connections
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var productPriceLabel: UILabel!
    @IBOutlet weak var favouriteProductButton: FavoriteButton!
    
/*===============================================*/
    //MARK: Services Functions
    func updateCellUi(forCell cell:CategoriesCollectionViewCell) {
        productImageView.layer.borderWidth = 1.0
        productImageView.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        productImageView.layer.cornerRadius = 10
        cell.layer.shadowOpacity = 1
        cell.layer.shadowRadius = 1
        cell.layer.shadowColor = #colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 1)
        cell.layer.shadowOffset = CGSize(width: 0, height: 2)
        cell.layer.masksToBounds = true;
    }
}
