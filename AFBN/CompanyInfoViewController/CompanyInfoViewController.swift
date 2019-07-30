//
//  CompanyInfoViewController.swift
//  AFBN
//
//  Created by Erudition Informatics on 26/04/19.
//  Copyright © 2019 Erudition Informatics. All rights reserved.
//

import UIKit
import MobileCoreServices

class CompanyInfoButtonTableViewCell : UITableViewCell {
    @IBOutlet weak var previousBtn: UIButton!
    @IBOutlet weak var nextBtn: UIButton!
}

class CompanyInfoTableViewCell : UITableViewCell {
    @IBOutlet weak var textFld: UITextField!
}

class CompanyInfoTxtTableViewCell : UITableViewCell {
    @IBOutlet weak var textFld: UITextView!
    @IBOutlet weak var starImg: UIImageView!
}

class CompanyInfoAttachmentTableViewCell : UITableViewCell {
    @IBOutlet weak var textFld: UILabel!
    @IBOutlet weak var starImg: UIImageView!
    @IBOutlet weak var attachBtn:UIButton!
}

class CompanyInfoViewController: UIViewController {
    
    @IBOutlet weak var companyInfoTableVw: UITableView!
    
    @IBOutlet weak var buttonImgVw: UIImageView!
    
    @IBOutlet weak var termsBtn: UIButton!
    @IBOutlet weak var contactsBtn: UIButton!
    @IBOutlet weak var companyInfoBtn: UIButton!
    @IBOutlet weak var referenceBtn: UIButton!
    
    @IBOutlet weak var buttonVw: UIView!
    var activeField: UITextField?
    var fieldArr = [[String:Any]]()

    var indexPath_for_attachbtnaction:NSIndexPath!
    var filePath :String!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        setFieldValue()
        registerForKeyboardNotifications()
        registerForTxtViewKeyboardNotification()
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
            "year_east" : "",
            "company_summary" : "Summary about the company",
            "website" : "",
            "tell_no" : "",
            "fax_no" : "",
            "emergency_no" : "",
            "staff_amount" : "",
            "branch_amount" : "",
            "branch_location" : "",
            "location_amount" : "",
            "branch_address" : "",
            "anual_sales" : "Please state your annual sales volumn for your firm in the US",
            "anual_tonnage" : "Please advice us of you annual tonnage for air and ocean freight"
        ]
        
        self.fieldArr.append(dict)
        
        let dict1 = [
            "company_profile" : "Company Profile"
        ]
        
        self.fieldArr.append(dict1)
        
        let dict2 = [
            "license_no" : "FMC Lincenced Foreign Freight Forwarder License",
            "nvocc_no":"NVOCC(Non-Vessel-Operating Common Carrier) bond Number",
            "brocker_licence_no":"Custom House Broker - License Number",
            "carrier":"",
            "packing_facility":"",
            "sales_agents":"IATA Approved Cargo Sales Agents",
            "meng_company":"",
            "int_consultant":"",
            "iso9001_registered":"ISO9001/2015 registered",
            "iso9002_registered":"",
            "brokarage_opt":"Licensed Custom House Brokerage Operation",
            "membership_cert":"Other Membership Certification"
        ]
        
        self.fieldArr.append(dict2)
        
        let dict3 = [
            "line1" : "",
            "line2":"",
            "line3":"",
            "p.o.box":"",
            "city":"",
            "country":"",
            "phone":"",
            "fax":"",
            
        ]
        
        self.fieldArr.append(dict3)
        
        let dict4 = [
            "reasons" : "Please explain your reasons:"
            ]
        
        self.fieldArr.append(dict4)
        
        let dict5 = [
            "reasons" : "Please explain your reasons:"
        ]
        
        self.fieldArr.append(dict5)
        
        print("field Array:",self.fieldArr.count,self.fieldArr)
    }
    
    func updateDictValue(indexPath:NSIndexPath ,valueStr:String){
        
        if(indexPath.section == 0){
            
            if(indexPath.row == 0){
                self.fieldArr[indexPath.section]["company_name"] = valueStr
            }else if(indexPath.row == 1){
                self.fieldArr[indexPath.section]["year_east"] = valueStr
            }else if(indexPath.row == 3){
                self.fieldArr[indexPath.section]["website"] = valueStr
            }else if(indexPath.row == 4){
                self.fieldArr[indexPath.section]["tell_no"] = valueStr
            }else if(indexPath.row == 5){
                self.fieldArr[indexPath.section]["fax_no"] = valueStr
            }else if(indexPath.row == 6){
                self.fieldArr[indexPath.section]["emergency_no"] = valueStr
            }else if(indexPath.row == 7){
                self.fieldArr[indexPath.section]["staff_amount"] = valueStr
            }else if(indexPath.row == 8){
                self.fieldArr[indexPath.section]["branch_amount"] = valueStr
            }else if(indexPath.row == 9){
                self.fieldArr[indexPath.section]["branch_location"] = valueStr
            }else if(indexPath.row == 10){
                self.fieldArr[indexPath.section]["location_amount"] = valueStr
            }else if(indexPath.row == 11){
                self.fieldArr[indexPath.section]["branch_address"] = valueStr
            }else if(indexPath.row == 2){
                self.fieldArr[indexPath.section]["company_summary"] = valueStr
            }else if(indexPath.row == 12){
                self.fieldArr[indexPath.section]["anual_sales"] = valueStr
            }else if(indexPath.row == 13){
                self.fieldArr[indexPath.section]["anual_tonnage"] = valueStr
            }
            
        }else if(indexPath.section == 1){
            self.fieldArr[indexPath.section]["company_profile"] = valueStr
        }else if(indexPath.section == 2){
            
            if(indexPath.row == 0){
                self.fieldArr[indexPath.section]["license_no"] = valueStr
            }else if(indexPath.row == 1){
                self.fieldArr[indexPath.section]["nvocc_no"] = valueStr
            }else if(indexPath.row == 3){
                self.fieldArr[indexPath.section]["carrier"] = valueStr
            }else if(indexPath.row == 4){
                self.fieldArr[indexPath.section]["packing_facility"] = valueStr
            }else if(indexPath.row == 5){
                self.fieldArr[indexPath.section]["sales_agents"] = valueStr
            }else if(indexPath.row == 6){
                self.fieldArr[indexPath.section]["meng_company"] = valueStr
            }else if(indexPath.row == 7){
                self.fieldArr[indexPath.section]["int_consultant"] = valueStr
            }else if(indexPath.row == 8){
                self.fieldArr[indexPath.section]["iso9001_registered"] = valueStr
            }else if(indexPath.row == 9){
                self.fieldArr[indexPath.section]["iso9002_registered"] = valueStr
            }else if(indexPath.row == 10){
                self.fieldArr[indexPath.section]["brokarage_opt"] = valueStr
            }else if(indexPath.row == 11){
                self.fieldArr[indexPath.section]["membership_cert"] = valueStr
            }else if(indexPath.row == 2){
                self.fieldArr[indexPath.section]["brocker_licence_no"] = valueStr
            }
            
        }else if(indexPath.section == 3){
            
            if(indexPath.row == 0){
                self.fieldArr[indexPath.section]["line1"] = valueStr
            }else if(indexPath.row == 1){
                self.fieldArr[indexPath.section]["line2"] = valueStr
            }else if(indexPath.row == 2){
                self.fieldArr[indexPath.section]["line3"] = valueStr
            }else if(indexPath.row == 3){
                self.fieldArr[indexPath.section]["p.o.box"] = valueStr
            }else if(indexPath.row == 4){
                self.fieldArr[indexPath.section]["city"] = valueStr
            }else if(indexPath.row == 5){
                self.fieldArr[indexPath.section]["country"] = valueStr
            }else if(indexPath.row == 6){
                self.fieldArr[indexPath.section]["phone"] = valueStr
            }else if(indexPath.row == 7){
                self.fieldArr[indexPath.section]["fax"] = valueStr
            }
            
        }else if(indexPath.section == 4){
            self.fieldArr[indexPath.section]["reasons"] = valueStr
        }else if(indexPath.section == 5){
            self.fieldArr[indexPath.section]["reasons"] = valueStr
        }
        
        
        print("field Array from update:",self.fieldArr.count,self.fieldArr)
        
    }
    
    
    //MARK: Button Action
    @objc func nextbuttonAction(_ sender: UIButton){
        print("nextbuttonAction\(sender)")
        CommonClass.commonSharedInstance.companyInfoDict = ["companyInfo" : self.fieldArr]
        buttonImgVw.image = UIImage(named: "reference_selected")
        CommonClass.commonSharedInstance.companyInfoDict.setValue(fieldArr, forKey: "companyInfo")
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let referenceController = storyBoard.instantiateViewController(withIdentifier: "ReferenceViewController") as! ReferenceViewController
        referenceController.file_path = self.filePath
        //self.present(singInController, animated: true, completion: nil)
        self.navigationController?.pushViewController(referenceController, animated: false)
    }
    @objc func previousbuttonAction(_ sender: UIButton){
        print("previousbuttonAction\(sender)")
        buttonImgVw.image = UIImage(named: "contact_selected")
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let contactsController = storyBoard.instantiateViewController(withIdentifier: "ContactsViewController") as! ContactsViewController
        //self.present(singInController, animated: true, completion: nil)
        self.navigationController?.pushViewController(contactsController, animated: false)
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
    }
    @IBAction func referenceBtnAction(_ sender: UIButton) {
        buttonImgVw.image = UIImage(named: "reference_selected")
        CommonClass.commonSharedInstance.companyInfoDict = ["companyInfo" : self.fieldArr]
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let referenceController = storyBoard.instantiateViewController(withIdentifier: "ReferenceViewController") as! ReferenceViewController
        referenceController.file_path = self.filePath
        //self.present(singInController, animated: true, completion: nil)
        self.navigationController?.pushViewController(referenceController, animated: false)
        
    }

}

extension CompanyInfoViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 7
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if(section == 0){
            
            return 14
            
        }else if(section == 1){
            
            return 1
            
        }else if(section == 2){
            
            return 12
            
        }else if(section == 3){
            
            return 8
            
        }else{
            
            return 1
            
        }
        
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        
        
        if(section == 0 || section == 1 || section == 2) {
            
            let rect = CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 50)
            let footerView = UIView(frame:rect)
            footerView.backgroundColor = UIColor.clear
            
            let rect1 = CGRect(x: 10, y: 24.0, width: tableView.frame.size.width - 20, height: 30.0)
            let label: UILabel = UILabel(frame:rect1)
            label.textAlignment = NSTextAlignment.left
            label.font = UIFont(name: "Open sans-regular", size: 15.0)
            
            if(section == 0){
                label.text = "Company Information"
            }else if(section == 1){
                label.text = "Custom Clearance"
            }else{
                label.text = "Certification and authorization"
            }
            
            
            footerView.addSubview(label)
            
            return footerView
            
        }else if(section == 3) {
            
            let rect = CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 50)
            let footerView = UIView(frame:rect)
            footerView.backgroundColor = UIColor.clear
            
            let rect1 = CGRect(x: 10, y: 10.0, width: tableView.frame.size.width - 20, height: 18.0)
            let label: UILabel = UILabel(frame:rect1)
            label.textAlignment = NSTextAlignment.left
            label.font = UIFont(name: "Opensans-regular", size: 15.0)
            label.text = "Address"
            
            footerView.addSubview(label)
            
            let rect2 = CGRect(x: 10, y: label.frame.origin.y + label.frame.size.height , width: tableView.frame.size.width - 20, height: 20.0)
            let lbl: UILabel = UILabel(frame:rect2)
            lbl.textAlignment = NSTextAlignment.left
            label.font = UIFont(name: "Opensans-regular", size: 8.0)
            lbl.text = "Please fill address in mailing address format"
            
            footerView.addSubview(lbl)
            
            return footerView
            
        } else {
            
            let rect = CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 50)
            let footerView = UIView(frame:rect)
            footerView.backgroundColor = UIColor.clear
            
            let rect2 = CGRect(x: 10, y: 0.0, width: tableView.frame.size.width - 20, height: 50)
            let label: UILabel = UILabel(frame:rect2)
            label.textAlignment = NSTextAlignment.left
            label.font = UIFont(name: "Open sans-regular", size: 15.0)
            label.numberOfLines = 3
            label.lineBreakMode = NSLineBreakMode.byWordWrapping
            
            if(section == 4){
                label.text = "Why do you want to become a member of AFBN?"
            }else{
                label.text = "Where are your market/company strengths that will add value to the existing AFBN member?"
            }
            
            
            footerView.addSubview(label)
            
            return footerView
            
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 50
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if(indexPath.section == 0){
            if(indexPath.row == 2 || indexPath.row == 12 || indexPath.row == 13){
                return 120.0
            }else{
                return 70.0
            }
        }else if(indexPath.section == 2){
            if(indexPath.row == 10 || indexPath.row == 11){
                return 120.0
            }else{
                return 70.0
            }
        }else if(indexPath.section == 5 || indexPath.section == 4){
            return 120.0
        }else{
            return 70.0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //contactsViewCell.textFld.delegate = (self as! UITextFieldDelegate)
        
        if(indexPath.section == 0){
            
            let dict = self.fieldArr[indexPath.section]
            
            if(indexPath.row == 0){
                let companyInfoTblViewCell:CompanyInfoTableViewCell = tableView.dequeueReusableCell(withIdentifier: "CompanyInfoTableViewCell", for: indexPath) as! CompanyInfoTableViewCell
                companyInfoTblViewCell.textFld.attributedPlaceholder = NSAttributedString(string: "Company Name",attributes:[NSAttributedString.Key.foregroundColor:UIColor.black])
                //companyInfoTblViewCell.textFld.placeholder = "Company Name"
                companyInfoTblViewCell.textFld.text = dict["company_name"] as? String
                companyInfoTblViewCell.textFld.tag = 100 + indexPath.row + 1
                return companyInfoTblViewCell
            }else if(indexPath.row == 1){
                let companyInfoTblViewCell:CompanyInfoTableViewCell = tableView.dequeueReusableCell(withIdentifier: "CompanyInfoTableViewCell", for: indexPath) as! CompanyInfoTableViewCell
                companyInfoTblViewCell.textFld.attributedPlaceholder = NSAttributedString(string: "Year of Establishment",attributes:[NSAttributedString.Key.foregroundColor:UIColor.black])
                //companyInfoTblViewCell.textFld.placeholder = "Year of Establishment"
                companyInfoTblViewCell.textFld.text = dict["year_east"] as? String
                companyInfoTblViewCell.textFld.tag = 100 + indexPath.row + 1
                return companyInfoTblViewCell
            }else if(indexPath.row == 3){
                let companyInfoTblViewCell:CompanyInfoTableViewCell = tableView.dequeueReusableCell(withIdentifier: "CompanyInfoTableViewCell", for: indexPath) as! CompanyInfoTableViewCell
                companyInfoTblViewCell.textFld.attributedPlaceholder = NSAttributedString(string: "Company Website",attributes:[NSAttributedString.Key.foregroundColor:UIColor.black])
                //companyInfoTblViewCell.textFld.placeholder = "Company Website"
                companyInfoTblViewCell.textFld.text = dict["website"] as? String
                companyInfoTblViewCell.textFld.tag = 100 + indexPath.row + 1
                return companyInfoTblViewCell
            }else if(indexPath.row == 4){
                let companyInfoTblViewCell:CompanyInfoTableViewCell = tableView.dequeueReusableCell(withIdentifier: "CompanyInfoTableViewCell", for: indexPath) as! CompanyInfoTableViewCell
                companyInfoTblViewCell.textFld.attributedPlaceholder = NSAttributedString(string: "Tell Number",attributes:[NSAttributedString.Key.foregroundColor:UIColor.black])
                //companyInfoTblViewCell.textFld.placeholder = "Tell Number"
                companyInfoTblViewCell.textFld.text = dict["tell_no"] as? String
                companyInfoTblViewCell.textFld.tag = 100 + indexPath.row + 1
                return companyInfoTblViewCell
            }else if(indexPath.row == 5){
                let companyInfoTblViewCell:CompanyInfoTableViewCell = tableView.dequeueReusableCell(withIdentifier: "CompanyInfoTableViewCell", for: indexPath) as! CompanyInfoTableViewCell
                companyInfoTblViewCell.textFld.attributedPlaceholder = NSAttributedString(string: "Fax Number",attributes:[NSAttributedString.Key.foregroundColor:UIColor.black])
                //companyInfoTblViewCell.textFld.placeholder = "Fax Number"
                companyInfoTblViewCell.textFld.text = dict["fax_no"] as? String
                companyInfoTblViewCell.textFld.tag = 100 + indexPath.row + 1
                return companyInfoTblViewCell
            }else if(indexPath.row == 6){
                let companyInfoTblViewCell:CompanyInfoTableViewCell = tableView.dequeueReusableCell(withIdentifier: "CompanyInfoTableViewCell", for: indexPath) as! CompanyInfoTableViewCell
                companyInfoTblViewCell.textFld.attributedPlaceholder = NSAttributedString(string: "Emergency Number",attributes:[NSAttributedString.Key.foregroundColor:UIColor.black])
                //companyInfoTblViewCell.textFld.placeholder = "Emergency Number"
                companyInfoTblViewCell.textFld.text = dict["emergency_no"] as? String
                companyInfoTblViewCell.textFld.tag = 100 + indexPath.row + 1
                return companyInfoTblViewCell
            }else if(indexPath.row == 7){
                let companyInfoTblViewCell:CompanyInfoTableViewCell = tableView.dequeueReusableCell(withIdentifier: "CompanyInfoTableViewCell", for: indexPath) as! CompanyInfoTableViewCell
                companyInfoTblViewCell.textFld.attributedPlaceholder = NSAttributedString(string: "Amount of Staff",attributes:[NSAttributedString.Key.foregroundColor:UIColor.black])
                //companyInfoTblViewCell.textFld.placeholder = "Amount of Staff"
                companyInfoTblViewCell.textFld.text = dict["staff_amount"] as? String
                companyInfoTblViewCell.textFld.tag = 100 + indexPath.row + 1
                return companyInfoTblViewCell
            }else if(indexPath.row == 8){
                let companyInfoTblViewCell:CompanyInfoTableViewCell = tableView.dequeueReusableCell(withIdentifier: "CompanyInfoTableViewCell", for: indexPath) as! CompanyInfoTableViewCell
                companyInfoTblViewCell.textFld.attributedPlaceholder = NSAttributedString(string: "Amount of Branches",attributes:[NSAttributedString.Key.foregroundColor:UIColor.black])
                //companyInfoTblViewCell.textFld.placeholder = "Amount of Branches"
                companyInfoTblViewCell.textFld.text = dict["branch_amount"] as? String
                companyInfoTblViewCell.textFld.tag = 100 + indexPath.row + 1
                return companyInfoTblViewCell
            }else if(indexPath.row == 9){
                let companyInfoTblViewCell:CompanyInfoTableViewCell = tableView.dequeueReusableCell(withIdentifier: "CompanyInfoTableViewCell", for: indexPath) as! CompanyInfoTableViewCell
                companyInfoTblViewCell.textFld.attributedPlaceholder = NSAttributedString(string: "Location of Branches",attributes:[NSAttributedString.Key.foregroundColor:UIColor.black])
                //companyInfoTblViewCell.textFld.placeholder = "Location of Branches"
                companyInfoTblViewCell.textFld.text = dict["branch_location"] as? String
                companyInfoTblViewCell.textFld.tag = 100 + indexPath.row + 1
                return companyInfoTblViewCell
            }else if(indexPath.row == 10){
                let companyInfoTblViewCell:CompanyInfoTableViewCell = tableView.dequeueReusableCell(withIdentifier: "CompanyInfoTableViewCell", for: indexPath) as! CompanyInfoTableViewCell
                companyInfoTblViewCell.textFld.attributedPlaceholder = NSAttributedString(string: "Amount of Location",attributes:[NSAttributedString.Key.foregroundColor:UIColor.black])
                //companyInfoTblViewCell.textFld.placeholder = "Amount of Location"
                companyInfoTblViewCell.textFld.text = dict["location_amount"] as? String
                companyInfoTblViewCell.textFld.tag = 100 + indexPath.row + 1
                return companyInfoTblViewCell
            }else if(indexPath.row == 11){
                let companyInfoTblViewCell:CompanyInfoTableViewCell = tableView.dequeueReusableCell(withIdentifier: "CompanyInfoTableViewCell", for: indexPath) as! CompanyInfoTableViewCell
                companyInfoTblViewCell.textFld.attributedPlaceholder = NSAttributedString(string: "Branch Address",attributes:[NSAttributedString.Key.foregroundColor:UIColor.black])
                //companyInfoTblViewCell.textFld.placeholder = "Branch Address"
                companyInfoTblViewCell.textFld.text = dict["branch_address"] as? String
                companyInfoTblViewCell.textFld.tag = 100 + indexPath.row + 1
                return companyInfoTblViewCell
            }else if(indexPath.row == 2){
                
                let companyInfoTxtTblViewCell:CompanyInfoTxtTableViewCell = tableView.dequeueReusableCell(withIdentifier: "CompanyInfoTxtTableViewCell", for: indexPath) as! CompanyInfoTxtTableViewCell
                
                //companyInfoTxtTblViewCell.textFld.text = "Summary about the company"
                companyInfoTxtTblViewCell.textFld.text = dict["company_summary"] as? String
                return companyInfoTxtTblViewCell
                
            }else if(indexPath.row == 12){
                
                let companyInfoTxtTblViewCell:CompanyInfoTxtTableViewCell = tableView.dequeueReusableCell(withIdentifier: "CompanyInfoTxtTableViewCell", for: indexPath) as! CompanyInfoTxtTableViewCell
                //companyInfoTxtTblViewCell.textFld.text = "Please state your annual sales volumn for your firm in the US"
                companyInfoTxtTblViewCell.textFld.text = dict["anual_sales"] as? String
                return companyInfoTxtTblViewCell
                
            }else{
                
                let companyInfoTxtTblViewCell:CompanyInfoTxtTableViewCell = tableView.dequeueReusableCell(withIdentifier: "CompanyInfoTxtTableViewCell", for: indexPath) as! CompanyInfoTxtTableViewCell
                //companyInfoTxtTblViewCell.textFld.text = "Please advice us of you annual tonnage for air and ocean freight"
                companyInfoTxtTblViewCell.textFld.text = dict["anual_tonnage"] as? String
                return companyInfoTxtTblViewCell
                
            }
            
            
            
            
            
        }else if (indexPath.section == 1 ){
            
            let companyInfoAttachTblViewCell:CompanyInfoAttachmentTableViewCell = tableView.dequeueReusableCell(withIdentifier: "CompanyInfoAttachmentTableViewCell", for: indexPath) as! CompanyInfoAttachmentTableViewCell
            
            let dict = self.fieldArr[indexPath.section]
            //companyInfoAttachTblViewCell.textFld.text = "Company Profile"
            companyInfoAttachTblViewCell.textFld.text = dict["company_profile"] as? String
            companyInfoAttachTblViewCell.attachBtn.addTarget(self, action: #selector(self.attachbuttonAction(_:)), for: .touchUpInside)
            
            return companyInfoAttachTblViewCell
            
        }else if(indexPath.section == 2 ){
            
            let dict = self.fieldArr[indexPath.section]
            
            if(indexPath.row == 0){
                let companyInfoAttachTblViewCell:CompanyInfoAttachmentTableViewCell = tableView.dequeueReusableCell(withIdentifier: "CompanyInfoAttachmentTableViewCell", for: indexPath) as! CompanyInfoAttachmentTableViewCell
                
                //companyInfoAttachTblViewCell.textFld.text = "FMC Lincenced Foreign Freight Forwarder License"
                companyInfoAttachTblViewCell.textFld.text = dict["license_no"] as? String
                companyInfoAttachTblViewCell.attachBtn.addTarget(self, action: #selector(self.attachbuttonAction(_:)), for: .touchUpInside)
                
                return companyInfoAttachTblViewCell
            }else if(indexPath.row == 1){
                let companyInfoAttachTblViewCell:CompanyInfoAttachmentTableViewCell = tableView.dequeueReusableCell(withIdentifier: "CompanyInfoAttachmentTableViewCell", for: indexPath) as! CompanyInfoAttachmentTableViewCell
                
                //companyInfoAttachTblViewCell.textFld.text = "NVOCC(Non-Vessel-Operating Common Carrier) bond Number"
                companyInfoAttachTblViewCell.textFld.text = dict["nvocc_no"] as? String
                companyInfoAttachTblViewCell.attachBtn.addTarget(self, action: #selector(self.attachbuttonAction(_:)), for: .touchUpInside)
                
                return companyInfoAttachTblViewCell
            }else if(indexPath.row == 2){
                let companyInfoAttachTblViewCell:CompanyInfoAttachmentTableViewCell = tableView.dequeueReusableCell(withIdentifier: "CompanyInfoAttachmentTableViewCell", for: indexPath) as! CompanyInfoAttachmentTableViewCell
                
                //companyInfoAttachTblViewCell.textFld.text = "Custom House Broker - License Number"
                companyInfoAttachTblViewCell.textFld.text = dict["brocker_licence_no"] as? String
                companyInfoAttachTblViewCell.attachBtn.addTarget(self, action: #selector(self.attachbuttonAction(_:)), for: .touchUpInside)
                
                return companyInfoAttachTblViewCell
            }else if(indexPath.row == 5){
                let companyInfoAttachTblViewCell:CompanyInfoAttachmentTableViewCell = tableView.dequeueReusableCell(withIdentifier: "CompanyInfoAttachmentTableViewCell", for: indexPath) as! CompanyInfoAttachmentTableViewCell
                
                //companyInfoAttachTblViewCell.textFld.text = "IATA Approved Cargo Sales Agents"
                companyInfoAttachTblViewCell.textFld.text = dict["sales_agents"] as? String
                companyInfoAttachTblViewCell.attachBtn.addTarget(self, action: #selector(self.attachbuttonAction(_:)), for: .touchUpInside)
                
                return companyInfoAttachTblViewCell
            }else if(indexPath.row == 8){
                let companyInfoAttachTblViewCell:CompanyInfoAttachmentTableViewCell = tableView.dequeueReusableCell(withIdentifier: "CompanyInfoAttachmentTableViewCell", for: indexPath) as! CompanyInfoAttachmentTableViewCell
                
                //companyInfoAttachTblViewCell.textFld.text = "ISO9001/2015 registered"
                companyInfoAttachTblViewCell.textFld.text = dict["iso9001_registered"] as? String
                companyInfoAttachTblViewCell.attachBtn.addTarget(self, action: #selector(self.attachbuttonAction(_:)), for: .touchUpInside)
                
                return companyInfoAttachTblViewCell
            }else if(indexPath.row == 11){
                let companyInfoTxt_TblViewCell:CompanyInfoTxtTableViewCell = tableView.dequeueReusableCell(withIdentifier: "CompanyInfoTxtTableViewCell", for: indexPath) as! CompanyInfoTxtTableViewCell
                
                //companyInfoTxt_TblViewCell.textFld.text = "Other Membership Certification"
                companyInfoTxt_TblViewCell.textFld.text = dict["membership_cert"] as? String
                
                return companyInfoTxt_TblViewCell
            }else if(indexPath.row == 10){
                let companyInfoTxt_TblViewCell:CompanyInfoTxtTableViewCell = tableView.dequeueReusableCell(withIdentifier: "CompanyInfoTxtTableViewCell", for: indexPath) as! CompanyInfoTxtTableViewCell
                
                //companyInfoTxt_TblViewCell.textFld.text = "Licensed Custom House Brokerage Operation"
                companyInfoTxt_TblViewCell.textFld.text = dict["brokarage_opt"] as? String
                
                return companyInfoTxt_TblViewCell
            }else if(indexPath.row == 3){
                let companyInfo_TblViewCell:CompanyInfoTableViewCell = tableView.dequeueReusableCell(withIdentifier: "CompanyInfoTableViewCell", for: indexPath) as! CompanyInfoTableViewCell
                
                companyInfo_TblViewCell.textFld.attributedPlaceholder = NSAttributedString(string: "Motor Carrier/Drayage Company",attributes:[NSAttributedString.Key.foregroundColor:UIColor.black])
                //companyInfo_TblViewCell.textFld.placeholder = "Motor Carrier/Drayage Company"
                companyInfo_TblViewCell.textFld.text = dict["carrier"] as? String
                companyInfo_TblViewCell.textFld.tag = 200 + indexPath.row + 1
                
                return companyInfo_TblViewCell
            }else if(indexPath.row == 4){
                let companyInfo_TblViewCell:CompanyInfoTableViewCell = tableView.dequeueReusableCell(withIdentifier: "CompanyInfoTableViewCell", for: indexPath) as! CompanyInfoTableViewCell
                
                companyInfo_TblViewCell.textFld.attributedPlaceholder = NSAttributedString(string: "Export Packageing Facility in-house",attributes:[NSAttributedString.Key.foregroundColor:UIColor.black])
                //companyInfo_TblViewCell.textFld.placeholder = "Export Packageing Facility in-house"
                companyInfo_TblViewCell.textFld.text = dict["packing_facility"] as? String
                companyInfo_TblViewCell.textFld.tag = 200 + indexPath.row + 1
                
                return companyInfo_TblViewCell
            }else if(indexPath.row == 6){
                let companyInfo_TblViewCell:CompanyInfoTableViewCell = tableView.dequeueReusableCell(withIdentifier: "CompanyInfoTableViewCell", for: indexPath) as! CompanyInfoTableViewCell
                
                companyInfo_TblViewCell.textFld.attributedPlaceholder = NSAttributedString(string: "Export Management Company",attributes:[NSAttributedString.Key.foregroundColor:UIColor.black])
                //companyInfo_TblViewCell.textFld.placeholder = "Export Management Company"
                companyInfo_TblViewCell.textFld.text = dict["meng_company"] as? String
                companyInfo_TblViewCell.textFld.tag = 200 + indexPath.row + 1
                
                return companyInfo_TblViewCell
            }else if(indexPath.row == 7){
                let companyInfo_TblViewCell:CompanyInfoTableViewCell = tableView.dequeueReusableCell(withIdentifier: "CompanyInfoTableViewCell", for: indexPath) as! CompanyInfoTableViewCell
                
                companyInfo_TblViewCell.textFld.attributedPlaceholder = NSAttributedString(string: "International Consultant",attributes:[NSAttributedString.Key.foregroundColor:UIColor.black])
                //companyInfo_TblViewCell.textFld.placeholder = "International Consultant"
                companyInfo_TblViewCell.textFld.text = dict["int_consultant"] as? String
                companyInfo_TblViewCell.textFld.tag = 200 + indexPath.row + 1
                
                return companyInfo_TblViewCell
            }else {
                let companyInfo_TblViewCell:CompanyInfoTableViewCell = tableView.dequeueReusableCell(withIdentifier: "CompanyInfoTableViewCell", for: indexPath) as! CompanyInfoTableViewCell
                
                companyInfo_TblViewCell.textFld.attributedPlaceholder = NSAttributedString(string: "ISO 9002 registered/compliant",attributes:[NSAttributedString.Key.foregroundColor:UIColor.black])
                //companyInfo_TblViewCell.textFld.placeholder = "ISO 9002 registered/compliant"
                companyInfo_TblViewCell.textFld.text = dict["iso9002_registered"] as? String
                companyInfo_TblViewCell.textFld.tag = 200 + indexPath.row + 1
                
                return companyInfo_TblViewCell
            }
            
            
            
            
        }else if(indexPath.section == 3){
            
            let dict = self.fieldArr[indexPath.section]
            
            let company_TblViewCell:CompanyInfoTableViewCell = tableView.dequeueReusableCell(withIdentifier: "CompanyInfoTableViewCell", for: indexPath) as! CompanyInfoTableViewCell
            
            if(indexPath.row == 0){
                company_TblViewCell.textFld.attributedPlaceholder = NSAttributedString(string: "Line 1",attributes:[NSAttributedString.Key.foregroundColor:UIColor.black])
                //company_TblViewCell.textFld.placeholder = "Line 1"
                company_TblViewCell.textFld.text = dict["line1"] as? String
            }else if(indexPath.row == 1){
                company_TblViewCell.textFld.attributedPlaceholder = NSAttributedString(string: "Line 2",attributes:[NSAttributedString.Key.foregroundColor:UIColor.black])
                //company_TblViewCell.textFld.placeholder = "Line 2"
                company_TblViewCell.textFld.text = dict["line2"] as? String
            }else if(indexPath.row == 2){
                company_TblViewCell.textFld.attributedPlaceholder = NSAttributedString(string: "Line 3",attributes:[NSAttributedString.Key.foregroundColor:UIColor.black])
                //company_TblViewCell.textFld.placeholder = "Line 3"
                company_TblViewCell.textFld.text = dict["line3"] as? String
            }else if(indexPath.row == 3){
                company_TblViewCell.textFld.attributedPlaceholder = NSAttributedString(string: "P.O.Box",attributes:[NSAttributedString.Key.foregroundColor:UIColor.black])
                //company_TblViewCell.textFld.placeholder = "P.O.Box"
                company_TblViewCell.textFld.text = dict["p.o.box"] as? String
            }else if(indexPath.row == 4){
                company_TblViewCell.textFld.attributedPlaceholder = NSAttributedString(string: "City",attributes:[NSAttributedString.Key.foregroundColor:UIColor.black])
                //company_TblViewCell.textFld.placeholder = "City"
                company_TblViewCell.textFld.text = dict["city"] as? String
            }else if(indexPath.row == 5){
                company_TblViewCell.textFld.attributedPlaceholder = NSAttributedString(string: "Country",attributes:[NSAttributedString.Key.foregroundColor:UIColor.black])
                //company_TblViewCell.textFld.placeholder = "Country"
                company_TblViewCell.textFld.text = dict["country"] as? String
            }else if(indexPath.row == 6){
                company_TblViewCell.textFld.attributedPlaceholder = NSAttributedString(string: "Phone",attributes:[NSAttributedString.Key.foregroundColor:UIColor.black])
                //company_TblViewCell.textFld.placeholder = "Phone"
                company_TblViewCell.textFld.text = dict["phone"] as? String
            }else {
                company_TblViewCell.textFld.attributedPlaceholder = NSAttributedString(string: "Fax",attributes:[NSAttributedString.Key.foregroundColor:UIColor.black])
                //company_TblViewCell.textFld.placeholder = "Fax"
                company_TblViewCell.textFld.text = dict["fax"] as? String
            }
            
            company_TblViewCell.textFld.tag = 300 + indexPath.row + 1
            
            return company_TblViewCell
            
        }else if(indexPath.section == 4  ){
            
            let dict = self.fieldArr[indexPath.section]
            
            let companyInfoTxt_TblViewCell:CompanyInfoTxtTableViewCell = tableView.dequeueReusableCell(withIdentifier: "CompanyInfoTxtTableViewCell", for: indexPath) as! CompanyInfoTxtTableViewCell
            
                //companyInfoTxt_TblViewCell.textFld.text = "Please explain your reasons:"
            companyInfoTxt_TblViewCell.textFld.text = dict["reasons"] as? String
            
            
            return companyInfoTxt_TblViewCell
            
        }else if(indexPath.section == 5  ){
            
            let dict = self.fieldArr[indexPath.section]
            
            let companyInfoTxt_TblViewCell:CompanyInfoTxtTableViewCell = tableView.dequeueReusableCell(withIdentifier: "CompanyInfoTxtTableViewCell", for: indexPath) as! CompanyInfoTxtTableViewCell
            
                //companyInfoTxt_TblViewCell.textFld.text = "Please explain your reasons:"
            companyInfoTxt_TblViewCell.textFld.text = dict["reasons"] as? String
            
            
            return companyInfoTxt_TblViewCell
            
        }
        else{
            
            let companyInfoBtnViewCell:CompanyInfoButtonTableViewCell = tableView.dequeueReusableCell(withIdentifier: "CompanyInfoButtonTableViewCell", for: indexPath) as! CompanyInfoButtonTableViewCell
            
            companyInfoBtnViewCell.nextBtn.addTarget(self, action: #selector(self.nextbuttonAction(_:)), for: .touchUpInside)
            companyInfoBtnViewCell.previousBtn.addTarget(self, action: #selector(self.previousbuttonAction(_:)), for: .touchUpInside)
            companyInfoBtnViewCell.nextBtn.layer.cornerRadius = 5.0
            companyInfoBtnViewCell.previousBtn.layer.cornerRadius = 5.0
            companyInfoBtnViewCell.backgroundColor = UIColor.white
            return companyInfoBtnViewCell
            
            
        }
        
    }
    
    
    @objc func attachbuttonAction(_ sender:UIButton){
        
        let buttonPosition:CGPoint = sender.convert(CGPoint.zero, to:self.companyInfoTableVw)
        indexPath_for_attachbtnaction = self.companyInfoTableVw.indexPathForRow(at: buttonPosition) as NSIndexPath?
        print("indexPath.row/indexPath.section",indexPath_for_attachbtnaction?.row as Any,indexPath_for_attachbtnaction?.section as Any)
        
        let importMenu = UIDocumentPickerViewController(documentTypes: ["com.apple.iwork.pages.pages", "com.apple.iwork.numbers.numbers", "com.apple.iwork.keynote.key","public.image", "com.apple.application", "public.item","public.data", "public.content", "public.audiovisual-content", "public.movie", "public.audiovisual-content", "public.video", "public.audio", "public.text", "public.data", "public.zip-archive", "com.pkware.zip-archive", "public.composite-content", "public.text",String(kUTTypePDF)], in: .import)
        importMenu.delegate = self
        importMenu.modalPresentationStyle = .formSheet
        self.present(importMenu, animated: true, completion: nil)
        
    }
    
}

extension CompanyInfoViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.activeField = textField
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        let pointInTable = textField.convert(textField.bounds.origin, to: self.companyInfoTableVw)
        let textFieldIndexPath = self.companyInfoTableVw.indexPathForRow(at: pointInTable)
        
        
        
        if(textFieldIndexPath?.section == 0){
            updateDictValue(indexPath: textFieldIndexPath! as NSIndexPath, valueStr: textField.text!)
            let index =  100 + (textFieldIndexPath?.row)! + 1
            self.activeField = view.viewWithTag(index + 1) as? UITextField
            
        }else if(textFieldIndexPath?.section == 1){
            updateDictValue(indexPath: textFieldIndexPath! as NSIndexPath, valueStr: textField.text!)
            let index =  200 + (textFieldIndexPath?.row)! + 1
            self.activeField = view.viewWithTag(index + 1) as? UITextField
            
        }else {
            updateDictValue(indexPath: textFieldIndexPath! as NSIndexPath, valueStr: textField.text!)
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
        NotificationCenter.default.addObserver(self, selector: #selector(CompanyInfoViewController.keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(CompanyInfoViewController.keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        
        
    }
    
    @objc func keyboardWillShow(_ notification:Notification) {
        
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            companyInfoTableVw.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height + 15.0, right: 0)
        }}
    
    
    @objc func keyboardWillHide(_ notification:Notification) {
        
        if ((notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue) != nil {
            companyInfoTableVw.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        }
        
    }
    
}

extension CompanyInfoViewController:UITextViewDelegate{
    
    func registerForTxtViewKeyboardNotification(){
        
        NotificationCenter.default.addObserver(self, selector: #selector(CompanyInfoViewController.updateTextView(notification:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(CompanyInfoViewController.updateTextView(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        //textView.backgroundColor = UIColor.lightGray
        if(textView.text == "FMC Lincenced Foreign Freight Forwarder License" || textView.text == "NVOCC(Non-Vessel-Operating Common Carrier) bond Number" || textView.text == "Custom House Broker - License Number" || textView.text == "IATA Approved Cargo Sales Agents" || textView.text == "ISO9001/2015 registered" || textView.text == "Licensed Custom House Brokerage Operation" || textView.text == "Other Membership Certification" || textView.text == "Summary about the company" || textView.text == "Please state your annual sales volumn for your firm in the US" || textView.text == "Please advice us of you annual tonnage for air and ocean freight" || textView.text == "Please explain your reasons:"){
            
            textView.text = ""
            
        }
        
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        //textView.backgroundColor = UIColor.white
        let pointInTable = textView.convert(textView.bounds.origin, to: self.companyInfoTableVw)
        let textFieldIndexPath = self.companyInfoTableVw.indexPathForRow(at: pointInTable)
        
        updateDictValue(indexPath: textFieldIndexPath! as NSIndexPath, valueStr: textView.text!)
        
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        
        if text == "\n" {
            textView.resignFirstResponder()
            return false
        }
        
        return true
    }
    
    @objc func updateTextView(notification: Notification)
    {
        if let userInfo = notification.userInfo
        {
            let keyboardFrameScreenCoordinates = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
            
            let keyboardFrame = self.view.convert(keyboardFrameScreenCoordinates, to: view.window)
            
            if notification.name == UIResponder.keyboardWillHideNotification{
                view.frame.origin.y = 0
            }
            else{
                view.frame.origin.y = -keyboardFrame.height
            }
        }
    }
    
    
}

extension CompanyInfoViewController:UIDocumentMenuDelegate,UIDocumentPickerDelegate,UINavigationControllerDelegate{
    
    public func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentAt url: URL) {
        let myURL = url as URL
        print(myURL)
        print(url)
        
        print(url.lastPathComponent)
        
        print(url.pathExtension)
        print("import result : \(myURL)")
        
        self.filePath = url.absoluteString
        updateDictValue(indexPath: indexPath_for_attachbtnaction, valueStr: url.lastPathComponent)
        self.companyInfoTableVw.reloadData()
    }
    
    
    public func documentMenu(_ documentMenu:UIDocumentMenuViewController, didPickDocumentPicker documentPicker: UIDocumentPickerViewController) {
        documentPicker.delegate = self
        present(documentPicker, animated: true, completion: nil)
    }
    
    
    func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
        print("view was cancelled")
        dismiss(animated: true, completion: nil)
    }
    
}
