//
//  PoductsImagesCollectionViewCell.swift
//  ShopifyApp
//
//  Created by Ahmed Mostafa on 15/03/2022.
//  Copyright © 2022 Ma7rous. All rights reserved.
//

import UIKit

class PoductsImagesCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var productImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    /*===============================================*/
        //MARK: Services Functions
        func updateCellUi(forCell cell:PoductsImagesCollectionViewCell) {
            cell.layer.cornerRadius = 10
            cell.layer.shadowOpacity = 1
            cell.layer.shadowRadius = 1
            cell.layer.shadowColor = #colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 1)
            cell.layer.shadowOffset = CGSize(width: 0, height: 2)
            cell.layer.masksToBounds = true;
        }
    
}
