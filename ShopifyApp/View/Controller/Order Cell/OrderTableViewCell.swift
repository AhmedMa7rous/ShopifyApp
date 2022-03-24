//
//  OrderTableViewCell.swift
//  ShopifyApp
//
//  Created by ahmed osama on 3/20/22.
//  Copyright © 2022 Ma7rous. All rights reserved.
//

import UIKit
protocol OrderTableViewCellDelegate:AnyObject{
    func tapPlusButton(indexpath: IndexPath)
    func tapMinsButton(indexpath: IndexPath)
}

class OrderTableViewCell: UITableViewCell {
    weak var delegate: OrderTableViewCellDelegate?
    var indexpath: IndexPath!
    @IBOutlet var productImage: UIImageView!
    @IBOutlet var productName: UILabel!
    @IBOutlet var numberOfProuduct: UILabel!
    @IBOutlet weak var totalPrice: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
     
    @IBAction func subProduct(_ sender: Any) {
        delegate?.tapMinsButton(indexpath: indexpath)
    }
    @IBAction func addProduct(_ sender: Any) {
        delegate?.tapPlusButton(indexpath: indexpath)
    }
    var  orderTableViewCellModel : OrderTableViewCellModel? {
          didSet {
              productName.text = orderTableViewCellModel?.titleText
          
              productImage?.sd_setImage(with: URL( string: orderTableViewCellModel?.imageUrl ?? "" ), completed: nil)
            numberOfProuduct.text = orderTableViewCellModel?.numberOfProuduct
          }
      }
    
}
