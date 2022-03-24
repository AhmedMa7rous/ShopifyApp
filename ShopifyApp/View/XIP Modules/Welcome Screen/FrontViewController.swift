//
//  FrontViewController.swift
//  ShopifyApp
//
//  Created by Ma7rous on 3/16/22.
//  Copyright © 2022 Ma7rous. All rights reserved.
//
import AVKit
import UIKit

class FrontViewController: UIViewController {
    
/*============================================*/
    //MARK: Constants & Variables
    var videoPlayer: AVPlayer?
    var videoPlayerLayer: AVPlayerLayer?
    
/*============================================*/
    //MARK: Outlet Connections
    @IBOutlet weak var getStartedButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    
/*============================================*/
    //MARK: ViewController LifeCycle Functions
    override func viewWillAppear(_ animated: Bool) {
        // Setup video in the background
        setUpVideo()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUi()
    }
    
/*============================================*/
    //MARK: Action Connections
    @IBAction func getStartedTapped(_ sender: UIButton){
        onClickButtonUI(button: sender)
        let vc = LogUpViewController()
        vc.modalPresentationStyle = .overCurrentContext
        present(vc, animated: true, completion: nil)
    }
    @IBAction func loginTapped(_ sender: UIButton){
        onClickButtonUI(button: sender)
        let vc = LoginViewController()
        vc.modalPresentationStyle = .overCurrentContext
        present(vc, animated: true, completion: nil)
    }
    
/*============================================*/
    //MARK: Services Functions
    func setUpUi() {
        Utilities.styleFilledButton(getStartedButton)
        Utilities.styleHollowButton(loginButton)
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
