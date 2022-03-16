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

    @IBOutlet var productImage: UIImageView!
    @IBOutlet var produvtName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    var  productListCellViewModel : ProductsCellModel? {
        didSet {
            produvtName.text = productListCellViewModel?.titleText
        
            productImage?.sd_setImage(with: URL( string: productListCellViewModel?.imageUrl ?? "" ), completed: nil)
            
        }
    }

}
