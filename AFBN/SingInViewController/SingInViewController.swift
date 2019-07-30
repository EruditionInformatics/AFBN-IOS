//
//  SingInViewController.swift
//  AFBN
//
//  Created by Erudition Informatics on 24/04/19.
//  Copyright © 2019 Erudition Informatics. All rights reserved.
//

import UIKit
import CoreData

class SingInViewController: UIViewController ,urlrequestprotocol,UIScrollViewDelegate{
    
    

    @IBOutlet weak var emailTxtField: UITextField!
    @IBOutlet weak var passwordTxtField: UITextField!
    @IBOutlet weak var backScrollVw: UIScrollView!
    
    
    //Mark: View Cycle Method
    override func viewDidLoad() {
        super.viewDidLoad()
        registerForKeyboardNotifications()
        // Do any additional setup after loading the view.
        //self.setHeaderLabelText(headerTxt: "Sing in")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        //self.backScrollVw.contentSize = CGSize(width: 0.0, height: self.backScrollVw.frame.size.height + 50.0)
        self.backScrollVw.contentInset = UIEdgeInsets(top: 0, left: 0, bottom:100.0, right: 0)
        
        self.emailTxtField.layer.cornerRadius = 8.0
        self.emailTxtField.layer.borderWidth = 1.0
        self.emailTxtField.layer.borderColor = UIColor.darkGray.cgColor
        
        self.passwordTxtField.layer.cornerRadius = 8.0
        self.passwordTxtField.layer.borderWidth = 1.0
        self.passwordTxtField.layer.borderColor = UIColor.darkGray.cgColor
        
        
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    //Mark: View Button Action
    @IBAction func forgotPasswordBtnAction(_ sender: UIButton) {
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let forgotController = storyBoard.instantiateViewController(withIdentifier: "ForgotPasswordViewController") as! ForgotPasswordViewController
        //self.present(singInController, animated: true, completion: nil)
        self.navigationController?.pushViewController(forgotController, animated: true)
        
    }
    @IBAction func nextBtnAction(_ sender: UIButton) {
        
        if(self.emailTxtField.text!.count > 0){
            if(self.passwordTxtField.text!.count > 0){
                callApiForLogin()
            }else{
                CommonClass.commonSharedInstance.show_alert(alert_title: "AFBN", btn_title: "Ok", msg: "Please enter your Password.", presentingClass: self)
            }
        }else{
            CommonClass.commonSharedInstance.show_alert(alert_title: "AFBN", btn_title: "Ok", msg: "Please enter your Email ID.", presentingClass: self)
        }
        
        
    }
    //MARK: -Api call for login
    func callApiForLogin(){
        
        CommonClass.commonSharedInstance.showSpinner(onView: self.view)
        UrlRequestClass.UrlRequestSharedInstance.urlrequestDelegate = self
        UrlRequestClass.UrlRequestSharedInstance.getSingin(email: emailTxtField.text!, password: passwordTxtField.text!, viewcontroller_class: self,tag:"1")
        
    }

    //MARK: - Urlrequest Delegates method
    func urlrequestfinish_with_success(data: NSDictionary, requestType: String, request_class: UIViewController,tag:String) {
        
        print("data",data)
        let statusCode = data["code"] as! String
        
        if(statusCode == "0"){
            
            let valueArr = data["message"] as! NSArray
            let valueDict:NSDictionary = valueArr[0] as! NSDictionary
            print("valueDict::-",valueDict)
            
            DispatchQueue.main.async{
                
                self.saveDatabase(user_data:valueDict)
                CommonClass.commonSharedInstance.removeSpinner()
                UserDefaults.standard.set(valueDict["reg_key"] as! String, forKey: "user_key")
                //UserDefaults.standard.set(valueDict["user_name"] as! String, forKey: "user_name")
                UserDefaults.standard.set(true, forKey: "user_login")
                self.perform(#selector(self.pushToNextView), with: nil, afterDelay: 0.5)
                
                
            }
        }else{
            DispatchQueue.main.async{
                CommonClass.commonSharedInstance.removeSpinner()
                CommonClass.commonSharedInstance.show_alert(alert_title: "AFBN", btn_title: "Ok", msg: "Your Email ID or Password was wrong.", presentingClass: self)
            }
        }
        
        
        
    }
    
    func urlrequestfinish_with_error(error: Error) {
        print("error",error)
    }
    
    
    //MARK: -Coredata Methods
    func saveDatabase(user_data:NSDictionary){
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        // 1
        let managedContext =
            appDelegate.persistentContainer.viewContext
        
        // 2
        let entity =
            NSEntityDescription.entity(forEntityName: "Users",
                                       in: managedContext)!
        
        let user_detail = NSManagedObject(entity: entity,
                                          insertInto: managedContext)
        
        // 3
        user_detail.setValue(user_data, forKeyPath: "singin_details")
        
        // 4
        do {
            
            try managedContext.save()
            
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    func getUserDetailFromDatabase() -> NSMutableArray{
        
        let saved_userArray:NSMutableArray = []
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        
        // 1
        let managedContext =
            appDelegate?.persistentContainer.viewContext
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Users")
        //request.predicate = NSPredicate(format: "age = %@", "12")
        request.returnsObjectsAsFaults = false
        do {
            
            let result = try managedContext!.fetch(request)
            
            for data in result as! [NSManagedObject] {
                print("getUserDetailFromDatabase singin_details::",data.value(forKey: "singin_details") as! NSDictionary)
                let user_data = data.value(forKey: "singin_details") as! NSDictionary
                saved_userArray.add(user_data)
                //return saved_userArray
                
            }
            
        } catch {
            
            print("Failed")
        }
        
        return saved_userArray
    }
    
    //MARK: Perform selector method
    @objc func pushToNextView(dict: NSDictionary){
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let tabBarController = storyBoard.instantiateViewController(withIdentifier: "TabBarViewController") as! TabBarViewController
        //self.present(singInController, animated: true, completion: nil)
        self.navigationController?.pushViewController(tabBarController, animated: true)
        
    }
    
}

extension SingInViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        //self.activeField = textField
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        
    }
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        
        return true;
    }
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        return true;
    }
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        return true;
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return true;
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder();
        return true;
    }
    
    
    
    func registerForKeyboardNotifications() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(SingInViewController.keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(SingInViewController.keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        
        
    }
    
    @objc func keyboardWillShow(_ notification:Notification) {
        
        self.backScrollVw.contentOffset = CGPoint(x: 0.0, y: 50.0)
        /*if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
         //self.backScrollVw.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height + 25.0, right: 0)
         self.backScrollVw.contentOffset = CGPoint(x: 0.0, y: keyboardSize.height)
         }*/
        
    }
    
    
    @objc func keyboardWillHide(_ notification:Notification) {
        
        if ((notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue) != nil {
            //self.backScrollVw.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            self.backScrollVw.contentOffset = CGPoint(x: 0.0, y: 0.0)
        }
        
    }
    
}
