//
//  VideoViewController.swift
//  iOSTutorials
//
//  Created by CaryZheng on 2018/5/8.
//  Copyright © 2018年 CaryZheng. All rights reserved.
//

import UIKit
import AVKit

class VideoViewController: ZViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // play video online (AVPlayerViewController)
        testVideoOnline()
    }
    
    private func testVideoOnline() {
        let videoURL = URL(string: "http://ali.cdn.kaiyanapp.com/ca41515acf967fc06249c1a16a16f466_1280x720_854x480.mp4?auth_key=1525768485-0-0-c3e8a753122990de9e95d82841545ce2")!
        let player = AVPlayer(url: videoURL)
        
        let playerViewController = AVPlayerViewController()
        playerViewController.player = player
        self.present(playerViewController, animated: true) {
            playerViewController.player!.play()
        }
    }
    
}
