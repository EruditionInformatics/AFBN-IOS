//
//  CustomThanksView.swift
//  AFBN
//
//  Created by Erudition Informatics on 29/04/19.
//  Copyright © 2019 Erudition Informatics. All rights reserved.
//

import UIKit

class CustomThanksView: UIView {
    
    @IBOutlet weak var ticImg:UILabel!
    @IBOutlet weak var lbl1:UILabel!
    @IBOutlet weak var Lbl2:UILabel!

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    func setTxt(txt:String){
        Lbl2.text = txt
    }

}
