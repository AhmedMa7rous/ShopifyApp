//
//  AllOrdersTableViewCell.swift
//  ShopifyApp
//
//  Created by Ahmed Mostafa on 23/03/2022.
//  Copyright © 2022 Ma7rous. All rights reserved.
//

import UIKit

class AllOrdersTableViewCell: UITableViewCell {

    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var orderDateLabel: UILabel!
    @IBOutlet weak var shippingDateLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
