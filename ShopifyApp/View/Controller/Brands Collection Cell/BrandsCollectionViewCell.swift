

import UIKit
import SDWebImage
class BrandsCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var brandImage: UIImageView!

    @IBOutlet weak var brandLabel: UILabel!
    
    var BrandListCellViewModel : BrandViewModelCell? {
        didSet {
            
            //brandLabel.text = BrandListCellViewModel?.brandLabelCell
            brandImage.sd_setImage(with: URL(string: BrandListCellViewModel?.brandImageCell ?? ""), placeholderImage: UIImage(systemName: "placeholder"))
            
        }
    }
    
    /*===============================================*/
        //MARK: Services Functions
        func updateCellUi(forCell cell: BrandsCollectionViewCell) {
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
