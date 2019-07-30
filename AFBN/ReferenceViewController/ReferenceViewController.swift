//
//  ReferenceViewController.swift
//  AFBN
//
//  Created by Erudition Informatics on 26/04/19.
//  Copyright © 2019 Erudition Informatics. All rights reserved.
//

import UIKit

class referenceButtonTableViewCell : UITableViewCell {
    @IBOutlet weak var previousBtn: UIButton!
    @IBOutlet weak var nextBtn: UIButton!
}

class referenceTableViewCell : UITableViewCell {
    @IBOutlet weak var textFld: UITextField!
}

class ReferenceViewController: UIViewController,urlrequestprotocol {

    
    let alertTxt = "We Received your order and after\nverification of your data, we will send you\nan email with username and password in a few days."
    
    @IBOutlet weak var referenceTableVw: UITableView!
    
    @IBOutlet weak var buttonImgVw: UIImageView!
    
    @IBOutlet weak var termsBtn: UIButton!
    @IBOutlet weak var contactsBtn: UIButton!
    @IBOutlet weak var companyInfoBtn: UIButton!
    @IBOutlet weak var referenceBtn: UIButton!
    
    @IBOutlet weak var buttonVw: UIView!
    var activeField: UITextField?
    var fieldArr = [[String:Any]]()
    var file_path:String!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        setFieldValue()
        registerForKeyboardNotifications()
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
            "company_name" : "",
            "business_type" : "",
            "contact" : "",
            "position" : "",
            "country" : "",
            "city" : "",
            "mobile" : "",
            "phone" : "",
            "fax" : "",
            "email" : "",
            "emergency_no" : ""
        ]
        for _ in 1...6{
            self.fieldArr.append(dict)
        }
        print("field Array:",self.fieldArr.count,self.fieldArr)
    }
    
    func updateDictValue(indexPath:NSIndexPath ,valueStr:String){
        
        //var dict = self.fieldArr[indexPath.section]
        if(indexPath.row == 0){
            self.fieldArr[indexPath.section]["company_name"] = valueStr
        }else if(indexPath.row == 1){
            self.fieldArr[indexPath.section]["business_type"] = valueStr
        }else if(indexPath.row == 2){
            self.fieldArr[indexPath.section]["contact"] = valueStr
        }else if(indexPath.row == 3){
            self.fieldArr[indexPath.section]["position"] = valueStr
        }else if(indexPath.row == 4){
             self.fieldArr[indexPath.section]["country"] = valueStr
        }else if(indexPath.row == 5){
             self.fieldArr[indexPath.section]["city"] = valueStr
        }else if(indexPath.row == 6){
             self.fieldArr[indexPath.section]["mobile"] = valueStr
        }else if(indexPath.row == 7){
             self.fieldArr[indexPath.section]["phone"] = valueStr
        }else if(indexPath.row == 8){
             self.fieldArr[indexPath.section]["fax"] = valueStr
        }else if(indexPath.row == 9){
             self.fieldArr[indexPath.section]["email"] = valueStr
        }else {
             self.fieldArr[indexPath.section]["emergency_no"] = valueStr
        }
        
        //self.fieldArr.insert(dict, at: indexPath.section)
        print("field Array from update:",self.fieldArr.count,self.fieldArr)
        //self.referenceTableVw.reloadData()
    }
    
    //MARK:Method for custom alert
    func showalertfor_Thanking(){
        
        let alertVw:CustomThanksView = Bundle.main.loadNibNamed("CustomThanksView", owner: self, options: nil)?.first as! CustomThanksView
        alertVw.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        alertVw.setTxt(txt: alertTxt)
        self.view.addSubview(alertVw)
        
    }
    //MARK: - Validation Check for API call
    func setValidation_contactInfo(){
        
        let dict = CommonClass.commonSharedInstance.contactDict
        
        if((dict .value(forKey: "contactInfo")) != nil){
            
            let arr = dict["contactInfo"] as! NSArray
            for i in 0...arr.count - 1{
                if(i != 2){
                    
                    let dict = arr[i] as! NSDictionary
                    
                    let stremail = ((dict .value(forKey: "email")) as! String)
                    if(stremail.count > 0){
                        print(stremail)
                        let skype_id = ((dict .value(forKey: "skype_id")) as! String)
                        if(skype_id.count > 0){
                            print(skype_id)
                            let position = ((dict .value(forKey: "position")) as! String)
                            if(position.count > 0){
                                print(position)
                                let emergency_no = ((dict .value(forKey: "emergency_no")) as! String)
                                if(emergency_no.count > 0){
                                    print(emergency_no)
                                    let mobile = ((dict .value(forKey: "mobile")) as! String)
                                    if(mobile.count > 0){
                                        print(mobile)
                                        let name = ((dict .value(forKey: "name")) as! String)
                                        if(name.count > 0){
                                            print(name)
                                            
                                            if(i == 1){
                                                break
                                            }
                                            
                                        }else{
                                            CommonClass.commonSharedInstance.show_alert(alert_title: "AFBN", btn_title: "Ok", msg: "Please enter your name", presentingClass: self)
                                        }
                                    }else{
                                        CommonClass.commonSharedInstance.show_alert(alert_title: "AFBN", btn_title: "Ok", msg: "Please enter your mobile", presentingClass: self)
                                    }
                                }else{
                                    CommonClass.commonSharedInstance.show_alert(alert_title: "AFBN", btn_title: "Ok", msg: "Please enter your emergency no", presentingClass: self)
                                }
                            }else{
                                CommonClass.commonSharedInstance.show_alert(alert_title: "AFBN", btn_title: "Ok", msg: "Please enter your position", presentingClass: self)
                            }
                        }else{
                            CommonClass.commonSharedInstance.show_alert(alert_title: "AFBN", btn_title: "Ok", msg: "Please enter your skype id", presentingClass: self)
                        }
                    }else{
                        CommonClass.commonSharedInstance.show_alert(alert_title: "AFBN", btn_title: "Ok", msg: "Please enter your email", presentingClass: self)
                    }
                    
                }else{
                    
                    let user_name = ((dict .value(forKey: "user_name")) as! String)
                    if(user_name.count > 0){
                        print(user_name)
                        let password = ((dict .value(forKey: "password")) as! String)
                        if(password.count > 0){
                            print(password)
                            setValidation_companyInfo()
                        }else{
                            CommonClass.commonSharedInstance.show_alert(alert_title: "AFBN", btn_title: "Ok", msg: "Please enter your Password", presentingClass: self)
                        }
                    }else{
                        CommonClass.commonSharedInstance.show_alert(alert_title: "AFBN", btn_title: "Ok", msg: "Please enter your User Name", presentingClass: self)
                    }
                    
                }
                
            }
        }else{
            CommonClass.commonSharedInstance.show_alert(alert_title: "AFBN", btn_title: "Ok", msg: "Please enter your contact details", presentingClass: self)
        }
        
    }
    
    func setValidation_companyInfo(){
        
        let dict = CommonClass.commonSharedInstance.companyInfoDict
        
        if((dict .value(forKey: "companyInfo")) != nil){
            
            if((dict .value(forKey: "contactInfo")) != nil){
                
                let arr = dict["contactInfo"] as! NSArray
                for i in 0...arr.count - 1{
                    
                    if(i == 0){
                        
                        let dict = arr[i] as! NSDictionary
                        let year_east = ((dict .value(forKey: "year_east")) as! String)
                        if(year_east.count > 0){
                            let branch_address = ((dict .value(forKey: "branch_address")) as! String)
                            if(branch_address.count > 0){
                                let website = ((dict .value(forKey: "website")) as! String)
                                if(website.count > 0){
                                    let staff_amount = ((dict .value(forKey: "staff_amount")) as! String)
                                    if(staff_amount.count > 0){
                                        let company_name = ((dict .value(forKey: "company_name")) as! String)
                                        if(company_name.count > 0){
                                            let anual_sales = ((dict .value(forKey: "anual_sales")) as! String)
                                            if(anual_sales != "Please state your annual sales volumn for your firm in the US"){
                                                let fax_no = ((dict .value(forKey: "fax_no")) as! String)
                                                if(fax_no.count > 0){
                                                    let location_amount = ((dict .value(forKey: "location_amount")) as! String)
                                                    if(location_amount.count > 0){
                                                        let anual_tonnage = ((dict .value(forKey: "anual_tonnage")) as! String)
                                                        if(anual_tonnage != "Please advice us of you annual tonnage for air and ocean freight"){
                                                            let tell_no = ((dict .value(forKey: "tell_no")) as! String)
                                                            if(tell_no.count > 0){
                                                                let company_summary = ((dict .value(forKey: "company_summary")) as! String)
                                                                if(company_summary != "Summary about the company"){
                                                                    let emergency_no = ((dict .value(forKey: "emergency_no")) as! String)
                                                                    if(emergency_no.count > 0){
                                                                        let branch_location = ((dict .value(forKey: "branch_location")) as! String)
                                                                        if(branch_location.count > 0){
                                                                            let branch_amount = ((dict .value(forKey: "branch_amount")) as! String)
                                                                            if(branch_amount.count > 0){
                                                                                break
                                                                            }else{
                                                                                CommonClass.commonSharedInstance.show_alert(alert_title: "AFBN", btn_title: "Ok", msg: "Please enter your company branch amount", presentingClass: self)
                                                                            }
                                                                        }else{
                                                                            CommonClass.commonSharedInstance.show_alert(alert_title: "AFBN", btn_title: "Ok", msg: "Please enter your company branch location", presentingClass: self)
                                                                        }
                                                                    }else{
                                                                        CommonClass.commonSharedInstance.show_alert(alert_title: "AFBN", btn_title: "Ok", msg: "Please enter your company emergency number", presentingClass: self)
                                                                    }
                                                                }else{
                                                                    CommonClass.commonSharedInstance.show_alert(alert_title: "AFBN", btn_title: "Ok", msg: "Please enter your company summary", presentingClass: self)
                                                                }
                                                            }else{
                                                                CommonClass.commonSharedInstance.show_alert(alert_title: "AFBN", btn_title: "Ok", msg: "Please enter your company tellphone number", presentingClass: self)
                                                            }
                                                        }else{
                                                            CommonClass.commonSharedInstance.show_alert(alert_title: "AFBN", btn_title: "Ok", msg: "Please enter your company anual tonnage", presentingClass: self)
                                                        }
                                                    }else{
                                                        CommonClass.commonSharedInstance.show_alert(alert_title: "AFBN", btn_title: "Ok", msg: "Please enter your company location amount", presentingClass: self)
                                                    }
                                                }else{
                                                    CommonClass.commonSharedInstance.show_alert(alert_title: "AFBN", btn_title: "Ok", msg: "Please enter your company fax no", presentingClass: self)
                                                }
                                            }else{
                                                CommonClass.commonSharedInstance.show_alert(alert_title: "AFBN", btn_title: "Ok", msg: "Please enter your company anual sales", presentingClass: self)
                                            }
                                        }else{
                                            CommonClass.commonSharedInstance.show_alert(alert_title: "AFBN", btn_title: "Ok", msg: "Please enter your company name", presentingClass: self)
                                        }
                                    }else{
                                        CommonClass.commonSharedInstance.show_alert(alert_title: "AFBN", btn_title: "Ok", msg: "Please enter your company staff amount", presentingClass: self)
                                    }
                                }else{
                                    CommonClass.commonSharedInstance.show_alert(alert_title: "AFBN", btn_title: "Ok", msg: "Please enter your company website", presentingClass: self)
                                }
                            }else{
                                CommonClass.commonSharedInstance.show_alert(alert_title: "AFBN", btn_title: "Ok", msg: "Please enter your company branch address", presentingClass: self)
                            }
                        }else{
                            CommonClass.commonSharedInstance.show_alert(alert_title: "AFBN", btn_title: "Ok", msg: "Please enter your company establist year", presentingClass: self)
                        }
                        
                        
                        
                    }else if(i == 1){
                        
                        let dict = arr[i] as! NSDictionary
                        let company_profile = ((dict .value(forKey: "company_profile")) as! String)
                        if(company_profile != "company_profile"){
                            break
                        }else{
                            CommonClass.commonSharedInstance.show_alert(alert_title: "AFBN", btn_title: "Ok", msg: "Please enter your company profile", presentingClass: self)
                        }
                        
                    }else if(i == 2){
                        
                        let dict = arr[i] as! NSDictionary
                        let license_no = ((dict .value(forKey: "license_no")) as! String)
                        if(license_no != "FMC Lincenced Foreign Freight Forwarder License"){
                            let meng_company = ((dict .value(forKey: "meng_company")) as! String)
                            if(meng_company.count > 0){
                                let carrier = ((dict .value(forKey: "carrier")) as! String)
                                if(carrier.count > 0){
                                    let brocker_licence_no = ((dict .value(forKey: "brocker_licence_no")) as! String)
                                    if(brocker_licence_no != "Custom House Broker - License Number"){
                                        let brocker_licence_no = ((dict .value(forKey: "brocker_licence_no")) as! String)
                                        if(brocker_licence_no != "Custom House Broker - License Number"){
                                            let iso9002_registered = ((dict .value(forKey: "iso9002_registered")) as! String)
                                            if(iso9002_registered.count > 0){
                                                let int_consultant = ((dict .value(forKey: "int_consultant")) as! String)
                                                if(int_consultant.count > 0){
                                                    let membership_cert = ((dict .value(forKey: "membership_cert")) as! String)
                                                    if(membership_cert != "Other Membership Certification"){
                                                        let sales_agents = ((dict .value(forKey: "sales_agents")) as! String)
                                                        if(sales_agents != "IATA Approved Cargo Sales Agents"){
                                                            let nvocc_no = ((dict .value(forKey: "nvocc_no")) as! String)
                                                            if(nvocc_no != "NVOCC(Non-Vessel-Operating Common Carrier) bond Number"){
                                                                let brokarage_opt = ((dict .value(forKey: "brokarage_opt")) as! String)
                                                                if(brokarage_opt != "Licensed Custom House Brokerage Operation"){
                                                                    let packing_facility = ((dict .value(forKey: "packing_facility")) as! String)
                                                                    if(packing_facility.count > 0){
                                                                        let iso9001_registered = ((dict .value(forKey: "iso9001_registered")) as! String)
                                                                        if(iso9001_registered != "ISO9001/2015 registered"){
                                                                            break
                                                                        }else{
                                                                            CommonClass.commonSharedInstance.show_alert(alert_title: "AFBN", btn_title: "Ok", msg: "Please enter your company iso9001 registered", presentingClass: self)
                                                                        }
                                                                    }else{
                                                                        CommonClass.commonSharedInstance.show_alert(alert_title: "AFBN", btn_title: "Ok", msg: "Please enter your company packing facility", presentingClass: self)
                                                                    }
                                                                }else{
                                                                    CommonClass.commonSharedInstance.show_alert(alert_title: "AFBN", btn_title: "Ok", msg: "Please enter your company Brokerage Operation", presentingClass: self)
                                                                }
                                                            }else{
                                                                CommonClass.commonSharedInstance.show_alert(alert_title: "AFBN", btn_title: "Ok", msg: "Please enter your company nvocc number", presentingClass: self)
                                                            }
                                                        }else{
                                                            CommonClass.commonSharedInstance.show_alert(alert_title: "AFBN", btn_title: "Ok", msg: "Please enter your company sales agents", presentingClass: self)
                                                        }
                                                    }else{
                                                        CommonClass.commonSharedInstance.show_alert(alert_title: "AFBN", btn_title: "Ok", msg: "Please enter your company membership certificate", presentingClass: self)
                                                    }
                                                }else{
                                                    CommonClass.commonSharedInstance.show_alert(alert_title: "AFBN", btn_title: "Ok", msg: "Please enter your company consultant", presentingClass: self)
                                                }
                                            }else{
                                                CommonClass.commonSharedInstance.show_alert(alert_title: "AFBN", btn_title: "Ok", msg: "Please enter your company iso9002 registered", presentingClass: self)
                                            }
                                        }else{
                                            CommonClass.commonSharedInstance.show_alert(alert_title: "AFBN", btn_title: "Ok", msg: "Please enter your company brocker licence number", presentingClass: self)
                                        }
                                    }else{
                                        CommonClass.commonSharedInstance.show_alert(alert_title: "AFBN", btn_title: "Ok", msg: "Please enter your company brocker licence number", presentingClass: self)
                                    }
                                }else{
                                    CommonClass.commonSharedInstance.show_alert(alert_title: "AFBN", btn_title: "Ok", msg: "Please enter your company carrier", presentingClass: self)
                                }
                            }else{
                                CommonClass.commonSharedInstance.show_alert(alert_title: "AFBN", btn_title: "Ok", msg: "Please enter your meng company", presentingClass: self)
                            }
                        }else{
                            CommonClass.commonSharedInstance.show_alert(alert_title: "AFBN", btn_title: "Ok", msg: "Please enter your company license number", presentingClass: self)
                        }
                        
                        
                    }else if(i == 3){
                        
                        let dict = arr[i] as! NSDictionary
                        let phone = ((dict .value(forKey: "phone")) as! String)
                        if(phone.count > 0){
                            let country = ((dict .value(forKey: "country")) as! String)
                            if(country.count > 0){
                                let city = ((dict .value(forKey: "city")) as! String)
                                if(city.count > 0){
                                    let pobox = ((dict .value(forKey: "p.o.box")) as! String)
                                    if(pobox.count > 0){
                                        let fax = ((dict .value(forKey: "fax")) as! String)
                                        if(fax.count > 0){
                                            let line1 = ((dict .value(forKey: "line1")) as! String)
                                            if(line1.count > 0){
                                                let line2 = ((dict .value(forKey: "line2")) as! String)
                                                if(line2.count > 0){
                                                    let line3 = ((dict .value(forKey: "line3")) as! String)
                                                    if(line3.count > 0){
                                                        break
                                                    }else{
                                                        CommonClass.commonSharedInstance.show_alert(alert_title: "AFBN", btn_title: "Ok", msg: "Please enter your company line3", presentingClass: self)
                                                    }
                                                }else{
                                                    CommonClass.commonSharedInstance.show_alert(alert_title: "AFBN", btn_title: "Ok", msg: "Please enter your company line2", presentingClass: self)
                                                }
                                            }else{
                                                CommonClass.commonSharedInstance.show_alert(alert_title: "AFBN", btn_title: "Ok", msg: "Please enter your company line1", presentingClass: self)
                                            }
                                        }else{
                                            CommonClass.commonSharedInstance.show_alert(alert_title: "AFBN", btn_title: "Ok", msg: "Please enter your company fax", presentingClass: self)
                                        }
                                    }else{
                                        CommonClass.commonSharedInstance.show_alert(alert_title: "AFBN", btn_title: "Ok", msg: "Please enter your company post box name", presentingClass: self)
                                    }
                                }else{
                                    CommonClass.commonSharedInstance.show_alert(alert_title: "AFBN", btn_title: "Ok", msg: "Please enter your company city name", presentingClass: self)
                                }
                            }else{
                                CommonClass.commonSharedInstance.show_alert(alert_title: "AFBN", btn_title: "Ok", msg: "Please enter your company country name", presentingClass: self)
                            }
                        }else{
                            CommonClass.commonSharedInstance.show_alert(alert_title: "AFBN", btn_title: "Ok", msg: "Please enter your company phone number", presentingClass: self)
                        }
                        
                    }else if(i == 4){
                        let dict = arr[i] as! NSDictionary
                        let reasons = ((dict .value(forKey: "reasons")) as! String)
                        if(reasons != "Please explain your reasons:"){
                            break
                        }else{
                            CommonClass.commonSharedInstance.show_alert(alert_title: "AFBN", btn_title: "Ok", msg: "Please explain your reasons", presentingClass: self)
                        }
                    }else if(i == 5){
                        let dict = arr[i] as! NSDictionary
                        let reasons = ((dict .value(forKey: "reasons")) as! String)
                        if(reasons != "Please explain your reasons:"){
                            setValidation_referenceInfo()
                        }else{
                            CommonClass.commonSharedInstance.show_alert(alert_title: "AFBN", btn_title: "Ok", msg: "Please explain your reasons", presentingClass: self)
                        }
                    }
                    
                }
            }
            
        }
        
    }
    
    func setValidation_referenceInfo(){
        
        let dict = CommonClass.commonSharedInstance.referenceDict
        
        if((dict .value(forKey: "referenceInfo")) != nil){
            
            let arr = dict["referenceInfo"] as! NSArray
            for i in 0...arr.count - 1{
                
                let dict = arr[i] as! NSDictionary
                let country = ((dict .value(forKey: "country")) as! String)
                if(country.count > 0){
                    let fax = ((dict .value(forKey: "fax")) as! String)
                    if(fax.count > 0){
                        let mobile = ((dict .value(forKey: "mobile")) as! String)
                        if(mobile.count > 0){
                            let city = ((dict .value(forKey: "city")) as! String)
                            if(city.count > 0){
                                let position = ((dict .value(forKey: "position")) as! String)
                                if(position.count > 0){
                                    let business_type = ((dict .value(forKey: "business_type")) as! String)
                                    if(business_type.count > 0){
                                        let phone = ((dict .value(forKey: "phone")) as! String)
                                        if(phone.count > 0){
                                            let company_name = ((dict .value(forKey: "company_name")) as! String)
                                            if(company_name.count > 0){
                                                let contact = ((dict .value(forKey: "contact")) as! String)
                                                if(contact.count > 0){
                                                    let emergency_no = ((dict .value(forKey: "emergency_no")) as! String)
                                                    if(emergency_no.count > 0){
                                                        let email = ((dict .value(forKey: "email")) as! String)
                                                        if(email.count > 0){
                                                            if(i == 5){
                                                                callApiForRegistration()
                                                            }
                                                        }else{
                                                            CommonClass.commonSharedInstance.show_alert(alert_title: "AFBN", btn_title: "Ok", msg: "Please enter your company email", presentingClass: self)
                                                        }
                                                    }else{
                                                        CommonClass.commonSharedInstance.show_alert(alert_title: "AFBN", btn_title: "Ok", msg: "Please enter your company emergency number", presentingClass: self)
                                                    }
                                                }else{
                                                    CommonClass.commonSharedInstance.show_alert(alert_title: "AFBN", btn_title: "Ok", msg: "Please enter your company contact", presentingClass: self)
                                                }
                                            }else{
                                                CommonClass.commonSharedInstance.show_alert(alert_title: "AFBN", btn_title: "Ok", msg: "Please enter your company name", presentingClass: self)
                                            }
                                        }else{
                                            CommonClass.commonSharedInstance.show_alert(alert_title: "AFBN", btn_title: "Ok", msg: "Please enter your company phone number", presentingClass: self)
                                        }
                                    }else{
                                        CommonClass.commonSharedInstance.show_alert(alert_title: "AFBN", btn_title: "Ok", msg: "Please enter your company business type", presentingClass: self)
                                    }
                                }else{
                                    CommonClass.commonSharedInstance.show_alert(alert_title: "AFBN", btn_title: "Ok", msg: "Please enter your company position", presentingClass: self)
                                }
                            }else{
                                CommonClass.commonSharedInstance.show_alert(alert_title: "AFBN", btn_title: "Ok", msg: "Please enter your company city name", presentingClass: self)
                            }
                        }else{
                            CommonClass.commonSharedInstance.show_alert(alert_title: "AFBN", btn_title: "Ok", msg: "Please enter your company mobile number", presentingClass: self)
                        }
                    }else{
                        CommonClass.commonSharedInstance.show_alert(alert_title: "AFBN", btn_title: "Ok", msg: "Please enter your company fax", presentingClass: self)
                    }
                }else{
                    CommonClass.commonSharedInstance.show_alert(alert_title: "AFBN", btn_title: "Ok", msg: "Please enter your company country name", presentingClass: self)
                }
                
            }
        }
        
        
    }
    
    //MARK: -Api call for registration
    func callApiForRegistration(){
        
         CommonClass.commonSharedInstance.showSpinner(onView: self.view)
         UrlRequestClass.UrlRequestSharedInstance.urlrequestDelegate = self
        UrlRequestClass.UrlRequestSharedInstance.getRegister(contactDict: CommonClass.commonSharedInstance.contactDict, companyInfoDict: CommonClass.commonSharedInstance.companyInfoDict, referenceDict: CommonClass.commonSharedInstance.referenceDict,file_path:self.file_path ,viewcontroller_class: self,tag:"1")
        
    }
    
    //MARK: -Button Action
    
    @objc func nextbuttonAction(_ sender: UIButton){
        //print("nextbuttonAction\(sender)")
        
        CommonClass.commonSharedInstance.referenceDict = ["referenceInfo" : self.fieldArr]
        setValidation_contactInfo()
        
        
    }
    
    @objc func previousbuttonAction(_ sender: UIButton){
        //print("previousbuttonAction\(sender)")
        buttonImgVw.image = UIImage(named: "companyInfo_selected")
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let companyInfoController = storyBoard.instantiateViewController(withIdentifier: "CompanyInfoViewController") as! CompanyInfoViewController
        //self.present(singInController, animated: true, completion: nil)
        self.navigationController?.pushViewController(companyInfoController, animated: false)
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
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let contactsController = storyBoard.instantiateViewController(withIdentifier: "ContactsViewController") as! ContactsViewController
        //self.present(singInController, animated: true, completion: nil)
        self.navigationController?.pushViewController(contactsController, animated: false)
    }
    @IBAction func companyInfoBtnAction(_ sender: UIButton) {
        buttonImgVw.image = UIImage(named: "companyInfo_selected")
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let companyInfoController = storyBoard.instantiateViewController(withIdentifier: "CompanyInfoViewController") as! CompanyInfoViewController
        //self.present(singInController, animated: true, completion: nil)
        self.navigationController?.pushViewController(companyInfoController, animated: false)
    }
    @IBAction func referenceBtnAction(_ sender: UIButton) {
        buttonImgVw.image = UIImage(named: "reference_selected")
        
//        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//        let referenceController = storyBoard.instantiateViewController(withIdentifier: "ReferenceViewController") as! ReferenceViewController
//        //self.present(singInController, animated: true, completion: nil)
//        self.navigationController?.pushViewController(referenceController, animated: false)
        
    }

}

extension ReferenceViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 7
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if(section == 6){
            
            return 1
            
        }else {
            
            return 11
            
        }
        
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        
        
        if(section == 0) {
            
            let rect = CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 150.0)
            let footerView = UIView(frame:rect)
            footerView.backgroundColor = UIColor.clear
            
            let rect1 = CGRect(x: 0, y: 5.0, width: tableView.frame.size.width, height: 40.0)
            let label: UILabel = UILabel(frame:rect1)
            label.textAlignment = NSTextAlignment.left
            label.font = UIFont(name: "OpenSans-regular", size: 22.0)
            
            label.text = "FREIGHT FORWARDERS REFERENCES"
            
            footerView.addSubview(label)
            
            let rect2 = CGRect(x: 0, y: 45.0, width: tableView.frame.size.width, height: 80.0)
            let labL: UILabel = UILabel(frame:rect2)
            labL.textAlignment = NSTextAlignment.left
            labL.numberOfLines = 4
            labL.font = UIFont(name: "OpenSans-regular", size: 10.0)
            
            labL.text = "(Must be at least three overseas references with which you have done business with out side your local region.)"
            
            footerView.addSubview(labL)
            
            let rect3 = CGRect(x: 0, y: 130.0, width: tableView.frame.size.width, height: 20.0)
            let lbl: UILabel = UILabel(frame:rect3)
            lbl.textAlignment = NSTextAlignment.left
            lbl.numberOfLines = 4
            lbl.font = UIFont(name: "OpenSans-regular", size: 16.0)
            
            lbl.text = "Company 1"
            
            footerView.addSubview(lbl)
            
            return footerView
            
        }else if(section == 3) {
            
            let rect = CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 150.0)
            let footerView = UIView(frame:rect)
            footerView.backgroundColor = UIColor.clear
            
            let rect1 = CGRect(x: 0, y: 5.0, width: tableView.frame.size.width, height: 40.0)
            let label: UILabel = UILabel(frame:rect1)
            label.textAlignment = NSTextAlignment.left
            label.font = UIFont(name: "OpenSans-regular", size: 22.0)
            
            label.text = "CLIENTS REFERENCES"
            
            footerView.addSubview(label)
            
            let rect2 = CGRect(x: 0, y: 45.0, width: tableView.frame.size.width, height: 80.0)
            let labL: UILabel = UILabel(frame:rect2)
            labL.textAlignment = NSTextAlignment.left
            labL.numberOfLines = 4
            labL.font = UIFont(name: "OpenSans-regular", size: 10.0)
            
            labL.text = "(Must be at least three overseas references with which you have done business with out side your local region.)"
            
            footerView.addSubview(labL)
            
            let rect3 = CGRect(x: 0, y: 130.0, width: tableView.frame.size.width, height: 20.0)
            let lbl: UILabel = UILabel(frame:rect3)
            lbl.textAlignment = NSTextAlignment.left
            lbl.numberOfLines = 4
            lbl.font = UIFont(name: "OpenSans-regular", size: 16.0)
            
            lbl.text = "Client 1"
            
            footerView.addSubview(lbl)
            
            return footerView
            
        } else if(section == 1 || section == 2 || section == 4 || section == 5){
            
            let rect = CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 50.0)
            let footerView = UIView(frame:rect)
            footerView.backgroundColor = UIColor.clear
            
            let rect2 = CGRect(x: 0, y: 20.0, width: tableView.frame.size.width, height: 30.0)
            let label: UILabel = UILabel(frame:rect2)
            label.textAlignment = NSTextAlignment.left
            label.font = UIFont(name: "OpenSans-regular", size: 16.0)
            footerView.addSubview(label)
            
            if(section == 1){
                label.text = "Company 2"
            }else if(section == 2){
                label.text = "Company 3"
            }else if(section == 4){
                label.text = "Client 2"
            }else{
                label.text = "Client 3"
            }
            
         
            return footerView
            
        }else{
            
            let rect = CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 10)
            let footerView = UIView(frame:rect)
            footerView.backgroundColor = UIColor.clear
            
            return footerView
            
        }
        
        
        
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        if(section == 0 || section == 3) {
            
            return 150
            
        }else if(section == 6) {
            
            return 10
            
        }else {
            
            return 50
            
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
        
        if(indexPath.section == 6){
            return 100.0
        }else{
            return 70.0
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //contactsViewCell.textFld.delegate = (self as! UITextFieldDelegate)
        
        if(indexPath.section == 0 || indexPath.section == 1 || indexPath.section == 2 || indexPath.section == 3 || indexPath.section == 4 || indexPath.section == 5){
            
            let referenceViewCell:referenceTableViewCell = tableView.dequeueReusableCell(withIdentifier: "referenceTableViewCell", for: indexPath) as! referenceTableViewCell
            
            if(indexPath.row == 0){
                referenceViewCell.textFld.attributedPlaceholder = NSAttributedString(string: "Company Name",attributes:[NSAttributedString.Key.foregroundColor:UIColor.black])
                //referenceViewCell.textFld.placeholder = "Company Name"
            }else if(indexPath.row == 1){
                referenceViewCell.textFld.attributedPlaceholder = NSAttributedString(string: "Type of Business",attributes:[NSAttributedString.Key.foregroundColor:UIColor.black])
                //referenceViewCell.textFld.placeholder = "Type of Business"
            }else if(indexPath.row == 2){
                referenceViewCell.textFld.attributedPlaceholder = NSAttributedString(string: "Contact",attributes:[NSAttributedString.Key.foregroundColor:UIColor.black])
                //referenceViewCell.textFld.placeholder = "Contact"
            }else if(indexPath.row == 3){
                referenceViewCell.textFld.attributedPlaceholder = NSAttributedString(string: "Position",attributes:[NSAttributedString.Key.foregroundColor:UIColor.black])
                //referenceViewCell.textFld.placeholder = "Position"
            }else if(indexPath.row == 4){
                referenceViewCell.textFld.attributedPlaceholder = NSAttributedString(string: "Country",attributes:[NSAttributedString.Key.foregroundColor:UIColor.black])
                //referenceViewCell.textFld.placeholder = "Country"
            }else if(indexPath.row == 5){
                referenceViewCell.textFld.attributedPlaceholder = NSAttributedString(string: "City",attributes:[NSAttributedString.Key.foregroundColor:UIColor.black])
                //referenceViewCell.textFld.placeholder = "City"
            }else if(indexPath.row == 6){
                referenceViewCell.textFld.attributedPlaceholder = NSAttributedString(string: "Mobile",attributes:[NSAttributedString.Key.foregroundColor:UIColor.black])
                //referenceViewCell.textFld.placeholder = "Mobile"
            }else if(indexPath.row == 7){
                referenceViewCell.textFld.attributedPlaceholder = NSAttributedString(string: "Phone",attributes:[NSAttributedString.Key.foregroundColor:UIColor.black])
                //referenceViewCell.textFld.placeholder = "Phone"
            }else if(indexPath.row == 8){
                referenceViewCell.textFld.attributedPlaceholder = NSAttributedString(string: "Fax",attributes:[NSAttributedString.Key.foregroundColor:UIColor.black])
                //referenceViewCell.textFld.placeholder = "Fax"
            }else if(indexPath.row == 9){
                referenceViewCell.textFld.attributedPlaceholder = NSAttributedString(string: "Email",attributes:[NSAttributedString.Key.foregroundColor:UIColor.black])
                //referenceViewCell.textFld.placeholder = "Email"
            }else{
                referenceViewCell.textFld.attributedPlaceholder = NSAttributedString(string: "Emergency Number",attributes:[NSAttributedString.Key.foregroundColor:UIColor.black])
                //referenceViewCell.textFld.placeholder = "Emergency Number"
            }
            
            
            if(indexPath.section == 0){
                referenceViewCell.textFld.tag =  100 + indexPath.row + 1
                
            }else if(indexPath.section == 1){
                referenceViewCell.textFld.tag =  200 + indexPath.row + 1
                
            }else if(indexPath.section == 2){
                referenceViewCell.textFld.tag =  300 + indexPath.row + 1
                
            }else if(indexPath.section == 3){
                referenceViewCell.textFld.tag =  400 + indexPath.row + 1
                
            }else if(indexPath.section == 4){
                referenceViewCell.textFld.tag =  500 + indexPath.row + 1
                
            }else {
                referenceViewCell.textFld.tag =  600 + indexPath.row + 1
                
            }
            
            let dict = self.fieldArr[indexPath.section]
            if(indexPath.row == 0){
                referenceViewCell.textFld.text = dict["company_name"] as? String
            }else if(indexPath.row == 1){
                referenceViewCell.textFld.text = dict["business_type"] as? String
            }else if(indexPath.row == 2){
                referenceViewCell.textFld.text = dict["contact"] as? String
            }else if(indexPath.row == 3){
                referenceViewCell.textFld.text = dict["position"] as? String
            }else if(indexPath.row == 4){
                referenceViewCell.textFld.text = dict["country"] as? String
            }else if(indexPath.row == 5){
                referenceViewCell.textFld.text = dict["city"] as? String
            }else if(indexPath.row == 6){
                referenceViewCell.textFld.text = dict["mobile"] as? String
            }else if(indexPath.row == 7){
                referenceViewCell.textFld.text = dict["phone"] as? String
            }else if(indexPath.row == 8){
                referenceViewCell.textFld.text = dict["fax"] as? String
            }else if(indexPath.row == 9){
                referenceViewCell.textFld.text = dict["email"] as? String
            }else {
                referenceViewCell.textFld.text = dict["emergency_no"] as? String
            }
            
            
//            if(indexPath.section == 0){
//                let dict = self.fieldArr[indexPath.section]
//            }
            
            return referenceViewCell
            
        }else{
            
            let referenceBtnViewCell:referenceButtonTableViewCell = tableView.dequeueReusableCell(withIdentifier: "referenceButtonTableViewCell", for: indexPath) as! referenceButtonTableViewCell
            
            referenceBtnViewCell.nextBtn.addTarget(self, action: #selector(self.nextbuttonAction(_:)), for: .touchUpInside)
            referenceBtnViewCell.previousBtn.addTarget(self, action: #selector(self.previousbuttonAction(_:)), for: .touchUpInside)
            referenceBtnViewCell.nextBtn.layer.cornerRadius = 5.0
            referenceBtnViewCell.previousBtn.layer.cornerRadius = 5.0
            referenceBtnViewCell.backgroundColor = UIColor.white
            
            return referenceBtnViewCell
            
            
        }
        
    }
    
    
    
    //MARK: -URLREQUEST DELEGATES METHOD
    func urlrequestfinish_with_success(data: NSDictionary, requestType: String, request_class: UIViewController,tag:String) {
        print("response data",data)
        showalertfor_Thanking()
    }
    
    func urlrequestfinish_with_error(error: Error) {
        print("error",error)
    }
    
}


extension ReferenceViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        //self.activeField = textField
        print("textfield tag:",self.activeField?.tag as Any)
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        let pointInTable = textField.convert(textField.bounds.origin, to: self.referenceTableVw)
        let textFieldIndexPath = self.referenceTableVw.indexPathForRow(at: pointInTable)
        
        updateDictValue(indexPath: textFieldIndexPath! as NSIndexPath, valueStr: textField.text!)
        
        if(textFieldIndexPath?.section == 0){
            let index =  100 + (textFieldIndexPath?.row)! + 1
            self.activeField = view.viewWithTag(index + 1) as? UITextField
            
        }else if(textFieldIndexPath?.section == 1){
            let index =  200 + (textFieldIndexPath?.row)! + 1
            self.activeField = view.viewWithTag(index + 1) as? UITextField
            
        }else if(textFieldIndexPath?.section == 2){
            let index =  300 + (textFieldIndexPath?.row)! + 1
            self.activeField = view.viewWithTag(index + 1) as? UITextField
            
        }else if(textFieldIndexPath?.section == 3){
            let index =  400 + (textFieldIndexPath?.row)! + 1
            self.activeField = view.viewWithTag(index + 1) as? UITextField
            
        }else if(textFieldIndexPath?.section == 4){
            let index =  500 + (textFieldIndexPath?.row)! + 1
            self.activeField = view.viewWithTag(index + 1) as? UITextField
            
        }else {
            let index =  600 + (textFieldIndexPath?.row)! + 1
            self.activeField = view.viewWithTag(index + 1) as? UITextField
            
        }
        
        //let index = self.activeField?.tag
        //self.activeField = view.viewWithTag(index! + 1) as? UITextField
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
            referenceTableVw.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height + 25.0, right: 0)
        }}
    
    
    @objc func keyboardWillHide(_ notification:Notification) {
        
        if ((notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue) != nil {
            referenceTableVw.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        }
        
    }
    
}



