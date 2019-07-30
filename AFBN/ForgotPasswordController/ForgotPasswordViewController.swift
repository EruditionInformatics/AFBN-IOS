//
//  ForgotPasswordViewController.swift
//  AFBN
//
//  Created by Erudition Informatics on 24/04/19.
//  Copyright © 2019 Erudition Informatics. All rights reserved.
//

import UIKit

class ForgotPasswordViewController: UIViewController,customAlertProtocol {
    
    @IBOutlet weak var topTxtLbl: UILabel!
    @IBOutlet weak var emailTxtField: UITextField!
    
    //var alertVw: CustomAlertView!
    
    //MARK: View Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.emailTxtField.layer.cornerRadius = 8.0
        self.emailTxtField.layer.borderWidth = 1.0
        self.emailTxtField.layer.borderColor = UIColor.darkGray.cgColor
        
        self.topTxtLbl.text = "Please enter your email and we will send you \naverification code so you can \nchange your password"
    }
    
    //MARK:Method for custom alert
    func showalertfor_SendVerificationCode(){
        
        let alertVw:CustomAlertView = Bundle.main.loadNibNamed("CustomAlertView", owner: self, options: nil)?.first as! CustomAlertView
        alertVw.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        alertVw.alertDelegate = self 
        self.view.addSubview(alertVw)
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    //MARK: Button Action
    @IBAction func nextBtnAction(_ sender: UIButton) {
        
        showalertfor_SendVerificationCode()
        
        
    }
    
    //MARK: Custom Alert Method
    func moveTo_verifyController(){
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let verifyController = storyBoard.instantiateViewController(withIdentifier: "VerificationViewController") as! VerificationViewController
        //self.present(singInController, animated: true, completion: nil)
        self.navigationController?.pushViewController(verifyController, animated: true)
        
    }
    
}
