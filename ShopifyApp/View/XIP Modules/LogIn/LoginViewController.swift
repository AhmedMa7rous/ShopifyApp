//
//  LoginViewController.swift
//  ShopifyApp
//
//  Created by Ma7rous on 3/16/22.
//  Copyright © 2022 Ma7rous. All rights reserved.
//
import Firebase
import UIKit

class LoginViewController: UIViewController {
/*===============================================*/
    //MARK: Constants & Variables
   
    
    
/*===============================================*/
    //MARK: Outlet Connections
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var logInButton: UIButton!
        
/*===============================================*/
    //MARK: ViewController LifeCycle Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUi()
        // Do any additional setup after loading the view.
    }
/*===============================================*/
    //MARK: Action Connections
    @IBAction func logInButtonTapped(_ sender: UIButton) {
        onClickButtonUI(button: logInButton)
        // Check fields validate
        let error = validateFields()
        if error != nil {
            self.sendAlert(error!)
        } else {
            // Get our clean data from register form
            let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)

            
            // Signing in the user
            Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
                if error != nil {
                    self.sendAlert(error!.localizedDescription)
                } else {
                    // Navigate to Home screen
                    let vc = TabBarViewController()
                    
                    vc.modalPresentationStyle = .overCurrentContext
                    self.present(vc, animated: true, completion: nil)
                }
            }
        }
    }
    
    @IBAction func getStaretedTapped(_ sender: UIButton) {
        onClickButtonUI(button: sender)
        let vc = LogUpViewController()
        vc.modalPresentationStyle = .overCurrentContext
        present(vc, animated: true, completion: nil)
    }
    
    @objc func eyeButtonTapped(_ sender: UIButton) {
        if sender.isSelected {
            sender.setImage(UIImage(systemName: "eye"), for: .normal)
            passwordTextField.isSecureTextEntry = false
            sender.isSelected = false
        } else {
            sender.setImage(UIImage(systemName: "eye.slash"), for: .normal)
            passwordTextField.isSecureTextEntry = true
            sender.isSelected = true
        }
    }
/*===============================================*/
    //MARK: Services Functions
    func setUpUi() {
        Utilities.styleFilledButton(logInButton)
        Utilities.styleTextField(emailTextField)
        setPasswordTextField(passwordTextField)
        
    }
    
    func setPasswordTextField(_ textField: UITextField) {
        // Create the Bottom line
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0, y: textField.frame.height - 2, width: textField.frame.width, height: 2)
        
        bottomLine.backgroundColor = UIColor.init(red: 48/255, green: 173/255, blue: 99/255, alpha: 1).cgColor
        
        // Remove border on textField
        textField.borderStyle = .none
        
        // Add the line to the textfield
        textField.layer.addSublayer(bottomLine)
        
        // Create eye button for password secure
        let btn = UIButton(type: .custom)
        btn.tintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        btn.isSelected = true
        btn.setImage(UIImage(systemName: "eye.slash"), for: .normal)
        btn.imageEdgeInsets = UIEdgeInsets(top: 0, left: -16, bottom: 0, right: 0)
        btn.frame = CGRect(x: CGFloat(textField.frame.size.width - 25), y: CGFloat(5), width: CGFloat(25), height: CGFloat(25))
        btn.addTarget(self, action: #selector(eyeButtonTapped(_:)), for: .touchUpInside)
        textField.rightView = btn
        textField.rightViewMode = .always
    }
    
    func onClickButtonUI(button: UIButton) {
        button.layer.shadowOpacity = 0.5
        button.layer.shadowOffset = CGSize(width: 0,height: 6)
        button.alpha = 0.8
    }
    
    
    // Check the fields and validate that the data is correct. if correct return nil otherwise return error message
    func validateFields() -> String? {
        // Check that all fields are filled in
        if emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""  {
            return "Please Fill in All Fields.!"
        }
        
        return nil
    }
    
    // Sending Alerts
    func sendAlert(_ string: String) {
        let alert = UIAlertController(title: "Input Error", message: string, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
