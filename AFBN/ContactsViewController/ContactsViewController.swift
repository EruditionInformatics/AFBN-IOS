//
//  ContactsViewController.swift
//  AFBN
//
//  Created by Erudition Informatics on 26/04/19.
//  Copyright © 2019 Erudition Informatics. All rights reserved.
//

import UIKit

class ContactsButtonTableViewCell : UITableViewCell {
    @IBOutlet weak var previousBtn: UIButton!
    @IBOutlet weak var nextBtn: UIButton!
}

class ContactsTableViewCell : UITableViewCell {
    @IBOutlet weak var textFld: UITextField!
}

class ContactsViewController: UIViewController {
    
    @IBOutlet weak var contactsTableVw: UITableView!

    @IBOutlet weak var buttonImgVw: UIImageView!
    
    @IBOutlet weak var termsBtn: UIButton!
    @IBOutlet weak var contactsBtn: UIButton!
    @IBOutlet weak var companyInfoBtn: UIButton!
    @IBOutlet weak var referenceBtn: UIButton!
    
    @IBOutlet weak var buttonVw: UIView!
    var activeField: UITextField?
    var fieldArr = [[String:Any]]()
    
    //MARK: View Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        
        setFieldValue()
        registerForKeyboardNotifications()
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    //MARK:Set Value Dictionary
    func setFieldValue(){
        let dict = [
            "name" : "",
            "position" : "",
            "mobile" : "",
            "email" : "",
            "emergency_no" : "",
            "skype_id" : ""
        ]
        for _ in 1...2{
            self.fieldArr.append(dict)
        }
        let dict1 = [
            "user_name" : "",
            "password" : ""
        ]
        self.fieldArr.append(dict1)
        
        print("field Array:",self.fieldArr.count,self.fieldArr)
    }
    
    func updateDictValue(indexPath:NSIndexPath ,valueStr:String){
        
        //var dict = self.fieldArr[indexPath.section]
        if(indexPath.row == 0){
            self.fieldArr[indexPath.section]["name"] = valueStr
        }else if(indexPath.row == 1){
            self.fieldArr[indexPath.section]["position"] = valueStr
        }else if(indexPath.row == 2){
            self.fieldArr[indexPath.section]["email"] = valueStr
        }else if(indexPath.row == 3){
            self.fieldArr[indexPath.section]["mobile"] = valueStr
        }else if(indexPath.row == 4){
            self.fieldArr[indexPath.section]["emergency_no"] = valueStr
        }else {
            self.fieldArr[indexPath.section]["skype_id"] = valueStr
        }
        
        print("field Array from update:",self.fieldArr.count,self.fieldArr)
    }
    
    func updatePreferedDictValue(indexPath:NSIndexPath ,valueStr:String){
        
        //var dict = self.fieldArr[indexPath.section]
        if(indexPath.row == 0){
            self.fieldArr[indexPath.section]["user_name"] = valueStr
        }else if(indexPath.row == 1){
            self.fieldArr[indexPath.section]["password"] = valueStr
        }
        
        print("field Array from update:",self.fieldArr.count,self.fieldArr)
    }
    
    //MARK: Button Action
    @objc func nextbuttonAction(_ sender: UIButton){
        print("nextbuttonAction\(sender)")
        CommonClass.commonSharedInstance.contactDict = ["contactInfo" : self.fieldArr]
        buttonImgVw.image = UIImage(named: "companyInfo_selected")
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let companyInfoController = storyBoard.instantiateViewController(withIdentifier: "CompanyInfoViewController") as! CompanyInfoViewController
        //self.present(singInController, animated: true, completion: nil)
        self.navigationController?.pushViewController(companyInfoController, animated: false)
    }
    @objc func previousbuttonAction(_ sender: UIButton){
        print("previousbuttonAction\(sender)")
        buttonImgVw.image = UIImage(named: "terms_selected")
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let termsController = storyBoard.instantiateViewController(withIdentifier: "TermsViewController") as! TermsViewController
        //self.present(singInController, animated: true, completion: nil)
        self.navigationController?.pushViewController(termsController, animated: false)
    }
    
    @IBAction func termsBtnAction(_ sender: UIButton) {
        buttonImgVw.image = UIImage(named: "terms_selected")
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let termsController = storyBoard.instantiateViewController(withIdentifier: "TermsViewController") as! TermsViewController
        //self.present(singInController, animated: true, completion: nil)
        self.navigationController?.pushViewController(termsController, animated: false)
        
    }
    @IBAction func contactsBtnAction(_ sender: UIButton) {
        buttonImgVw.image = UIImage(named: "contact_selected")
    }
    @IBAction func companyInfoBtnAction(_ sender: UIButton) {
        CommonClass.commonSharedInstance.contactDict = ["contactInfo" : self.fieldArr]
        buttonImgVw.image = UIImage(named: "companyInfo_selected")
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let companyInfoController = storyBoard.instantiateViewController(withIdentifier: "CompanyInfoViewController") as! CompanyInfoViewController
        //self.present(singInController, animated: true, completion: nil)
        self.navigationController?.pushViewController(companyInfoController, animated: false)
    }
    @IBAction func referenceBtnAction(_ sender: UIButton) {
        buttonImgVw.image = UIImage(named: "reference_selected")
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let referenceController = storyBoard.instantiateViewController(withIdentifier: "ReferenceViewController") as! ReferenceViewController
        //self.present(singInController, animated: true, completion: nil)
        self.navigationController?.pushViewController(referenceController, animated: false)
        
    }

}

extension ContactsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if(section == 0){
            
            return 6
            
        }else if(section == 1){
            
           return 6
            
        }else if(section == 2){
            
            return 2
            
        }else{
            
            return 1
            
        }
        
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        
        
        if(section == 0) {
            
            let rect = CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 44)
            let footerView = UIView(frame:rect)
            footerView.backgroundColor = UIColor.clear
            
            let rect1 = CGRect(x: 0, y: 24.0, width: tableView.frame.size.width, height: 20.0)
            let label: UILabel = UILabel(frame:rect1)
            label.textAlignment = NSTextAlignment.left
            
            label.text = "Key Contact Information"
            
            footerView.addSubview(label)
            
            return footerView
            
        }else if(section == 1) {
            
            let rect = CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 100)
            let footerView = UIView(frame:rect)
            footerView.backgroundColor = UIColor.clear
            
            let rect1 = CGRect(x: 0, y: 40.0, width: tableView.frame.size.width, height: 1.0)
            let lineView = UIView(frame:rect1)
            lineView.backgroundColor = UIColor.darkGray
            footerView.addSubview(lineView)
            
            let rect2 = CGRect(x: 0, y: 80.0, width: tableView.frame.size.width, height: 20.0)
            let label: UILabel = UILabel(frame:rect2)
            label.textAlignment = NSTextAlignment.left
            
            label.text = "Secondary Key Contact Information"
            
            footerView.addSubview(label)
            
            return footerView
            
        } else if(section == 2){
            
            let rect = CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 100)
            let footerView = UIView(frame:rect)
            footerView.backgroundColor = UIColor.clear
            
            let rect1 = CGRect(x: 0, y: 40.0, width: tableView.frame.size.width, height: 1.0)
            let lineView = UIView(frame:rect1)
            lineView.backgroundColor = UIColor.darkGray
            footerView.addSubview(lineView)
            
            let rect2 = CGRect(x: 0, y: 80.0, width: tableView.frame.size.width, height: 20.0)
            let label: UILabel = UILabel(frame:rect2)
            label.textAlignment = NSTextAlignment.left
            
            label.text = "Prefered Username"
            
            footerView.addSubview(label)
            
            return footerView
            
        }else{
            
            let rect = CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 10)
            let footerView = UIView(frame:rect)
            footerView.backgroundColor = UIColor.clear
            
            return footerView
            
        }
        
        
        
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        if(section == 0) {
            
            return 44
            
        }else if(section == 3) {
            
            return 10
            
        }else {
            
            return 100
            
        }
        
    }
    
    /*func tableView(_tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        if(section == 0) {
            
            return "Key Contact Information"
            
        }else if(section == 1) {
            
            return "Secondary Key Contact Information"
            
        } else {
            
            return "Preferd Username"
            
        }
        
    }*/
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if(indexPath.section == 3){
            return 100.0
        }else{
            return 70.0
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //contactsViewCell.textFld.delegate = (self as! UITextFieldDelegate)
        
        if(indexPath.section == 0 || indexPath.section == 1){
            
            let contactsViewCell:ContactsTableViewCell = tableView.dequeueReusableCell(withIdentifier: "ContactsTableViewCell", for: indexPath) as! ContactsTableViewCell
            
            if(indexPath.row == 0){
                contactsViewCell.textFld.attributedPlaceholder = NSAttributedString(string: "Name",attributes:[NSAttributedString.Key.foregroundColor:UIColor.black])
                //contactsViewCell.textFld.placeholder = "Name"
            }else if(indexPath.row == 1){
                contactsViewCell.textFld.attributedPlaceholder = NSAttributedString(string: "Position",attributes:[NSAttributedString.Key.foregroundColor:UIColor.black])
                //contactsViewCell.textFld.placeholder = "Position"
            }else if(indexPath.row == 2){
                contactsViewCell.textFld.attributedPlaceholder = NSAttributedString(string: "Email",attributes:[NSAttributedString.Key.foregroundColor:UIColor.black])
                //contactsViewCell.textFld.placeholder = "Email"
            }else if(indexPath.row == 3){
                contactsViewCell.textFld.attributedPlaceholder = NSAttributedString(string: "Mobile No.",attributes:[NSAttributedString.Key.foregroundColor:UIColor.black])
                //contactsViewCell.textFld.placeholder = "Mobile No."
            }else if(indexPath.row == 4){
                contactsViewCell.textFld.attributedPlaceholder = NSAttributedString(string: "Emergency Number",attributes:[NSAttributedString.Key.foregroundColor:UIColor.black])
                //contactsViewCell.textFld.placeholder = "Emergency Number"
            }else{
                contactsViewCell.textFld.attributedPlaceholder = NSAttributedString(string: "Skype ID",attributes:[NSAttributedString.Key.foregroundColor:UIColor.black])
                //contactsViewCell.textFld.placeholder = "Skype ID"
            }
            
            if(indexPath.section == 0){
                contactsViewCell.textFld.tag = 100 + indexPath.row + 1
            }else{
                contactsViewCell.textFld.tag = 200 + indexPath.row + 1
            }
            
            
            let dict = self.fieldArr[indexPath.section]
            if(indexPath.row == 0){
                contactsViewCell.textFld.text = dict["name"] as? String
            }else if(indexPath.row == 1){
                contactsViewCell.textFld.text = dict["position"] as? String
            }else if(indexPath.row == 2){
                contactsViewCell.textFld.text = dict["email"] as? String
            }else if(indexPath.row == 3){
                contactsViewCell.textFld.text = dict["mobile"] as? String
            }else if(indexPath.row == 4){
                contactsViewCell.textFld.text = dict["emergency_no"] as? String
            }else {
                contactsViewCell.textFld.text = dict["skype_id"] as? String
            }
            
             return contactsViewCell
            
        }else if (indexPath.section == 2){
            
            if(indexPath.row == 0){
                
                let contactsViewCell:ContactsTableViewCell = tableView.dequeueReusableCell(withIdentifier: "ContactsTableViewCell", for: indexPath) as! ContactsTableViewCell
                
                contactsViewCell.textFld.attributedPlaceholder = NSAttributedString(string: "User Name",attributes:[NSAttributedString.Key.foregroundColor:UIColor.black])
                //contactsViewCell.textFld.placeholder = "User name"
                contactsViewCell.textFld.tag = 300 + indexPath.row + 1
                
                let dict = self.fieldArr[indexPath.section]
                contactsViewCell.textFld.text = dict["user_name"] as? String
                
                return contactsViewCell
            }else{
                
                let contactsViewCell:ContactsTableViewCell = tableView.dequeueReusableCell(withIdentifier: "ContactsTableViewCell", for: indexPath) as! ContactsTableViewCell
                
                contactsViewCell.textFld.attributedPlaceholder = NSAttributedString(string: "Password",attributes:[NSAttributedString.Key.foregroundColor:UIColor.black])
                //contactsViewCell.textFld.placeholder = "Password"
                contactsViewCell.textFld.tag = 300 + indexPath.row + 1
                let dict = self.fieldArr[indexPath.section]
                contactsViewCell.textFld.text = dict["password"] as? String
                
                return contactsViewCell
                
            }
            
        }
        else{
            
                let contactsBtnViewCell:ContactsButtonTableViewCell = tableView.dequeueReusableCell(withIdentifier: "ContactsButtonTableViewCell", for: indexPath) as! ContactsButtonTableViewCell
                
                contactsBtnViewCell.nextBtn.addTarget(self, action: #selector(self.nextbuttonAction(_:)), for: .touchUpInside)
                contactsBtnViewCell.previousBtn.addTarget(self, action: #selector(self.previousbuttonAction(_:)), for: .touchUpInside)
            contactsBtnViewCell.nextBtn.layer.cornerRadius = 5.0
            contactsBtnViewCell.previousBtn.layer.cornerRadius = 5.0
                contactsBtnViewCell.backgroundColor = UIColor.white
                return contactsBtnViewCell
                
            
        }
        
    }
    
    
    
    
    
}

extension ContactsViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.activeField = textField
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        let pointInTable = textField.convert(textField.bounds.origin, to: self.contactsTableVw)
        let textFieldIndexPath = self.contactsTableVw.indexPathForRow(at: pointInTable)
        
        
        
        if(textFieldIndexPath?.section == 0){
            updateDictValue(indexPath: textFieldIndexPath! as NSIndexPath, valueStr: textField.text!)
            let index =  100 + (textFieldIndexPath?.row)! + 1
            self.activeField = view.viewWithTag(index + 1) as? UITextField
            
        }else if(textFieldIndexPath?.section == 1){
            updateDictValue(indexPath: textFieldIndexPath! as NSIndexPath, valueStr: textField.text!)
            let index =  200 + (textFieldIndexPath?.row)! + 1
            self.activeField = view.viewWithTag(index + 1) as? UITextField
            
        }else {
            updatePreferedDictValue(indexPath: textFieldIndexPath! as NSIndexPath, valueStr: textField.text!)
            let index =  300 + (textFieldIndexPath?.row)! + 1
            self.activeField = view.viewWithTag(index + 1) as? UITextField
            
        }
        
        self.activeField?.becomeFirstResponder()
        
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
        NotificationCenter.default.addObserver(self, selector: #selector(ContactsViewController.keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(ContactsViewController.keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        
        
    }
    
    @objc func keyboardWillShow(_ notification:Notification) {
        
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            contactsTableVw.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height + 15.0, right: 0)
        }}
    
    
    @objc func keyboardWillHide(_ notification:Notification) {
        
        if ((notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue) != nil {
            contactsTableVw.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        }
        
    }
    
}
