//
//  ViewController.swift
//  ShopifyApp
//
//  Created by Ma7rous on 3/10/22.
//  Copyright © 2022 Ma7rous. All rights reserved.
//

import UIKit

class SplashViewController: UIViewController {
/*============================================*/
    //MARK: Outlet Connections
    @IBOutlet weak var getStartedBtn: UIButton!
    @IBOutlet weak var logInBtn: UIButton!
/*============================================*/
    //MARK: Screen LifeCycle Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.updateUI()
        
    }
/*============================================*/
    //MARK: Action Connections
    @IBAction func getStartedTapped(_ sender: UIButton) {
        onClickButtonUI(button: sender)
        let vc = storyboard?.instantiateViewController(identifier: "logUp") as! LogUpViewController
        vc.modalPresentationStyle = .overCurrentContext
        present(vc, animated: true, completion: nil)
    }
    
    @IBAction func logInTapped(_ sender: UIButton) {
        onClickButtonUI(button: sender)
        let vc = storyboard?.instantiateViewController(identifier: "logIn") as! LogInViewController
        vc.modalPresentationStyle = .overCurrentContext
        present(vc, animated: true, completion: nil)
    }
/*============================================*/
    //MARK: Services Functions
    func updateUI() {
        self.getStartedBtn.layer.cornerRadius = 15
        self.logInBtn.layer.cornerRadius = 15
        self.getStartedBtn.layer.shadowOpacity = 1.0
        self.getStartedBtn.layer.shadowRadius = 1.0
        self.getStartedBtn.layer.shadowOffset = CGSize(width: 0,height: 2)
        self.logInBtn.layer.shadowOpacity = 1.0
        self.logInBtn.layer.shadowRadius = 1.0
        self.logInBtn.layer.shadowOffset = CGSize(width: 0,height: 2)
    }
    
    func onClickButtonUI(button: UIButton) {
        button.layer.shadowOpacity = 0.5
        button.layer.shadowOffset = CGSize(width: 0,height: 6)
        button.alpha = 0.9
    }
}

