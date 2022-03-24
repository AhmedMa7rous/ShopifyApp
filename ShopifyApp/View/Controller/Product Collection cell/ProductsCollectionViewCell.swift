//
//  ProductsCollectionViewCell.swift
//  ShopifyApp
//
//  Created by ahmed osama on 3/15/22.
//  Copyright © 2022 Ma7rous. All rights reserved.
//

import UIKit
import SDWebImage

class ProductsCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet var productImage: UIImageView!
    @IBOutlet var produvtName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    var  productListCellViewModel : ProductsCellModel? {
        didSet {
            //produvtName.text = productListCellViewModel?.titleText
        
            productImage?.sd_setImage(with: URL( string: productListCellViewModel?.imageUrl ?? "" ), completed: nil)
            
        }
    }

    /*===============================================*/
        //MARK: Services Functions
        func updateCellUi(forCell cell:ProductsCollectionViewCell) {
            productImage.layer.borderWidth = 1.0
            productImage.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            productImage.layer.cornerRadius = 10
            cell.layer.shadowOpacity = 1
            cell.layer.shadowRadius = 1
            cell.layer.shadowColor = #colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 1)
            cell.layer.shadowOffset = CGSize(width: 0, height: 2)
            cell.layer.masksToBounds = true;
        }
}
