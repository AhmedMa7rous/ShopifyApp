//
//  BrandProductsCollectionViewCell.swift
//  ShopifyApp
//
//  Created by Ahmed Mostafa on 16/03/2022.
//  Copyright © 2022 Ma7rous. All rights reserved.
//

import UIKit
import SDWebImage
class BrandProductsCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var productLabel: UILabel!
    @IBOutlet weak var brandProductImage: UIImageView!
    @IBOutlet weak var productPrice: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    var  BrandProductCell : BrandProductCell? {
        didSet {
            
           brandProductImage.sd_setImage(with: URL(string: BrandProductCell?.productCellImage ?? ""), placeholderImage: UIImage(systemName: "photo"))
            
        }
    }

}
