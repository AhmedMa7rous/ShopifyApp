//
//  Extension+UIView.swift
//  SwooshApp
//
//  Created by Ma7rous on 3/7/22.
//  Copyright © 2022 Ma7rous. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    static var identifier: String {
        return String(describing: self)
    }
    
    static var nib : UINib {
        return UINib(nibName : "\(self)",bundle : nil)
    }
}
