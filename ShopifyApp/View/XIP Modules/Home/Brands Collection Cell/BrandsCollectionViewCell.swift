//
//  BrandsCollectionViewCell.swift
//  ShopifyApp
//
//  Created by Ma7rous on 3/19/22.
//  Copyright © 2022 Ma7rous. All rights reserved.
//

import UIKit
import SDWebImage

class BrandsCollectionViewCell: UICollectionViewCell {
/*===============================================*/
    //MARK: Constants & Variables
    var brandCellViewModel: HomeCellViewModel? {
        didSet {
            guard let imgUrl = URL(string: brandCellViewModel!.imageUrl) else {return}
            self.brandImageView.sd_setImage(with: imgUrl, completed: nil)
            self.brandNameLabel.text = brandCellViewModel?.titleText
        }
    }
/*===============================================*/
    //MARK: Outlet Connections
    @IBOutlet weak var brandImageView: UIImageView!
    @IBOutlet weak var brandNameLabel: UILabel!

/*===============================================*/
    //MARK: Services Functions
    func updateCellUi(forCell cell:BrandsCollectionViewCell) {
        cell.layer.borderWidth = 2.0
        cell.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        cell.layer.cornerRadius = 25
        cell.layer.shadowOpacity = 1
        cell.layer.shadowRadius = 1
        cell.layer.shadowColor = #colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 1)
        cell.layer.shadowOffset = CGSize(width: 0, height: 2)
        cell.layer.masksToBounds = true;
    }
}
