//
//  VerificationViewController.swift
//  AFBN
//
//  Created by Erudition Informatics on 24/04/19.
//  Copyright © 2019 Erudition Informatics. All rights reserved.
//

import UIKit

class VerificationViewController: UIViewController {
    
    @IBOutlet weak var topTxtLbl: UILabel!
    @IBOutlet weak var codeTxtField: UITextField!
    
    

    //MARK: View Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        
        self.codeTxtField.layer.cornerRadius = 8.0
        self.codeTxtField.layer.borderWidth = 1.0
        self.codeTxtField.layer.borderColor = UIColor.darkGray.cgColor
        
        self.topTxtLbl.text = "Please enter the verification code \nthat we have sent you on your email"
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
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let changePassController = storyBoard.instantiateViewController(withIdentifier: "ChangePasswordViewController") as! ChangePasswordViewController
        //self.present(singInController, animated: true, completion: nil)
        self.navigationController?.pushViewController(changePassController, animated: true)
        
    }
    

}
