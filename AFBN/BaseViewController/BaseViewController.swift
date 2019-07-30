//
//  BaseViewController.swift
//  AFBN
//
//  Created by Erudition Informatics on 24/04/19.
//  Copyright © 2019 Erudition Informatics. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    @IBOutlet weak var topBarView: UIView!
    @IBOutlet weak var headerLbl: UILabel?
    

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
//        if(Constant.constant.isLogedIn == false){
//            goToSplashPage()
//        }
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    func goToSplashPage(){
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let splashController = storyBoard.instantiateViewController(withIdentifier: "FirstSplashController") as! FirstSplashController
        //self.present(singInController, animated: true, completion: nil)
        self.navigationController?.pushViewController(splashController, animated: false)
        
    }
    
    //MARK: Set Header Label Text
    func setHeaderLabelText(headerTxt: String){
        
        self.headerLbl?.text = headerTxt
        
    }

}
