//
//  ViewController.swift
//  ShopifyApp
//
//  Created by Ma7rous on 3/10/22.
//  Copyright © 2022 Ma7rous. All rights reserved.
//
import AVKit
import UIKit

class SplashViewController: UIViewController {
/*============================================*/
    //MARK: Constants & Variables
    var videoPlayer: AVPlayer?
    var videoPlayerLayer: AVPlayerLayer?
    
/*============================================*/
    //MARK: Outlet Connections
    @IBOutlet weak var getStartedBtn: UIButton!
    @IBOutlet weak var logInBtn: UIButton!
/*============================================*/
    //MARK: Screen LifeCycle Functions
    override func viewWillAppear(_ animated: Bool) {
        setUpVideo()
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.updateUI()
        
    }
/*============================================*/
    //MARK: Action Connections
    @IBAction func getStartedTapped(_ sender: UIButton) {
        onClickButtonUI(button: sender)
        let vc = self.storyboard?.instantiateViewController(identifier: "logUp") as! LogUpViewController
        vc.modalPresentationStyle = .overCurrentContext
        present(vc, animated: true, completion: nil)
    }
    
    @IBAction func logInTapped(_ sender: UIButton) {
        onClickButtonUI(button: sender)
        let vc = self.storyboard?.instantiateViewController(identifier: "logIn") as! LoginViewController
        vc.modalPresentationStyle = .overCurrentContext
        present(vc, animated: true, completion: nil)
    }
/*============================================*/
    //MARK: Services Functions
    func updateUI() {
        Utilities.styleFilledButton(getStartedBtn)
        
        Utilities.styleHollowButton(logInBtn)
    }
    
    func onClickButtonUI(button: UIButton) {
        button.layer.shadowOpacity = 0.5
        button.layer.shadowOffset = CGSize(width: 0,height: 6)
        button.alpha = 0.8
    }
    
    func setUpVideo() {
        // Get the path to the resource in the bundle
        let path = Bundle.main.path(forResource: "splash", ofType: "mp4")
        guard path != nil else {return}
        
        // Create a URL from it
        let url = URL(fileURLWithPath: path!)
        
        // Cretae the video player item
        let item = AVPlayerItem(url: url)
        
        // Create the palayer
        videoPlayer = AVPlayer(playerItem: item)

        // Create the layer
        videoPlayerLayer = AVPlayerLayer(player: videoPlayer!)
        
        // Adjust the size and the frame
        videoPlayerLayer?.frame = CGRect(x: 0, y: 30, width: self.view.frame.size.width, height: self.view.frame.size.height)
        view.layer.insertSublayer(videoPlayerLayer!, at: 0)
        
        // Add it to the view and play it
        videoPlayer?.playImmediately(atRate: 0.8)
    }
}

