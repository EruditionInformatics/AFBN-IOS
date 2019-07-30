//
//  QuotationViewController.swift
//  AFBN
//
//  Created by Erudition Informatics on 10/05/19.
//  Copyright © 2019 Erudition Informatics. All rights reserved.
//

import UIKit

class QuotationViewController: UIViewController {
    
    @IBOutlet weak var createBtn:UIButton!
    @IBOutlet weak var importBtn:UIButton!
    
    @IBOutlet weak var buttonVw:UIView!
    
    @IBOutlet weak var mainScrlVw:UIScrollView!
    
    var topContentArray = ["Date","Ref","Quotation No.","To","To Contact","Summary","Payment Term","Notes","Attachments","Response","Other Notes"]

    //MARK: view cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
        setButton()
        setQuotationScrollVw()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    //MARK: Set Button
    func setButton(){
        
        createBtn.layer.cornerRadius = 5.0
        createBtn.layer.shadowColor = UIColor.gray.cgColor
        createBtn.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        createBtn.layer.shadowRadius = 2.0
        createBtn.layer.shadowOpacity = 1.0
        createBtn.layer.masksToBounds = false
        createBtn.layer.shadowPath=UIBezierPath(roundedRect:createBtn.bounds,cornerRadius:createBtn.layer.cornerRadius).cgPath
        
        importBtn.layer.cornerRadius = 5.0
        importBtn.layer.shadowColor = UIColor.gray.cgColor
        importBtn.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        importBtn.layer.shadowRadius = 2.0
        importBtn.layer.shadowOpacity = 1.0
        importBtn.layer.masksToBounds = false
        importBtn.layer.shadowPath=UIBezierPath(roundedRect:importBtn.bounds,cornerRadius:importBtn.layer.cornerRadius).cgPath
        
    }
    
    //MARK: Set quotation Scroll
    func setQuotationScrollVw(){
        
        let heightPadding = (buttonVw.frame.size.height + 85.0 )
        
        mainScrlVw.frame = CGRect(x: 0, y: buttonVw.frame.origin.y + buttonVw.frame.size.height , width: view.frame.width, height: view.frame.height - heightPadding)
        mainScrlVw.contentSize = CGSize(width:(150.0 * CGFloat(11)) + 50.0, height: 50.0 * 51)
        mainScrlVw.isPagingEnabled = true
        mainScrlVw.isScrollEnabled = true
        mainScrlVw.backgroundColor = UIColor.white
        
        let topVw = UIView(frame: CGRect(x: 0.0, y: 0.0, width: (150.0 * 11) + 50.0, height: 50.0))
        topVw.backgroundColor = UIColor(red: 92.0/255.0, green: 142.0/255.0, blue: 91.0/255.0, alpha: 1.0)
        mainScrlVw.addSubview(topVw)
        
        let toplineVw = UIView(frame: CGRect(x: 0.0, y: 5.0, width: (150.0 * 11) + 50.0, height: 1.0))
        toplineVw.backgroundColor = UIColor.white
        topVw.addSubview(toplineVw)
        
        let bottomlineVw = UIView(frame: CGRect(x: 0.0, y: topVw.frame.size.height - 5.0, width: (150.0 * 11) + 50.0, height: 1.0))
        bottomlineVw.backgroundColor = UIColor.white
        topVw.addSubview(bottomlineVw)
        
        let ticBtn = UIButton(frame: CGRect(x: 10.0, y: 15.0, width: 20.0, height: 20.0))
        ticBtn.layer.cornerRadius = 5.0
        ticBtn.layer.borderWidth = 1.0
        ticBtn.layer.borderColor = UIColor.darkGray.cgColor
        ticBtn.backgroundColor = UIColor.white
        //ticBtn.addTarget(self, action: #selector(self.headerTicBtnAction(_:)), for: .touchUpInside)
        topVw.addSubview(ticBtn)
        
        for i in 0..<topContentArray.count {
            
            var xPad = 50.0
            if(i == 0){
                xPad = Double(50.0 + 150.0 * Float(i))
            }else{
                xPad = Double(25.0 + 150.0 * Float(i))
            }
            
            let headerLbl = UILabel(frame: CGRect(x: xPad , y: 10.0, width: 130.0, height: 30.0))
            headerLbl.text = String(describing: topContentArray[i])
            headerLbl.backgroundColor = UIColor.clear
            headerLbl.font = UIFont.systemFont(ofSize: 12.0)
            headerLbl.textAlignment = NSTextAlignment.center
            topVw.addSubview(headerLbl)
            
            
        }
        
        for i in 1...50{
            
            let firstHeight = Float(topVw.frame.origin.y + topVw.frame.size.height)
            var yPad = 0.0
            if(i == 0){
                yPad = Double((firstHeight + 0.0) * Float(i))
            }else{
                yPad = Double(0.0 + 50.0 * Float(i))
            }
            
            let backVw = UIView(frame: CGRect(x: 0.0, y: yPad , width: (150.0 * 11) + 50.0, height: 50.0))
            backVw.backgroundColor = UIColor(red: 92.0/255.0, green: 142.0/255.0, blue: 91.0/255.0, alpha: 1.0)
            mainScrlVw.addSubview(backVw)
            
            //let bottomlineVw1 = UIView(frame: CGRect(x: 0.0, y: backVw.frame.size.height - 5.0, width: (150.0 * 11) + 50.0, height: 1.0))
            //bottomlineVw1.backgroundColor = UIColor.darkGray
            //backVw.addSubview(bottomlineVw1)
            
            let ticBtn1 = UIButton(frame: CGRect(x: 10.0, y: 15.0, width: 20.0, height: 20.0))
            ticBtn1.layer.cornerRadius = 5.0
            ticBtn1.layer.borderWidth = 1.0
            ticBtn1.layer.borderColor = UIColor.darkGray.cgColor
            ticBtn1.backgroundColor = UIColor.white
            //ticBtn.addTarget(self, action: #selector(self.headerTicBtnAction(_:)), for: .touchUpInside)
            backVw.addSubview(ticBtn1)
            
            for j in 0..<topContentArray.count {
                
                var xPad = 50.0
                if(j == 0){
                    xPad = Double(50.0 + 150.0 * Float(j))
                }else{
                    xPad = Double(25.0 + 150.0 * Float(j))
                }
                
                let headerLbl1 = UILabel(frame: CGRect(x: xPad , y: 10.0, width: 120.0, height: 30.0))
                //headerLbl1.text = String(describing: topContentArray[j])
                headerLbl1.layer.cornerRadius = 5
                headerLbl1.layer.borderWidth = 1
                headerLbl1.layer.borderColor = UIColor.darkGray.cgColor
                headerLbl1.clipsToBounds = true
                headerLbl1.backgroundColor = UIColor.white
                headerLbl1.font = UIFont.systemFont(ofSize: 12.0)
                headerLbl1.textAlignment = NSTextAlignment.center
                backVw.addSubview(headerLbl1)
                
                
            }
            
            
        }
        
    }

}
