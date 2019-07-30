//
//  VideoViewController.swift
//  AFBN
//
//  Created by Erudition Informatics on 27/07/19.
//  Copyright © 2019 Erudition Informatics. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit

class VideoViewController: UIViewController {
    
    @IBOutlet weak var fullImgVw:UIImageView!
    @IBOutlet weak var backBtn:UIButton!
    
    var videoUrl:String!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.hidesBottomBarWhenPushed = true
        // Do any additional setup after loading the view.
        self.playVideofromurl(vid_url:self.videoUrl)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    //MARK: - play video
    func playVideofromurl(vid_url:String){
        let videoURL = URL(string: vid_url)
        let avPlayer = AVPlayer(url: videoURL!)
        //avPlayer = AVPlayer(url: fileURL)
        let avPlayerController = AVPlayerViewController()
        avPlayerController.player = avPlayer
        avPlayerController.view.frame = self.fullImgVw.frame
        avPlayerController.view.center = self.fullImgVw.center
        // Turn on video controlls
        avPlayerController.showsPlaybackControls = true
        
        // play video
        avPlayerController.player?.play()
        self.fullImgVw.addSubview(avPlayerController.view)
        self.addChild(avPlayerController)
        //player.play()
    }

    //MARK: - Button Action
    @IBAction func backBtnAction(_ sender: UIButton){
        self.navigationController?.popViewController(animated: true)
    }
}
