//
//  CustomAlertView.swift
//  AFBN
//
//  Created by Erudition Informatics on 24/04/19.
//  Copyright © 2019 Erudition Informatics. All rights reserved.
//

import UIKit

protocol customAlertProtocol{
    
    func moveTo_verifyController()
    
}

class CustomAlertView: UIView {

    var alertDelegate:customAlertProtocol?
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    @IBAction func nextBtnAction(_ sender: UIButton) {
        alertDelegate?.moveTo_verifyController()
    }
    
}
