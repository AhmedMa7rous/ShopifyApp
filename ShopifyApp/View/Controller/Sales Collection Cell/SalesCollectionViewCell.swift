//
//  salesCollectionViewCell.swift
//  ShopifyApp
//
//  Created by Ahmed Mostafa on 16/03/2022.
//  Copyright © 2022 Ma7rous. All rights reserved.
//

import UIKit

class SalesCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var SaleImage: UIImageView!
    
    /*===============================================*/
        //MARK: Services Functions
        func updateCellUi(forCell cell: SalesCollectionViewCell) {
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

