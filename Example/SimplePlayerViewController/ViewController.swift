//
//  ViewController.swift
//  SimplePlayerViewController
//
//  Created by ssTaoz on 06/11/2018.
//  Copyright (c) 2018 ssTaoz. All rights reserved.
//

import UIKit
import SimplePlayerViewController
import AVKit

class ViewController: UIViewController {

    
    let playerViewController = SimplePlayerViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        playerViewController.view.frame = CGRect(x: 0, y: 100, width: 375, height: 190);
        self.view.addSubview(playerViewController.view)
        

        
    }

    @IBAction func playAction(_ sender: Any) {
        
        let player = AVPlayer(url: URL.init(string: "http://wx.zptv.com.cn/upload/201805/28/201805280930223323.mp4")!)
        playerViewController.player = player;
        
//        AVPlayer *player = [[AVPlayer alloc] initWithURL:[NSURL URLWithString:self.url]];
//        self.playerViewController.player = player;
        
    }


}

