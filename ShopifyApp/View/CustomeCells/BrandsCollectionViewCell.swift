//
//  CollectionViewCell.swift
//  ShopifyApp
//
//  Created by Abdallah Ehab on 15/03/2022.
//  Copyright © 2022 Ma7rous. All rights reserved.
//

import UIKit
import SDWebImage
class BrandsCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var brandImage: UIImageView!
    
    @IBOutlet weak var brandLabel: UILabel!
    
    var BrandListCellViewModel : BrandViewModelCell? {
        didSet {
            
            //brandLabel.text = BrandListCellViewModel?.brandLabelCell
            brandImage.sd_setImage(with: URL(string: BrandListCellViewModel?.brandImageCell ?? ""), placeholderImage: UIImage(systemName: "photo"))
        }
    }
    
}
