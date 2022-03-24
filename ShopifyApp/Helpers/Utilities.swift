//
//  Utilities.swift
//  ShopifyApp
//
//  Created by Ma7rous on 3/17/22.
//  Copyright © 2022 Ma7rous. All rights reserved.
//

import Foundation
import UIKit


class Utilities {
    static func styleTextField(_ textField: UITextField){
        // Create the Bottom line
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0, y: textField.frame.height - 2, width: textField.frame.width, height: 2)
        
        bottomLine.backgroundColor = UIColor.init(red: 48/255, green: 173/255, blue: 99/255, alpha: 1).cgColor
        
        // Remove border on textField
        textField.borderStyle = .none
        
        // Add the line to the textfield
        textField.layer.addSublayer(bottomLine)
    }
    
    static func styleFilledButton(_ button: UIButton) {
        // Filled rounded corner style
        button.backgroundColor = UIColor.init(red: 48/255, green: 173/255, blue: 99/255, alpha: 1)
        button.layer.cornerRadius = 20.0
        button.tintColor = UIColor.white
        button.layer.shadowOpacity = 1
        button.layer.shadowRadius = 1
        button.layer.shadowOffset = CGSize(width: 0, height: 2)
    }
    
    static func styleHollowButton(_ button: UIButton) {
        // Hollow rounded corner style
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.cornerRadius = 20.0
        button.tintColor = UIColor.black
        button.layer.shadowOpacity = 1
        button.layer.shadowRadius = 1
        button.layer.shadowOffset = CGSize(width: 0, height: 2)
    }
    
    static func isPasswordValid(_ password: String) -> Bool {
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-z])(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&]{8,}")
        return passwordTest.evaluate(with: password)
    }
    
}
