//
//  SlideView.swift
//  AFBN
//
//  Created by Erudition Informatics on 23/04/19.
//  Copyright © 2019 Erudition Informatics. All rights reserved.
//

import UIKit

protocol splashControllerProtocol{
    
    func moveTo_memberController()
    func moveTo_singInController()
    
}

class SlideView: UIView {
    //var splashDelegate: splashControllerProtocol
    
    var splashDelegate:splashControllerProtocol?

    @IBOutlet weak var mainBackScroll: UIScrollView!

    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var descLbl: UILabel!
    @IBOutlet weak var descLbl1: UILabel!
    
    @IBOutlet weak var memberBtn: UIButton!
    @IBOutlet weak var signInBtn: UIButton!
    
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    
    
    @IBAction func memberBtnAction(_ sender: UIButton) {
        splashDelegate?.moveTo_memberController()
    }
    
    
    @IBAction func singInBtnAction(_ sender: UIButton) {
        splashDelegate?.moveTo_singInController()
    }
    
    

}
