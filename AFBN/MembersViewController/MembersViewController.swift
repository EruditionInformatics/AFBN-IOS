//
//  MembersViewController.swift
//  AFBN
//
//  Created by Erudition Informatics on 29/04/19.
//  Copyright © 2019 Erudition Informatics. All rights reserved.
//

import UIKit

class recentmemberCell:UITableViewCell{
    
    @IBOutlet weak var recentImgVw: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var companyTypeLbl: UILabel!
    @IBOutlet weak var countryNameLbl: UILabel!
    
    @IBOutlet weak var connectBtn: UIButton!
    
}

class invitationCell:UITableViewCell{
    
    @IBOutlet weak var invitationImgVw: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var companyTypeLbl: UILabel!
    @IBOutlet weak var countryNameLbl: UILabel!
    
    @IBOutlet weak var acceptBtn: UIButton!
    @IBOutlet weak var ignoreBtn: UIButton!
    
    
}

class myConnectionCell:UITableViewCell{
   
    @IBOutlet weak var connectionImgVw: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var companyTypeLbl: UILabel!
    @IBOutlet weak var countryNameLbl: UILabel!
    
    @IBOutlet weak var messageBtn: UIButton!
    @IBOutlet weak var requestBtn: UIButton!
    
    
}

class MembersViewController: UIViewController ,urlrequestprotocol{
    
    @IBOutlet weak var invitationBtn: UIButton!
    @IBOutlet weak var createGroupBtn:UIButton!
    @IBOutlet weak var myGroupBtn:UIButton!
    @IBOutlet weak var onlineConnectionBtn:UIButton!
    @IBOutlet weak var membersTableVw:UITableView!
    @IBOutlet weak var recentMemberBtn: UIButton!
    @IBOutlet weak var myConnectionBtn: UIButton!
    @IBOutlet weak var recentLowerLbl: UILabel!
    @IBOutlet weak var connectionLowerLbl: UILabel!
    
    var bgView :UIView!
    var tabBar_Controller: UITabBarController!
    
    var memberArray:NSMutableArray!
    var inviteArray:NSMutableArray!
    var friendArray:NSMutableArray!
    var user_id:String!

    //MARK: View Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        self.friendArray = []
        self.inviteArray = []
        self.memberArray = []
        
        // Do any additional setup after loading the view.
        self.setTopButtonViewCustonDesign()
        self.invitationBtn.isSelected = true
        
        self.recentMemberBtn.isSelected = true
        
        
        let userData = CommonClass.commonSharedInstance.getUserDetailFromDatabase()
        print("userData",userData)
        
        let detailsData = userData[0] as! NSDictionary
        self.user_id = String(describing: detailsData["reg_key"]!)
        print("user_id", self.user_id!)
        self.callApiforMemberList()
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    //MARK: Set Top Button View
    func setTopButtonViewCustonDesign(){
        
        let origImage = UIImage(named: "member_invitation");
        let tintedImage = origImage?.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
        invitationBtn.setImage(origImage, for: .normal)
        invitationBtn.setImage(tintedImage, for: .selected)
        invitationBtn.tintColor = UIColor(red: 255.0/255.0, green: 197.0/255.0, blue: 2/255.0, alpha: 1.0)
        invitationBtn.setBackgroundColor(color: UIColor(red: 92.0/255.0, green: 142.0/255.0, blue: 91.0/255.0, alpha: 1.0), forState: .normal)
        invitationBtn.setBackgroundColor(color: UIColor(red: 21.0/255.0, green: 58.0/255.0, blue: 32.0/255.0, alpha: 1.0), forState: .selected)
        invitationBtn.imageEdgeInsets = UIEdgeInsets(top: 0.0, left: 35.0, bottom: 25.0, right: 0.0)
        invitationBtn.titleEdgeInsets = UIEdgeInsets(top: 0.0, left: -15.0, bottom: 0.0, right: 0.0)
        //invitationBtn.setTitleColor(UIColor(red: 92.0/255.0, green: 142.0/255.0, blue: 91.0/255.0, alpha: 1.0), for: .normal)
        //invitationBtn.setTitleColor(UIColor(red: 21.0/255.0, green: 58.0/255.0, blue: 32.0/255.0, alpha: 1.0), for: .selected)
        
        let origImage1 = UIImage(named: "member_creategroup");
        let tintedImage1 = origImage1?.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
        createGroupBtn.setImage(origImage1, for: .normal)
        createGroupBtn.setImage(tintedImage1, for: .selected)
        createGroupBtn.tintColor = UIColor(red: 255.0/255.0, green: 197.0/255.0, blue: 2/255.0, alpha: 1.0)
        createGroupBtn.setBackgroundColor(color: UIColor(red: 92.0/255.0, green: 142.0/255.0, blue: 91.0/255.0, alpha: 1.0), forState: .normal)
        createGroupBtn.setBackgroundColor(color: UIColor(red: 21.0/255.0, green: 58.0/255.0, blue: 32.0/255.0, alpha: 1.0), forState: .selected)
        createGroupBtn.imageEdgeInsets = UIEdgeInsets(top: 0.0, left: 35.0, bottom: 25.0, right: 0.0)
        createGroupBtn.titleEdgeInsets = UIEdgeInsets(top: 0.0, left: -25.0, bottom: 0.0, right: 0.0)
        //createGroupBtn.setTitleColor(UIColor(red: 92.0/255.0, green: 142.0/255.0, blue: 91.0/255.0, alpha: 1.0), for: .normal)
        //createGroupBtn.setTitleColor(UIColor(red: 21.0/255.0, green: 58.0/255.0, blue: 32.0/255.0, alpha: 1.0), for: .selected)
        
        let origImage2 = UIImage(named: "member_mygroup");
        let tintedImage2 = origImage2?.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
        myGroupBtn.setImage(origImage2, for: .normal)
        myGroupBtn.setImage(tintedImage2, for: .selected)
        myGroupBtn.tintColor = UIColor(red: 255.0/255.0, green: 197.0/255.0, blue: 2/255.0, alpha: 1.0)
        myGroupBtn.setBackgroundColor(color: UIColor(red: 92.0/255.0, green: 142.0/255.0, blue: 91.0/255.0, alpha: 1.0), forState: .normal)
        myGroupBtn.setBackgroundColor(color: UIColor(red: 21.0/255.0, green: 58.0/255.0, blue: 32.0/255.0, alpha: 1.0), forState: .selected)
        myGroupBtn.imageEdgeInsets = UIEdgeInsets(top: 0.0, left: 35.0, bottom: 25.0, right: 0.0)
        myGroupBtn.titleEdgeInsets = UIEdgeInsets(top: 0.0, left: -20.0, bottom: 0.0, right: 10.0)
        //myGroupBtn.setTitleColor(UIColor(red: 92.0/255.0, green: 142.0/255.0, blue: 91.0/255.0, alpha: 1.0), for: .normal)
        //myGroupBtn.setTitleColor(UIColor(red: 21.0/255.0, green: 58.0/255.0, blue: 32.0/255.0, alpha: 1.0), for: .selected)
        
        let origImage3 = UIImage(named: "member_online");
        let tintedImage3 = origImage3?.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
        onlineConnectionBtn.setImage(origImage3, for: .normal)
        onlineConnectionBtn.setImage(tintedImage3, for: .selected)
        onlineConnectionBtn.tintColor = UIColor(red: 255.0/255.0, green: 197.0/255.0, blue: 2/255.0, alpha: 1.0)
        onlineConnectionBtn.setBackgroundColor(color: UIColor(red: 92.0/255.0, green: 142.0/255.0, blue: 91.0/255.0, alpha: 1.0), forState: .normal)
        onlineConnectionBtn.setBackgroundColor(color: UIColor(red: 21.0/255.0, green: 58.0/255.0, blue: 32.0/255.0, alpha: 1.0), forState: .selected)
        onlineConnectionBtn.imageEdgeInsets = UIEdgeInsets(top: 0.0, left: 35.0, bottom: 25.0, right: 0.0)
        onlineConnectionBtn.titleEdgeInsets = UIEdgeInsets(top: 0.0, left: -30.0, bottom: 0.0, right: 0.0)
        //onlineConnectionBtn.setTitleColor(UIColor(red: 92.0/255.0, green: 142.0/255.0, blue: 91.0/255.0, alpha: 1.0), for: .normal)
        //onlineConnectionBtn.setTitleColor(UIColor(red: 21.0/255.0, green: 58.0/255.0, blue: 32.0/255.0, alpha: 1.0), for: .selected)
        
        
    }
    
    func lowerViewButtonSetUp(){
        
        if(self.recentMemberBtn.isSelected == true ){
             //memberArray = ["Member","Member","Member","Member","Member","Member","Member","Member","Member","Member","Member","Member","Member","Member","Member","Member","Member","Member","Member","Member","Member","Member","Member","Member","Member","Member","Member"]
            self.recentLowerLbl.backgroundColor = UIColor.black
            self.connectionLowerLbl.backgroundColor = UIColor.clear
            self.membersTableVw.tag = 1
        }else{
            //memberArray.removeAllObjects()
            self.recentLowerLbl.backgroundColor = UIColor.clear
            self.connectionLowerLbl.backgroundColor = UIColor.black
            self.membersTableVw.tag = 2
        }
        self.membersTableVw.reloadData()
        if(self.memberArray.count <= 0 && self.inviteArray.count <= 0){
            self.membersTableVw.separatorStyle = UITableViewCell.SeparatorStyle.none
            self.setConnectionTableDefaultImage()
        }else{
            self.membersTableVw.separatorStyle = UITableViewCell.SeparatorStyle.singleLine
            if((self.bgView) != nil){
                self.bgView .removeFromSuperview()
                self.bgView = nil
            }
            
        }
        
    }
    
    func setConnectionTableDefaultImage(){
        
        let rec = CGRect(x: 0, y: 0, width: membersTableVw.frame.size.width, height: membersTableVw.frame.size.height)
        bgView = UIView(frame:rec)
        bgView.backgroundColor = UIColor.white
        
        let backgroundImage = UIImage(named: "member_noconnection")
        let imageView = UIImageView(image: backgroundImage)
        imageView.frame = CGRect(x: membersTableVw.frame.size.width/2 - 30.0, y: 60.0, width: 60.0, height: 60.0)
        bgView.addSubview(imageView)
        
        let rect = CGRect(x: 5.0, y: imageView.frame.origin.y + imageView.frame.size.height + 5.0, width:membersTableVw.frame.size.width - 10.0, height: 40.0)
        let label: UILabel = UILabel(frame:rect)
        label.textAlignment = NSTextAlignment.center
        label.font = UIFont(name: "OpenSans-regular", size: 16.0)
        label.text = "You have no connection"
        label.backgroundColor = UIColor.clear
        bgView.addSubview(label)
        
        let rect1 = CGRect(x: 5.0, y: label.frame.origin.y + label.frame.size.height + 5.0, width:membersTableVw.frame.size.width - 10.0, height: 40.0)
        let label1: UILabel = UILabel(frame:rect1)
        label1.textAlignment = NSTextAlignment.center
        label1.font = UIFont(name: "OpenSans-regular", size: 8.0)
        label1.text = "Member you are connected with are listed here"
        label1.backgroundColor = UIColor.clear
        bgView.addSubview(label1)
        
        membersTableVw.backgroundView = bgView
        
    }
    
    //MARK: - Api call for Friend list
    func callApiforFriendList(){
        //CommonClass.commonSharedInstance.showSpinner(onView: self.view)
        UrlRequestClass.UrlRequestSharedInstance.urlrequestDelegate = self
        UrlRequestClass.UrlRequestSharedInstance.getFriendList(user_id: self.user_id!, viewcontroller_class: self, tag: "3")
    }
    
    //MARK: - Api call for Invitation list
    func callApiforInvitationList(){
        //CommonClass.commonSharedInstance.showSpinner(onView: self.view)
        UrlRequestClass.UrlRequestSharedInstance.urlrequestDelegate = self
        UrlRequestClass.UrlRequestSharedInstance.getInvitationList(user_id: self.user_id!, viewcontroller_class: self, tag: "2")
    }
    
    //MARK: - Api call for Member list
    func callApiforMemberList(){
        CommonClass.commonSharedInstance.showSpinner(onView: self.view)
        UrlRequestClass.UrlRequestSharedInstance.urlrequestDelegate = self
        UrlRequestClass.UrlRequestSharedInstance.getMemberList(user_id: self.user_id!, viewcontroller_class: self, tag: "1")
    }
    
    //MARK: - Button Action
    
    @IBAction func invitationBtnAction(_ sender: UIButton) {
        invitationBtn.isSelected = true
        createGroupBtn.isSelected = false
        myGroupBtn.isSelected = false
        onlineConnectionBtn.isSelected = false
    }
    @IBAction func createGroupBtnAction(_ sender: UIButton) {
        invitationBtn.isSelected = false
        createGroupBtn.isSelected = true
        myGroupBtn.isSelected = false
        onlineConnectionBtn.isSelected = false
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let createGroupController = storyBoard.instantiateViewController(withIdentifier: "CreateGroupViewController") as! CreateGroupViewController
        //self.present(singInController, animated: true, completion: nil)
        createGroupController.hidesBottomBarWhenPushed = false
        self.navigationController?.pushViewController(createGroupController, animated: true)
        
    }
    @IBAction func myGroupBtnAction(_ sender: UIButton) {
        invitationBtn.isSelected = false
        createGroupBtn.isSelected = false
        myGroupBtn.isSelected = true
        onlineConnectionBtn.isSelected = false
    }
    @IBAction func onlineConnectionBtnAction(_ sender: UIButton) {
        invitationBtn.isSelected = false
        createGroupBtn.isSelected = false
        myGroupBtn.isSelected = false
        onlineConnectionBtn.isSelected = true
    }
    @IBAction func recentMemberBtnAction(_ sender: UIButton) {
        recentMemberBtn.isSelected = true
        myConnectionBtn.isSelected = false
        lowerViewButtonSetUp()
    }
    @IBAction func myConnectionBtnAction(_ sender: UIButton) {
        self.recentMemberBtn.isSelected = false
        self.myConnectionBtn.isSelected = true
        self.callApiforFriendList()
        
    }
    @objc func message_buttonSelected(sender: UIButton){
        
        let buttonPosition:CGPoint = sender.convert(CGPoint.zero, to:self.membersTableVw)
        let indexPath = self.membersTableVw.indexPathForRow(at: buttonPosition)
        print(indexPath!.row)
        
        let dict = self.friendArray[indexPath!.row] as! NSDictionary
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let chatController = storyBoard.instantiateViewController(withIdentifier: "ChatViewController") as! ChatViewController
        chatController.chatUserDict = dict
        chatController.hidesBottomBarWhenPushed = true
        //self.present(singInController, animated: true, completion: nil)
        self.navigationController?.pushViewController(chatController, animated: true)
    }
    
    //MARK: - Url request delegates method
    func urlrequestfinish_with_success(data: NSDictionary, requestType: String, request_class: UIViewController, tag: String) {
        
        if(tag == "1"){
            
            self.callApiforInvitationList()
            DispatchQueue.main.async{
                
                //CommonClass.commonSharedInstance.removeSpinner()
                print(data)
                let statusCode = data["code"] as! String
                
                if(statusCode == "0"){
                    
                    self.memberArray = (data["message"] as! NSMutableArray)
                    //self.membersTableVw.reloadData()
                    
                }else{
                    DispatchQueue.main.async{
                        //CommonClass.commonSharedInstance.removeSpinner()
                        //CommonClass.commonSharedInstance.show_alert(alert_title: "AFBN", btn_title: "Ok", msg: "Something error occured.", presentingClass: self)
                        print(data["message"] as! String)
                    }
                }
                
            }
            
        }else if(tag == "2"){
            DispatchQueue.main.async{
                
                CommonClass.commonSharedInstance.removeSpinner()
                print(data)
                let statusCode = data["code"] as! String
                
                if(statusCode == "0"){
                    
                    self.inviteArray = (data["message"] as! NSMutableArray)
                    //self.membersTableVw.reloadData()
                    self.lowerViewButtonSetUp()
                    
                }else{
                    DispatchQueue.main.async{
                        CommonClass.commonSharedInstance.removeSpinner()
                        //CommonClass.commonSharedInstance.show_alert(alert_title: "AFBN", btn_title: "Ok", msg: "Something error occured.", presentingClass: self)
                        print(data["message"] as! String)
                        if(self.memberArray.count > 0){
                            self.lowerViewButtonSetUp()
                        }
                    }
                }
                
            }
        }else if(tag == "3"){
            DispatchQueue.main.async{
                
                CommonClass.commonSharedInstance.removeSpinner()
                print(data)
                let statusCode = data["code"] as! String
                
                if(statusCode == "0"){
                    
                    self.friendArray = (data["message"] as! NSMutableArray)
                    //self.membersTableVw.reloadData()
                    self.lowerViewButtonSetUp()
                    
                }else{
                    DispatchQueue.main.async{
                        CommonClass.commonSharedInstance.removeSpinner()
                        //CommonClass.commonSharedInstance.show_alert(alert_title: "AFBN", btn_title: "Ok", msg: "Something error occured.", presentingClass: self)
                        print(data["message"] as! String)
                    }
                }
                
            }
        }
        
        
    }
    
    func urlrequestfinish_with_error(error: Error) {
        DispatchQueue.main.async{
            
            CommonClass.commonSharedInstance.removeSpinner()
            
        }
        print(error)
    }

}

extension UIButton {
    
    func setBackgroundColor(color: UIColor, forState: UIControl.State) {
        UIGraphicsBeginImageContext(CGSize(width: 1, height: 1))
        UIGraphicsGetCurrentContext()!.setFillColor(color.cgColor)
        UIGraphicsGetCurrentContext()!.fill(CGRect(x: 0, y: 0, width: 1, height: 1))
        let colorImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        self.setBackgroundImage(colorImage, for: forState)
    }
    
}

extension MembersViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if(self.membersTableVw.tag == 1){
            
            if(self.inviteArray.count > 0){
                
                if(self.inviteArray.count > 2){
                    return self.memberArray.count + 2
                }else{
                    return self.memberArray.count + 1
                }
                
            }else{
                return self.memberArray.count
            }
            
        }else{
            return self.friendArray.count
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        if(membersTableVw.tag == 1){
            
            let rect = CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 60.0)
            let footerView = UIView(frame:rect)
            footerView.backgroundColor = UIColor(red: 92.0/255.0, green: 142.0/255.0, blue: 91.0/255.0, alpha: 1.0)
            
            let rect1 = CGRect(x: 5.0, y: 10.0, width: 150.0, height: 40.0)
            let label: UILabel = UILabel(frame:rect1)
            label.textAlignment = NSTextAlignment.left
            label.font = UIFont(name: "OpenSans-regular", size: 22.0)
            label.backgroundColor = UIColor.clear
            if(self.inviteArray.count > 0){
                let inviteCount = String(describing: self.inviteArray.count)
                label.text = "Invitition " + "(" + inviteCount + ")"
            }else{
                label.text = "No invitition"
            }
            
            
            footerView.addSubview(label)
            
            let rect2 = CGRect(x: footerView.frame.origin.x + footerView.frame.size.width - 160, y: 10.0, width: 150.0, height: 40.0)
            /*let attributes : [NSAttributedString.Key: Any] = [
             NSAttributedString.Key(rawValue: NSAttributedString.Key.font.rawValue) : UIFont(name: "OpenSans-regular", size: 10.0) as Any,
             NSAttributedString.Key(rawValue: NSAttributedString.Key.foregroundColor.rawValue) : UIColor.white,
             NSAttributedString.Key(rawValue: NSAttributedString.Key.underlineStyle.rawValue) : NSUnderlineStyle.single.rawValue]*/
            let btn: UIButton = UIButton(frame:rect2)
            /*btn.setTitle("Manage All", for: .normal)
            btn.titleLabel?.textAlignment = NSTextAlignment.right
            btn.titleLabel?.font = UIFont(name: "OpenSans-regular", size: 22.0)
            btn.titleLabel?.textColor = UIColor.white*/
            
            let attributeString = NSMutableAttributedString(string: "Manage All", attributes: [
                NSAttributedString.Key.font :UIFont.systemFont(ofSize: 16.0),
                NSAttributedString.Key.foregroundColor : UIColor.white,
                NSAttributedString.Key.underlineStyle:1.0
                ])
            btn.setAttributedTitle(attributeString, for: .normal)
            
            btn.addTarget(self, action: #selector(self.manageAllbuttonAction(_:)), for: .touchUpInside)
            btn.backgroundColor = UIColor.clear
            
            footerView.addSubview(btn)
            
            return footerView
            
        }else{
            let rect = CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 0.0)
            let footerView = UIView(frame:rect)
            return footerView
        }
        
        
    }
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        if(membersTableVw.tag == 1){
            return 60
        }else{
            return 0
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
        
        return 100
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if(self.membersTableVw.tag == 1){
            
            if(self.inviteArray.count > 0){
                
                if(self.inviteArray.count > 2){
                    if(indexPath.row == 0 && indexPath.row == 1){
                        let dict = self.inviteArray[indexPath.row] as! NSDictionary
                        
                        let invitation_Cell:invitationCell = tableView.dequeueReusableCell(withIdentifier: "invitationCell", for: indexPath) as! invitationCell
                        invitation_Cell.contentView.backgroundColor = UIColor(red: 92.0/255.0, green: 142.0/255.0, blue: 91.0/255.0, alpha: 1.0)
                        invitation_Cell.invitationImgVw.isUserInteractionEnabled = true
                        invitation_Cell.invitationImgVw.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(imageTapped)))
                        invitation_Cell.titleLbl.isUserInteractionEnabled = true
                        invitation_Cell.titleLbl.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(labelTapped)))
                        invitation_Cell.titleLbl.text = (dict["reg_key_cont_name"] as! String)
                        invitation_Cell.companyTypeLbl.text = (dict["company_name"] as! String)
                        invitation_Cell.countryNameLbl.text = (dict["coutry"] as! String)
                        
                        return invitation_Cell
                        
                    }else{
                        let dict = self.memberArray[indexPath.row] as! NSDictionary
                        
                        let recent_memberCell:recentmemberCell = tableView.dequeueReusableCell(withIdentifier: "recentmemberCell", for: indexPath) as! recentmemberCell
                        
                        recent_memberCell.recentImgVw.isUserInteractionEnabled = true
                        recent_memberCell.recentImgVw.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(imageTapped)))
                        recent_memberCell.titleLbl.isUserInteractionEnabled = true
                        recent_memberCell.titleLbl.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(labelTapped)))
                        recent_memberCell.titleLbl.text = (dict["reg_key_cont_name"] as! String)
                        recent_memberCell.companyTypeLbl.text = (dict["company_name"] as! String)
                        recent_memberCell.countryNameLbl.text = (dict["coutry"] as! String)
                        
                        return recent_memberCell
                        
                    }
                }else{
                    if(indexPath.row == 0){
                        let dict = self.inviteArray[indexPath.row] as! NSDictionary
                        
                        let invitation_Cell:invitationCell = tableView.dequeueReusableCell(withIdentifier: "invitationCell", for: indexPath) as! invitationCell
                        invitation_Cell.contentView.backgroundColor = UIColor(red: 92.0/255.0, green: 142.0/255.0, blue: 91.0/255.0, alpha: 1.0)
                        invitation_Cell.invitationImgVw.isUserInteractionEnabled = true
                        invitation_Cell.invitationImgVw.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(imageTapped)))
                        invitation_Cell.titleLbl.isUserInteractionEnabled = true
                        invitation_Cell.titleLbl.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(labelTapped)))
                        invitation_Cell.titleLbl.text = (dict["reg_key_cont_name"] as! String)
                        invitation_Cell.companyTypeLbl.text = (dict["company_name"] as! String)
                        invitation_Cell.countryNameLbl.text = (dict["coutry"] as! String)
                        
                        return invitation_Cell
                        
                    }else{
                        let dict = self.memberArray[indexPath.row] as! NSDictionary
                        
                        let recent_memberCell:recentmemberCell = tableView.dequeueReusableCell(withIdentifier: "recentmemberCell", for: indexPath) as! recentmemberCell
                        
                        recent_memberCell.recentImgVw.isUserInteractionEnabled = true
                        recent_memberCell.recentImgVw.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(imageTapped)))
                        recent_memberCell.titleLbl.isUserInteractionEnabled = true
                        recent_memberCell.titleLbl.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(labelTapped)))
                        
                        recent_memberCell.titleLbl.text = (dict["reg_key_cont_name"] as! String)
                        recent_memberCell.companyTypeLbl.text = (dict["company_name"] as! String)
                        recent_memberCell.countryNameLbl.text = (dict["coutry"] as! String)
                        
                        return recent_memberCell
                        
                    }
                }
                
            }else{
                let dict = self.memberArray[indexPath.row] as! NSDictionary
                
                let recent_memberCell:recentmemberCell = tableView.dequeueReusableCell(withIdentifier: "recentmemberCell", for: indexPath) as! recentmemberCell
                
                recent_memberCell.recentImgVw.isUserInteractionEnabled = true
                recent_memberCell.recentImgVw.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(imageTapped)))
                recent_memberCell.titleLbl.isUserInteractionEnabled = true
                recent_memberCell.titleLbl.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(labelTapped)))
                recent_memberCell.titleLbl.text = (dict["reg_key_cont_name"] as! String)
                recent_memberCell.companyTypeLbl.text = (dict["company_name"] as! String)
                recent_memberCell.countryNameLbl.text = (dict["coutry"] as! String)
                
                return recent_memberCell
            }
            
            
        }else{
            let dict = self.friendArray[indexPath.row] as! NSDictionary
            
            let myConnection_Cell:myConnectionCell = tableView.dequeueReusableCell(withIdentifier: "myConnectionCell", for: indexPath) as! myConnectionCell
            
            myConnection_Cell.connectionImgVw.isUserInteractionEnabled = true
            myConnection_Cell.connectionImgVw.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(imageTapped)))
            myConnection_Cell.titleLbl.isUserInteractionEnabled = true
            myConnection_Cell.titleLbl.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(labelTapped)))
            myConnection_Cell.titleLbl.text = (dict["reg_key_cont_name"] as! String)
            myConnection_Cell.companyTypeLbl.text = (dict["company_1_type"] as! String)
            myConnection_Cell.countryNameLbl.text = (dict["coutry"] as! String)
            myConnection_Cell.messageBtn.addTarget(self, action: #selector(message_buttonSelected), for: .touchUpInside)
            return myConnection_Cell
            
        }
        
    }
    
    
    //MARK:The target function
    @objc func manageAllbuttonAction(_ sender: UIButton){
        print("manageAllbuttonAction\(sender)")
        
    }
    
    //MARK: Tap gesture methods
    @objc private func imageTapped(_ recognizer: UITapGestureRecognizer) {
        print("image tapped")
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let memberDetailsController = storyBoard.instantiateViewController(withIdentifier: "MemberDetailsViewController") as! MemberDetailsViewController
        //self.present(singInController, animated: true, completion: nil)
        memberDetailsController.hidesBottomBarWhenPushed = false
        self.navigationController?.pushViewController(memberDetailsController, animated: true)
    }
    
    @objc private func labelTapped(_ recognizer: UITapGestureRecognizer) {
        print("label Tapped")
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let memberDetailsController = storyBoard.instantiateViewController(withIdentifier: "MemberDetailsViewController") as! MemberDetailsViewController
        //self.present(singInController, animated: true, completion: nil)
        memberDetailsController.hidesBottomBarWhenPushed = false
        self.navigationController?.pushViewController(memberDetailsController, animated: true)
    }
    
    
}
