//
//  ChangePasswordViewController.swift
//  AFBN
//
//  Created by Erudition Informatics on 24/04/19.
//  Copyright © 2019 Erudition Informatics. All rights reserved.
//

import UIKit

class ChangePasswordViewController: UIViewController {

    @IBOutlet weak var newPassField: UITextField!
    @IBOutlet weak var repeatNewPassField: UITextField!
    
    
    // MARK: View Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.newPassField.layer.cornerRadius = 8.0
        self.newPassField.layer.borderWidth = 1.0
        self.newPassField.layer.borderColor = UIColor.darkGray.cgColor
        
        self.repeatNewPassField.layer.cornerRadius = 8.0
        self.repeatNewPassField.layer.borderWidth = 1.0
        self.repeatNewPassField.layer.borderColor = UIColor.darkGray.cgColor
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    // MARK: Button Action
    @IBAction func applyBtnAction(_ sender: UIButton) {
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let tabBarController = storyBoard.instantiateViewController(withIdentifier: "TabBarViewController") as! TabBarViewController
        //self.present(singInController, animated: true, completion: nil)
        self.navigationController?.pushViewController(tabBarController, animated: true)
        
    }
    

}
