//
//  FullScreenImageViewController.swift
//  AFBN
//
//  Created by Erudition Informatics on 19/07/19.
//  Copyright © 2019 Erudition Informatics. All rights reserved.
//

import UIKit

class FullScreenImageViewController: UIViewController {
    
    @IBOutlet weak var fullImgVw:UIImageView!
    @IBOutlet weak var backBtn:UIButton!
    
    var imgUrl:String!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.hidesBottomBarWhenPushed = true
        // Do any additional setup after loading the view.
        self.loadFullImageVw()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    //MARK: - Load Image
    func loadFullImageVw(){
        self.fullImgVw.sd_setImage(with: URL(string: self.imgUrl), placeholderImage: UIImage(named: "placeholder.png"))
    }

    //MARK: - Button Action
    @IBAction func backBtnAction(_ sender: UIButton){
        self.navigationController?.popViewController(animated: true)
    }
}
