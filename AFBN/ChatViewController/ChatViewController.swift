//
//  ChatViewController.swift
//  ChatmachineApp
//
//  Created by Erudition Informatics on 14/05/19.
//  Copyright © 2019 Erudition Informatics. All rights reserved.
//

import UIKit
//import XMPPFramework


class sendChatCell:UITableViewCell{
    @IBOutlet weak var chatmsgLblVw:UIView!
    @IBOutlet weak var chatmsgLbl:UILabel!
    @IBOutlet weak var timeLbl:UILabel!
    @IBOutlet weak var senderNameLbl:UILabel!
}

class receivedChatCell:UITableViewCell{
    @IBOutlet weak var chatmsgLblVw:UIView!
    @IBOutlet weak var chatmsgLbl:UILabel!
    @IBOutlet weak var timeLbl:UILabel!
    @IBOutlet weak var recevierNameLbl:UILabel!
}

class ChatViewController: UIViewController,urlrequestprotocol,XMPPControllerDelegate {
    
    
    @IBOutlet weak var topVw:UIView!
    @IBOutlet weak var userImgVw:UIImageView!
    @IBOutlet weak var userNameLbl:UILabel!
    @IBOutlet weak var lastTimeLbl:UILabel!
    @IBOutlet weak var callBtn:UIButton!
    @IBOutlet weak var videoBtn:UIButton!
    @IBOutlet weak var chatListVw:UITableView!
    
    @IBOutlet weak var attachBtn:UIButton!
    @IBOutlet weak var camBtn:UIButton!
    @IBOutlet weak var sendmsgBtn:UIButton!
    @IBOutlet weak var msgTxtFld:UITextView!
    @IBOutlet weak var subBottomVw:UIView!
    
    @IBOutlet weak var bottomVw:UIView!
    @IBOutlet weak var backBtn:UIButton!
    
    @IBOutlet weak var moreBtn:UIButton!
    
    
    var isFromEmailPage:String!
    var gradient:CAGradientLayer!
    var gradient1:CAGradientLayer!
    //var gradient2:CAGradientLayer!
    //var gradient3:CAGradientLayer!
    
    var chatUserDict: NSDictionary!
    var msgDetailsArr:NSMutableArray = []
    var lblSizeArr:NSMutableArray = []
    
    var isChatMsg:Bool = false
    var isKeyboardOn:Bool = true
    
    
    //var stream:XMPPStream!
    
    //MARK:View cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        //setGradient()
        setTopVw_fromphone()
        //setTopVw_fromemail()
        registerForTxtViewKeyboardNotification()
        
    }
    
    

    
    override var shouldAutomaticallyForwardAppearanceMethods: Bool {
        return true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        //gradient.frame = self.topVw.bounds
        //gradient1.frame = self.topVw.bounds
        
        ///////////////
        self.perform(#selector(self.setChatUser), with: nil, afterDelay: 1.5)
        
        
        
        ///////////////////////////
        
        
        //self.perform(#selector(callApiWithDelay), with: nil, afterDelay: 0.5)

    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
        
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        UrlRequestClass.UrlRequestSharedInstance.urlrequestDelegate = nil
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    @objc func setChatUser(dict:NSDictionary){
        
        print("chatUserDict",self.chatUserDict as NSDictionary)
        //UserDefaults.standard.set((chatUserDict["key"] as? String)!, forKey: "chat_user_key")
        //var chatuserkey = ""
        /*if((chatUserDict["type"])as? String == "group_chat"){
            
            var chatuserkey = (chatUserDict["key"] as? String)!
            chatuserkey = chatuserkey.lowercased()
            //print("chatuserkey",chatuserkey as Any)
            let userName = UserDefaults.standard.string(forKey: "user_name")
            //print("userName",userName!)
            
            
            XMPPController.XMPPControllerSharedInstance.xmppControllerDelegate = self
            //XMPPController.XMPPControllerSharedInstance.reconnect(userKey: chatuserkey)
            XMPPController.XMPPControllerSharedInstance.setChatRoomForGroup(groupID: chatuserkey, userName:userName! )
            
        }else if((chatUserDict["type"])as? String == "broadcast"){
            
            if((chatUserDict["chatroom_admin"])as? String == "yes"){
                self.bottomVw.isHidden = false
            }else{
                self.bottomVw.isHidden = true
            }
            
            var chatuserkey = (chatUserDict["key"] as? String)!
            chatuserkey = chatuserkey.lowercased()
            //print("chatuserkey",chatuserkey as Any)
            let userName = UserDefaults.standard.string(forKey: "user_name")
            //print("userName",userName!)
            
            XMPPController.XMPPControllerSharedInstance.xmppControllerDelegate = self
            //XMPPController.XMPPControllerSharedInstance.reconnect(userKey: chatuserkey)
            XMPPController.XMPPControllerSharedInstance.setChatRoomForGroup(groupID: chatuserkey, userName:userName! )
            
        }else if((chatUserDict["type"])as? String == "two_user"){*/
            
            var chatuserkey = (chatUserDict["reg_key"] as? String)!
            chatuserkey = chatuserkey.lowercased()
            //print("chatuserkey",chatuserkey as Any)
            XMPPController.XMPPControllerSharedInstance.xmppControllerDelegate = self
            XMPPController.XMPPControllerSharedInstance.reconnect(userKey: chatuserkey)
            
        //}
        
    }
    
    //MARK: Call Api with delay
    @objc func callApiWithDelay(){
        getUser_msglist_ForPhoneLogin()
    }
    //MARK: reloadTblVw_afterDelay
    @objc func reloadTblVw_afterDelay(){
        self.chatListVw.reloadData()
        self.reloadTblVw()
    }
    
    
    
    //MARK: Call Api for msg list for phone login
    func getUser_msglist_ForPhoneLogin(){
        
        let userkey = UserDefaults.standard.string(forKey: "user_key")
        //print("userkey",userkey as Any)
        
        if((chatUserDict["type"])as? String != "group_chat" && (chatUserDict["type"])as? String != "broadcast"){
            
            let chatuserkey = chatUserDict["reg_key"] as? String
            //print("chatuserkey",chatuserkey as Any)
            isChatMsg = true
            
            if Reachability.isConnectedToNetwork(){
                
                //CommonClass.commonSharedInstance.showSpinner(onView: self.view)
                UrlRequestClass.UrlRequestSharedInstance.urlrequestDelegate = self
                //UrlRequestClass.UrlRequestSharedInstance.getMsglist_twouser_fromphone(user_1: userkey!, user_2: chatuserkey!, startlimit: "0",searchtype:"user",viewcontroller_class: self)
                
            }else{
                
                //print("Internet Connection not Available!")
                show_alert(alert_title: "Chatmachine", btn_title: "Ok", msg: "Internet Connection not Available!")
                DispatchQueue.main.async{
                    CommonClass.commonSharedInstance.removeSpinner()
                }
                
            }
            
        }else{
            
            let group_chatkey = chatUserDict["key"] as? String
            //print("chatuserkey",group_chatkey as Any)
            isChatMsg = true
            
            if Reachability.isConnectedToNetwork(){
                
                //CommonClass.commonSharedInstance.showSpinner(onView: self.view)
                UrlRequestClass.UrlRequestSharedInstance.urlrequestDelegate = self
                //UrlRequestClass.UrlRequestSharedInstance.getMsglist_twouser_fromphone(user_1: userkey!, user_2: group_chatkey!, startlimit: "0",searchtype:"group",viewcontroller_class: self)
                
            }else{
                
                //print("Internet Connection not Available!")
                show_alert(alert_title: "Chatmachine", btn_title: "Ok", msg: "Internet Connection not Available!")
                DispatchQueue.main.async{
                    CommonClass.commonSharedInstance.removeSpinner()
                }
                
            }
            
        }
        
    }
    
    //MARK: Create More view
    /*func createMoreView(){
        
        //let y_Padding = self.topVw.frame.origin.y + self.topVw.frame.size.height
        self.moreVw = (Bundle.main.loadNibNamed("MoreView", owner: self, options: nil)?.first as! MoreView)
        self.moreVw.tableItemArr = ["View Info","Mute Nptification","Clear chat","Block"]
        self.moreVw.frame = CGRect(x: 0.0, y: 0.0, width: self.view.frame.size.width, height: self.view.frame.size.height)
        self.moreVw.moreVwDelegate = self
        self.moreVw.setView()
        
        self.view.addSubview(self.moreVw)
        
    }*/
    
    //MARK: Set Gradient
    func setGradient(){
        
        gradient = CAGradientLayer()
        gradient.frame = topVw.bounds
        gradient.colors = [UIColor(red: 71.0/255.0, green: 40.0/255.0, blue: 158.0/255.0, alpha: 1.0).cgColor, UIColor(red: 100.0/255.0, green: 83.0/255.0, blue: 181.0/255.0, alpha: 1.0).cgColor]
        
        gradient1 = CAGradientLayer()
        gradient1.frame = topVw.bounds
        gradient1.colors = [UIColor(red: 9.0/255.0, green: 253.0/255.0, blue: 255.0/255.0, alpha: 1.0).cgColor, UIColor(red: 88.0/255.0, green: 252.0/255.0, blue: 252.0/255.0, alpha: 1.0).cgColor]
        
        /*gradient2 = CAGradientLayer()
         gradient2.frame = bottomVw.bounds
         gradient2.colors = [UIColor(red: 71.0/255.0, green: 40.0/255.0, blue: 158.0/255.0, alpha: 1.0).cgColor, UIColor(red: 100.0/255.0, green: 83.0/255.0, blue: 181.0/255.0, alpha: 1.0).cgColor]
         
         gradient3 = CAGradientLayer()
         gradient3.frame = bottomVw.bounds
         gradient3.colors = [UIColor(red: 9.0/255.0, green: 253.0/255.0, blue: 255.0/255.0, alpha: 1.0).cgColor, UIColor(red: 88.0/255.0, green: 252.0/255.0, blue: 252.0/255.0, alpha: 1.0).cgColor]*/
        
        //setTopVw_fromemail()
        //setTopVw_fromphone()
        
    }
    
    //MARK: setTopVw
    func setTopVw_fromemail(){
        
        //topVw.layer.insertSublayer(gradient, at: 0)
        
        //tabBarController?.tabBar.layer.insertSublayer(gradient, at: 0)
        
        userImgVw.layer.cornerRadius = 20
        userNameLbl.textColor = UIColor.white
        lastTimeLbl.textColor = UIColor.white
        var chatusername = ""
        if((chatUserDict["reg_key_cont_name"]) != nil){
            chatusername = (chatUserDict["reg_key_cont_name"] as? String)!
            //print("chatuserkey",chatusername as Any)
        }
        userNameLbl.text = chatusername
        
        //let image0 = UIImage(named: "callicon")
        //self.callBtn.setImage(image0?.maskWithColor(color: UIColor.white)?.withRenderingMode(.alwaysOriginal), for: UIControl.State.normal)
        //let image1 = UIImage(named: "videoicon")
        //self.videoBtn.setImage(image1?.maskWithColor(color: UIColor.white)?.withRenderingMode(.alwaysOriginal), for: UIControl.State.normal)
        //let image2 = UIImage(named: "backbtn")
        //self.backBtn.setImage(image2?.maskWithColor(color: UIColor.white)?.withRenderingMode(.alwaysOriginal), for: UIControl.State.normal)
        //let image3 = UIImage(named: "attachtabwhite")
        //self.attachBtn.setImage(image3?.maskWithColor(color: UIColor.white)?.withRenderingMode(.alwaysOriginal), for: UIControl.State.normal)
        //let image4 = UIImage(named: "cambtn")
        //self.camBtn.setImage(image4?.maskWithColor(color: UIColor.white)?.withRenderingMode(.alwaysOriginal), for: UIControl.State.normal)
        //let image5 = UIImage(named: "sendBtn")
        //self.sendmsgBtn.setImage(image5?.maskWithColor(color: UIColor.white)?.withRenderingMode(.alwaysOriginal), for: UIControl.State.normal)
        
        //let image6 = UIImage(named: "morebtn")
        //self.moreBtn.setImage(image6?.maskWithColor(color: UIColor.white)?.withRenderingMode(.alwaysOriginal), for: UIControl.State.normal)
        //self.moreBtn.setImage(image6?.maskWithColor(color: UIColor.white)?.withRenderingMode(.alwaysOriginal), for: UIControl.State.selected)
        
        //bottomVw.layer.insertSublayer(gradient2, at: 0)
        //msgTxtFld.layer.cornerRadius = 20
        //msgTxtFld.layer.borderWidth = 1
        //msgTxtFld.layer.borderColor = UIColor.darkGray.cgColor
        
        self.subBottomVw.layer.cornerRadius = 25
        self.subBottomVw.layer.borderWidth = 1
        self.subBottomVw.layer.borderColor = UIColor.darkGray.cgColor
        self.subBottomVw.backgroundColor = UIColor.clear
        
        
    }
    
    func setTopVw_fromphone(){
        
        //topVw.layer.insertSublayer(gradient1, at: 0)
        
        //tabBarController?.tabBar.layer.insertSublayer(gradient1, at: 0)
        
        userImgVw.layer.cornerRadius = 20
        userNameLbl.textColor = UIColor.darkGray
        lastTimeLbl.textColor = UIColor.darkGray
        /*if((chatUserDict["type"])as? String != "group_chat"){
            
            var chatusername = ""
            if((chatUserDict["name"]) != nil){
                chatusername = (chatUserDict["name"] as? String)!
                //print("chatuserkey",chatusername as Any)
            }
            userNameLbl.text = chatusername
            
        }else{*/
            
            var chatusername = ""
            if((chatUserDict["reg_key_cont_name"]) != nil){
                chatusername = (chatUserDict["reg_key_cont_name"] as? String)!
                //print("chatuserkey",chatusername as Any)
            }
            userNameLbl.text = chatusername
            
        //}
        
        
        //let image0 = UIImage(named: "callicon")
        //self.callBtn.setImage(image0?.maskWithColor(color: UIColor.darkGray)?.withRenderingMode(.alwaysOriginal), for: UIControl.State.normal)
        //let image1 = UIImage(named: "videoicon")
        //self.videoBtn.setImage(image1?.maskWithColor(color: UIColor.darkGray)?.withRenderingMode(.alwaysOriginal), for: UIControl.State.normal)
        //let image2 = UIImage(named: "backbtn")
        //self.backBtn.setImage(image2?.maskWithColor(color: UIColor.darkGray)?.withRenderingMode(.alwaysOriginal), for: UIControl.State.normal)
        //let image3 = UIImage(named: "attachtabwhite")
        //self.attachBtn.setImage(image3?.maskWithColor(color: UIColor.darkGray)?.withRenderingMode(.alwaysOriginal), for: UIControl.State.normal)
        //let image4 = UIImage(named: "cambtn")
        //self.camBtn.setImage(image4?.maskWithColor(color: UIColor.darkGray)?.withRenderingMode(.alwaysOriginal), for: UIControl.State.normal)
        //let image5 = UIImage(named: "sendBtn")
        //self.sendmsgBtn.setImage(image5?.maskWithColor(color: UIColor.darkGray)?.withRenderingMode(.alwaysOriginal), for: UIControl.State.normal)
        
        //let image6 = UIImage(named: "morebtn")
        //self.moreBtn.setImage(image6?.maskWithColor(color: UIColor.darkGray)?.withRenderingMode(.alwaysOriginal), for: UIControl.State.normal)
        //self.moreBtn.setImage(image6?.maskWithColor(color: UIColor.darkGray)?.withRenderingMode(.alwaysOriginal), for: UIControl.State.selected)
        
        //bottomVw.layer.insertSublayer(gradient3, at: 0)
        //msgTxtFld.layer.cornerRadius = 20
        //msgTxtFld.layer.borderWidth = 1
        //msgTxtFld.layer.borderColor = UIColor.darkGray.cgColor
        
        self.subBottomVw.layer.cornerRadius = 25
        self.subBottomVw.layer.borderWidth = 1
        self.subBottomVw.layer.borderColor = UIColor.darkGray.cgColor
        self.subBottomVw.backgroundColor = UIColor.clear
        
    }
    
    func reloadTblVw(){
        
        //let indexPath = NSIndexPath(row: 19, section: 0)
        //self.chatListVw.scrollToRow(at: indexPath as IndexPath, at: UITableView.ScrollPosition.bottom , animated: true)
        DispatchQueue.main.async {
            self.chatListVw.scrollToBottom()
        }
        
    }
    
    //MARK: Show alert view
    func show_alert(alert_title:String,btn_title:String,msg:String){
        
        let alert = UIAlertController(title: alert_title, message: msg, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: btn_title, style: .default, handler: { action in
            switch action.style{
            case .default:
                print("default")
                
            case .cancel:
                print("cancel")
                
            case .destructive:
                print("destructive")
                
                
            @unknown default:
                print("default")
            }}))
        self.present(alert, animated: true, completion: nil)
        
    }
    
    //MARK:Urlrequest Delegates Methods
    
    func urlrequestfinish_with_success(data: NSDictionary, requestType:String,request_class:UIViewController,tag: String) {
        
        if(request_class == self){
            
            //print("viewcontroller method ::-",data)
            if(requestType == Constant.MSGLIST_TWOUSER_URL){
                DispatchQueue.main.async{
                    DispatchQueue.main.async{
                        CommonClass.commonSharedInstance.removeSpinner()
                        self.isChatMsg = false
                        self.msgDetailsArr = (data["message"] as! NSMutableArray)
                        //print("msgDetailsArr::",self.msgDetailsArr)
                        //self.setLabelSize()
                        self.perform(#selector(self.reloadTblVw_afterDelay), with: nil, afterDelay: 0.0)
                        self.chatListVw.reloadData()
                        self.chatListVw.layoutIfNeeded()
                        self.chatListVw.layoutSubviews()
                        //self.reloadTblVw()
                    }
                    
                }
            }else if(requestType == Constant.MSGSEND_TWOUSER_URL){
                DispatchQueue.main.async{
                    DispatchQueue.main.async{
                        CommonClass.commonSharedInstance.removeSpinner()
                    }
                    self.msgTxtFld.text = ""
                    self.getUser_msglist_ForPhoneLogin()
                }
                
            }
        }else{
            print("ChatmachineApp other class request")
        }
    }
    
    func urlrequestfinish_with_error(error: Error) {
        //print("viewcontroller method ::-",error)
        show_alert(alert_title: "Chatmachine", btn_title: "Ok", msg: error as! String)
        DispatchQueue.main.async{
            CommonClass.commonSharedInstance.removeSpinner()
        }
    }
    
    //MARK:XMPPController Delegates Method
    func setLastTime(sec: Int){
        
        let min = sec/60
        
        if(min > 60){
            
            let hr = Double(sec/3600)
            let hour = Int(hr)
            
            if(hour > 24){
                
                self.lastTimeLbl.text =  "Offline"
                
            }else{
                
                self.lastTimeLbl.text = String(describing: hour) + "hour ago last seen"
                
            }
            
        }else if (min == 0){
            
            self.lastTimeLbl.text =  "Online"
            
        }else{
            
            self.lastTimeLbl.text = String(describing: min) + "min ago last seen"
            
        }
        
    }
    
    func getMsg(msgTxt: String) {
        
        let msgArr = msgTxt.components(separatedBy: "-")
        let msgTxt = msgArr[1]
        let userkey = UserDefaults.standard.string(forKey: "user_key")
        //print("userkey",userkey as Any)
        var chatuserkey = ""
        //if((chatUserDict["type"])as? String != "group_chat" && (chatUserDict["type"])as? String != "broadcast"){
            chatuserkey = (chatUserDict["reg_key"] as? String)!
            //print("chatuserkey",chatuserkey as Any)
        //}
        let dict :NSDictionary = [
            "chat_code":"",
            "created_at": String(describing: currentTimeInMiliseconds()),
            "id":"",
            "message": String(describing: msgTxt)  ,
            "message_status":"",
            "message_type":"",
            "received_key": String(describing: userkey!),
            "recievername" : "",
            "sender_key":  String(describing: chatuserkey),
            "senderlocaldbcode":"",
            "sendername": ""
        ]
        DispatchQueue.main.async{
            self.msgDetailsArr.add(dict)
            //self.setLabelSize()
            self.perform(#selector(self.reloadTblVw_afterDelay), with: nil, afterDelay: 0.0)
            self.chatListVw.reloadData()
            self.chatListVw.layoutIfNeeded()
            self.chatListVw.layoutSubviews()
            
        }
        
    }
    
    func getGroupChatMsg(msgTxt: String, senderName: String) {
        //print("msgTxt, senderName",msgTxt,senderName)
        
        let msgArr = msgTxt.components(separatedBy: "-")
        let msgTxt = msgArr[1]
        let userNameArr = msgArr[0].components(separatedBy: "_")
        let userkey = userNameArr[1]
        //print("userkey",userkey as Any)
        var chatroomkey = ""
        var chatroomname = ""
        var sender_name = ""
        if((chatUserDict["type"])as? String != "group_chat" && (chatUserDict["type"])as? String != "broadcast"){
            chatroomkey = (chatUserDict["key"] as? String)!
            //print("chatuserkey",chatroomkey as Any)
            chatroomname = (chatUserDict["name"] as? String)!
            sender_name = senderName
        }
        let dict :NSDictionary = [
            "chat_code":"",
            "created_at": String(describing: currentTimeInMiliseconds()),
            "id":"",
            "message": String(describing: msgTxt)  ,
            "message_status":"",
            "message_type":"",
            "received_key": String(describing: chatroomkey),
            "recievername" : String(describing: chatroomname),
            "sender_key":  String(describing: userkey),
            "senderlocaldbcode":"",
            "sendername": String(describing: sender_name)
        ]
        DispatchQueue.main.async{
            self.msgDetailsArr.add(dict)
            //self.setLabelSize()
            self.perform(#selector(self.reloadTblVw_afterDelay), with: nil, afterDelay: 0.0)
            self.chatListVw.reloadData()
            self.chatListVw.layoutIfNeeded()
            self.chatListVw.layoutSubviews()
            //self.reloadTblVw()
        }
        
        /*
         "chat_code" = "CHAT_USRPHec4bbfcb_af7de9fa";
         "created_at" = 1558530930000;
         id = 149;
         message = Hello;
         "message_status" = sent;
         "message_type" = text;
         "received_key" = af7de9fa;
         recievername = Erudition;
         "sender_key" = USRPHec4bbfcb;
         senderlocaldbcode = "1558530928583_USRPHec4bbfcb";
         sendername = "Samin Ali Mondal";
 */
    }
    
    //MARK: Button Action
    @IBAction func moreBtnAction(_ sender:UIButton){
        
        //print("moreBtn clicked")
        /*if(self.moreVw == nil){
            self.createMoreView()
        }*/
        
        
    }
    
    @IBAction func backBtnAction(_ sender: UIButton) {
        
        self.navigationController?.popViewController(animated: true)
        
    }
    
    @IBAction func sendBtnAction(_ sender: UIButton) {
        
        let userkey = UserDefaults.standard.string(forKey: "user_key")
        //print("userkey",userkey as Any)
        
        var sendlocaldbcode = ""
        
        var chatuserkey = ""
        /*if((chatUserDict["type"])as? String != "group_chat" ){
            
            print((chatUserDict["type"])as! String)
            
            chatuserkey = (chatUserDict["key"] as? String)!
            //print("chatuserkey",chatuserkey as Any)
            
            sendlocaldbcode = String(describing: currentTimeInMiliseconds()) + "_" + userkey! as String
            isChatMsg = false
            
            let message = sendlocaldbcode + "-" + msgTxtFld.text!
            let senderJID = chatuserkey + "@" + Constant.XMPP_HOST
            
            XMPPController.XMPPControllerSharedInstance.oneToOneChatSendMsg(senderJID: senderJID, message: message)
            
        }else{*/
            
            chatuserkey = (chatUserDict["reg_key"] as? String)!
            //print("chatuserkey",chatuserkey as Any)
            
            sendlocaldbcode = String(describing: currentTimeInMiliseconds()) + "_" + userkey! as String
            isChatMsg = false
            
            let message = sendlocaldbcode + "-" + msgTxtFld.text!
            let senderJID = chatuserkey + "@" + Constant.XMPP_HOST
            
            XMPPController.XMPPControllerSharedInstance.groupChatSendMsg(groupID: senderJID, message: message)
            
        //}
        
        
        
        
        if Reachability.isConnectedToNetwork(){
            
            //CommonClass.commonSharedInstance.showSpinner(onView: self.view)
            UrlRequestClass.UrlRequestSharedInstance.urlrequestDelegate = self
            //UrlRequestClass.UrlRequestSharedInstance.sendMsg_twouser_fromphone(sender_id: userkey!, received_id: chatuserkey, message: msgTxtFld.text, message_type: "text", message_status: "sent",senderlocaldbcode: sendlocaldbcode,viewcontroller_class: self)
            
        }else{
            
            //print("Internet Connection not Available!")
            show_alert(alert_title: "Chatmachine", btn_title: "Ok", msg: "Internet Connection not Available!")
            DispatchQueue.main.async{
                CommonClass.commonSharedInstance.removeSpinner()
            }
            
        }
        
    }
    
    @IBAction func camBtnAction(_ sender: UIButton){
        ImagePickerManager().pickImage(self,"pic"){ image in
            //here is the image
        }
    }
    
    @IBAction func attachmentBtnAction(_ sender: UIButton){
        
    }
    
    @IBAction func videoCallBtnAction(_ sender: UIButton){
        
        /*
        DispatchQueue.main.async{
            
            CommonClass.commonSharedInstance.JITSI_CALL_SELECTED_TYPE = "video"
            
            let chatuserkey = (self.chatUserDict["key"] as? String)!
            var mainStoryBoard : UIStoryboard!
            if(UIDevice.current.userInterfaceIdiom == .pad){
                mainStoryBoard = UIStoryboard(name: "Main_iPad", bundle: nil)
            }else if(UIDevice.current.userInterfaceIdiom == .phone){
                mainStoryBoard = UIStoryboard(name: "Main", bundle: nil)
            }
            let vc = mainStoryBoard.instantiateViewController(withIdentifier: "OutgoingCallViewController") as! OutgoingCallViewController
            if((self.chatUserDict["type"])as? String == "group_chat"){
                vc.isGrpCall = "true"
            }else if((self.chatUserDict["type"])as? String == "broadcast"){
                vc.isGrpCall = "true"
            }else{
                vc.isGrpCall = "false"
            }
            vc.callType = Constant.JITSI_CALL_AUDIO_TYPE
            vc.userData = self.chatUserDict
            vc.userKey = chatuserkey
            self.navigationController?.pushViewController(vc, animated: true)
            
        }
        */
        
    }
    @IBAction func audioCallBtnAction(_ sender: UIButton){
        
        /*
        DispatchQueue.main.async{
            
            CommonClass.commonSharedInstance.JITSI_CALL_SELECTED_TYPE = "audio"
            
            let chatuserkey = (self.chatUserDict["key"] as? String)!
            var mainStoryBoard : UIStoryboard!
            if(UIDevice.current.userInterfaceIdiom == .pad){
                mainStoryBoard = UIStoryboard(name: "Main_iPad", bundle: nil)
            }else if(UIDevice.current.userInterfaceIdiom == .phone){
                mainStoryBoard = UIStoryboard(name: "Main", bundle: nil)
            }
            let vc = mainStoryBoard.instantiateViewController(withIdentifier: "OutgoingCallViewController") as! OutgoingCallViewController
            if((self.chatUserDict["type"])as? String == "group_chat"){
                vc.isGrpCall = "true"
            }else if((self.chatUserDict["type"])as? String == "broadcast"){
                vc.isGrpCall = "true"
            }else{
                vc.isGrpCall = "false"
            }
            vc.callType = Constant.JITSI_CALL_AUDIO_TYPE
            vc.userData = self.chatUserDict
            vc.userKey = chatuserkey
            self.navigationController?.pushViewController(vc, animated: true)
            
        }
        
        */
        
    }
    
    //MARK: current date to miliseconds
    func currentTimeInMiliseconds() -> Int {
        let currentDate = Date()
        let since1970 = currentDate.timeIntervalSince1970
        return Int(since1970 * 1000)
    }
    
    
    //MARK: MoreView Delegate Methods
    func removeFromController(){
        
        /*if(self.moreVw != nil){
            self.moreVw.removeFromSuperview()
            self.moreVw = nil
        }*/
        
        
    }
    //MARK: One to one chat create chat babbles
    func showIncomingMessage(text: String,label:UILabel,view:UIView) {
        //let label =  UILabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .gray
        label.text = text
        
        let constraintRect = CGSize(width: 0.85 * view.frame.width,
                                    height: .greatestFiniteMagnitude)
        let boundingBox = text.boundingRect(with: constraintRect,
                                            options: .usesLineFragmentOrigin,
                                            attributes: [.font: label.font as Any],
                                            context: nil)
        label.frame.size = CGSize(width: ceil(boundingBox.width),
                                  height: ceil(boundingBox.height))
        
        let bubbleSize = CGSize(width: label.frame.width + 28,
                                height: label.frame.height + 20 )
        
        let width = bubbleSize.width
        let height = bubbleSize.height
        
        for subview in view.subviews {
            
            if(subview.isKind(of: UIImageView.self) ){
                subview.removeFromSuperview()
            }
            
        }
        
        let incomingMsgImgVw = UIImageView()
        incomingMsgImgVw.frame = CGRect(x: 5,
                                        y: 0,
                                        width: width ,
                                        height: height)
        //incomingMsgImgVw.backgroundColor = UIColor(red: 9.0/255.0, green: 253.0/255.0, blue: 255.0/255.0, alpha: 1.0)
        incomingMsgImgVw.image = UIImage(named: "chat_bubble_received")
        incomingMsgImgVw.contentMode = UIView.ContentMode.scaleToFill
        view.addSubview(incomingMsgImgVw)
        
        label.center = view.center
        view.addSubview(label)
        
    }
    
    func showOutgoingMessage(text: String,label:UILabel,view:UIView ) {
        //let label =  UILabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .gray
        label.text = text
        
        let constraintRect = CGSize(width: 0.85 * view.frame.width,
                                    height: .greatestFiniteMagnitude)
        let boundingBox = text.boundingRect(with: constraintRect,
                                            options: .usesLineFragmentOrigin,
                                            attributes: [.font: label.font as Any],
                                            context: nil)
        label.frame.size = CGSize(width: ceil(boundingBox.width),
                                  height: ceil(boundingBox.height))
        
        let bubbleSize = CGSize(width: label.frame.width + 28,
                                height: label.frame.height + 20)
        
        let width = bubbleSize.width
        let height = bubbleSize.height
        
        for subview in view.subviews {
            
            if(subview.isKind(of: UIImageView.self) ){
                subview.removeFromSuperview()
            }
            
        }
        
        let outgoingMsgImgVw = UIImageView()
        outgoingMsgImgVw.frame = CGRect(x: view.frame.width - (width + 5),
                                        y: 0,
                                        width: width ,
                                        height: height)
        //outgoingMsgImgVw.backgroundColor = UIColor(red: 88.0/255.0, green: 252.0/255.0, blue: 252.0/255.0, alpha: 1.0)
        outgoingMsgImgVw.image = UIImage(named: "chat_bubble_sent")
        outgoingMsgImgVw.contentMode = UIView.ContentMode.scaleToFill
        view.addSubview(outgoingMsgImgVw)
        
        label.center = view.center
        view.addSubview(label)
        
    }
    
    
}

extension UITableView {
    func scrollToBottom() {
        
        DispatchQueue.main.async{
            
            let lastSectionIndex = self.numberOfSections - 1
            if lastSectionIndex < 0 { //if invalid section
                return
            }
            
            let lastRowIndex = self.numberOfRows(inSection: lastSectionIndex) - 1
            if lastRowIndex < 0 { //if invalid row
                return
            }
            
            let pathToLastRow = IndexPath(row: lastRowIndex, section: lastSectionIndex)
            self.scrollToRow(at: pathToLastRow, at: .bottom, animated: true)
            
        }
    }
}

extension ChatViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.msgDetailsArr.count
        
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        let dict = self.msgDetailsArr[indexPath.row] as! NSDictionary
        let textStr = (dict["message"] as! String)
        
        let constraintRect = CGSize(width: 0.85 * self.view.frame.width,
                                    height: .greatestFiniteMagnitude)
        let boundingBox = textStr.boundingRect(with: constraintRect,
                                            options: .usesLineFragmentOrigin,
                                            attributes: [.font: UIFont.systemFont(ofSize: 12) as Any],
                                            context: nil)
        let labelSize = CGSize(width: ceil(boundingBox.width),
                                  height: ceil(boundingBox.height))
        
        let labelHeight = labelSize.height
        return (labelHeight + 50)
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let dict = self.msgDetailsArr[indexPath.row] as! NSDictionary
        var userkey = ""
        //print("userkey",userkey as Any)
        if((chatUserDict["type"])as? String != "group_chat" && (chatUserDict["type"])as? String != "broadcast"){
            userkey = UserDefaults.standard.string(forKey: "user_key")!
            
            if((dict["received_key"] as! String) == userkey)
            {
                let cell:receivedChatCell = tableView.dequeueReusableCell(withIdentifier: "receivedChatCell", for: indexPath) as! receivedChatCell
                
                cell.recevierNameLbl.text = ""
                
                //cell.chatmsgLbl.text = (dict["message"] as! String)
                showIncomingMessage(text: (dict["message"] as! String),label:cell.chatmsgLbl, view: cell.chatmsgLblVw)
                //cell.chatmsgLbl.backgroundColor = UIColor(patternImage: UIImage(named: "chat_bubble_received")!)//UIColor.purple//
                //cell.chatmsgLbl.layer.cornerRadius = 5
                //cell.chatmsgLbl.clipsToBounds = true
                //cell.chatmsgLbl.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
                
                
                let time  = (dict["created_at"] as! String)
                let dateTimeStamp = NSDate(timeIntervalSince1970:Double(time)!/1000)  //UTC time  //YOUR currentTimeInMiliseconds METHOD
                let dateFormatter = DateFormatter()
                dateFormatter.timeZone = NSTimeZone.local
                dateFormatter.dateFormat = "DD-mm-YYYY HH:mm:ss"
                dateFormatter.dateStyle = DateFormatter.Style.medium
                dateFormatter.timeStyle = DateFormatter.Style.full
                
                
                let strDateSelect = dateFormatter.string(from: dateTimeStamp as Date)
                //print("Local Time::", strDateSelect) //Local time
                let timeArr = strDateSelect.components(separatedBy: "at")
                
                let datestr    = timeArr[0]
                let timestr = timeArr[1]
                let timeArray = timestr.components(separatedBy: " ")
                let timestr1 = timeArray[1]
                let timestr2 = timeArray[2]
                
                if(Calendar.autoupdatingCurrent.isDateInToday(dateTimeStamp as Date)){
                    cell.timeLbl.text = timestr1 + timestr2
                }else{
                    cell.timeLbl.text = datestr + timestr1 + timestr2
                }
                
                
                cell.selectionStyle = .none
                return cell
                
            }else{
                
                let cell:sendChatCell = tableView.dequeueReusableCell(withIdentifier: "sendChatCell", for: indexPath) as! sendChatCell
                
                cell.senderNameLbl.text = ""
                
                
                //cell.chatmsgLbl.text = (dict["message"] as! String)
                showOutgoingMessage(text: (dict["message"] as! String),label:cell.chatmsgLbl, view: cell.chatmsgLblVw)
                //cell.chatmsgLbl.backgroundColor = UIColor(patternImage: UIImage(named: "chat_bubble_sent")!)//UIColor.darkGray//
                //cell.chatmsgLbl.layer.cornerRadius = 5
                //cell.chatmsgLbl.clipsToBounds = true
                //cell.chatmsgLbl.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
                
                
                let time  = (dict["created_at"] as! String)
                let dateTimeStamp = NSDate(timeIntervalSince1970:Double(time)!/1000)  //UTC time  //YOUR currentTimeInMiliseconds METHOD
                let dateFormatter = DateFormatter()
                dateFormatter.timeZone = NSTimeZone.local
                dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
                dateFormatter.dateStyle = DateFormatter.Style.medium
                dateFormatter.timeStyle = DateFormatter.Style.full
                
                
                let strDateSelect = dateFormatter.string(from: dateTimeStamp as Date)
                //print("Local Time::", strDateSelect) //Local time
                let timeArr = strDateSelect.components(separatedBy: "at")
                
                let datestr    = timeArr[0]
                let timestr = timeArr[1]
                let timeArray = timestr.components(separatedBy: " ")
                let timestr1 = timeArray[1]
                let timestr2 = timeArray[2]
                
                if(Calendar.autoupdatingCurrent.isDateInToday(dateTimeStamp as Date)){
                    cell.timeLbl.text = timestr1 + timestr2
                }else{
                    cell.timeLbl.text = datestr + timestr1 + timestr2
                }
                
                cell.selectionStyle = .none
                return cell
                
            }
            
        }else{
            userkey = UserDefaults.standard.string(forKey: "user_key")!
            //print((dict["sender_key"] as! String),userkey)
            if((dict["sender_key"] as! String) != userkey)
            {
                let cell:receivedChatCell = tableView.dequeueReusableCell(withIdentifier: "receivedChatCell", for: indexPath) as! receivedChatCell
                
                cell.recevierNameLbl.text = (dict["sendername"] as! String)
                //cell.chatmsgLbl.text = (dict["message"] as! String)
                showIncomingMessage(text: (dict["message"] as! String),label:cell.chatmsgLbl, view: cell.chatmsgLblVw)
                //cell.chatmsgLbl.backgroundColor = UIColor.purple
                //cell.chatmsgLbl.layer.cornerRadius = 5
                //cell.chatmsgLbl.clipsToBounds = true
                
                
                
                let time  = (dict["created_at"] as! String)
                let dateTimeStamp = NSDate(timeIntervalSince1970:Double(time)!/1000)  //UTC time  //YOUR currentTimeInMiliseconds METHOD
                let dateFormatter = DateFormatter()
                dateFormatter.timeZone = NSTimeZone.local
                dateFormatter.dateFormat = "DD-mm-YYYY HH:mm:ss"
                dateFormatter.dateStyle = DateFormatter.Style.medium
                dateFormatter.timeStyle = DateFormatter.Style.full
                
                
                let strDateSelect = dateFormatter.string(from: dateTimeStamp as Date)
                //print("Local Time::", strDateSelect) //Local time
                let timeArr = strDateSelect.components(separatedBy: "at")
                
                let datestr    = timeArr[0]
                let timestr = timeArr[1]
                let timeArray = timestr.components(separatedBy: " ")
                let timestr1 = timeArray[1]
                let timestr2 = timeArray[2]
                
                if(Calendar.autoupdatingCurrent.isDateInToday(dateTimeStamp as Date)){
                    cell.timeLbl.text = timestr1 + timestr2
                }else{
                    cell.timeLbl.text = datestr + timestr1 + timestr2
                }
                
                
                cell.selectionStyle = .none
                return cell
                
            }else{
                
                let cell:sendChatCell = tableView.dequeueReusableCell(withIdentifier: "sendChatCell", for: indexPath) as! sendChatCell
                
                cell.senderNameLbl.text = "You"
                //cell.chatmsgLbl.text = (dict["message"] as! String)
                
                showOutgoingMessage(text: (dict["message"] as! String),label:cell.chatmsgLbl, view: cell.chatmsgLblVw)
                
                //cell.chatmsgLbl.backgroundColor = UIColor.lightGray//(patternImage: UIImage(named: "chat_bubble_sent")!)
                //cell.chatmsgLbl.layer.cornerRadius = 5
                //cell.chatmsgLbl.clipsToBounds = true
                
                
                let time  = (dict["created_at"] as! String)
                let dateTimeStamp = NSDate(timeIntervalSince1970:Double(time)!/1000)  //UTC time  //YOUR currentTimeInMiliseconds METHOD
                let dateFormatter = DateFormatter()
                dateFormatter.timeZone = NSTimeZone.local
                dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
                dateFormatter.dateStyle = DateFormatter.Style.medium
                dateFormatter.timeStyle = DateFormatter.Style.full
                
                
                let strDateSelect = dateFormatter.string(from: dateTimeStamp as Date)
                //print("Local Time::", strDateSelect) //Local time
                let timeArr = strDateSelect.components(separatedBy: "at")
                
                let datestr    = timeArr[0]
                let timestr = timeArr[1]
                let timeArray = timestr.components(separatedBy: " ")
                let timestr1 = timeArray[1]
                let timestr2 = timeArray[2]
                
                if(Calendar.autoupdatingCurrent.isDateInToday(dateTimeStamp as Date)){
                    cell.timeLbl.text = timestr1 + timestr2
                }else{
                    cell.timeLbl.text = datestr + timestr1 + timestr2
                }
                
                cell.selectionStyle = .none
                return cell
                
            }
            
        }
        
        
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        
        //print("didSelectRowAt")
        
        
        
    }
    
    
}


extension ChatViewController:UITextViewDelegate{
    
    func registerForTxtViewKeyboardNotification(){
        
        NotificationCenter.default.addObserver(self, selector: #selector(ChatViewController.updateTextView(notification:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(ChatViewController.updateTextView(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        //textView.backgroundColor = UIColor.lightGray
        if textView.text == "Type a message" {
            textView.text = nil
            textView.textColor = UIColor.black
            textView.text = ""
        }
        
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        //textView.backgroundColor = UIColor.white
        if textView.text.isEmpty {
            textView.text = "Type a message"
            textView.textColor = UIColor.lightGray
        }
        
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        let currentText:String = textView.text
        let updatedText = (currentText as NSString).replacingCharacters(in: range, with: text)
        
        
        
        if updatedText.isEmpty {
            
            textView.text = "Type a message"
            textView.textColor = UIColor.lightGray
            
            textView.selectedTextRange = textView.textRange(from: textView.beginningOfDocument, to: textView.beginningOfDocument)
            
        }else if textView.textColor == UIColor.lightGray && !text.isEmpty {
            
            textView.textColor = UIColor.black
            textView.text = text
            
        }else if text == "\n" {
            
            textView.text = textView.text + "\n"
            //textView.resignFirstResponder()
            
        }
        
        
        return true
    }
    
    @objc func updateTextView(notification: Notification)
    {
        if let userInfo = notification.userInfo
        {
            let keyboardFrameScreenCoordinates = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
            
            let keyboardFrame = self.view.convert(keyboardFrameScreenCoordinates, to: view.window)
            
            if notification.name == UIResponder.keyboardWillShowNotification{
                //print("UIResponder.keyboardWillShowNotification")
                
            }else if notification.name == UIResponder.keyboardWillChangeFrameNotification{
                //print("UIResponder.keyboardWillChangeFrameNotification")
                if(isKeyboardOn == true){
                    isKeyboardOn = false
                    chatListVw.frame = CGRect(x: 0.0, y: topVw.frame.origin.y + topVw.frame.size.height + 5.0 , width: chatListVw.frame.size.width , height: chatListVw.frame.size.height - keyboardFrame.height)
                    bottomVw.frame = CGRect(x: 0.0, y: view.frame.size.height - ( keyboardFrame.height + bottomVw.frame.size.height), width: bottomVw.frame.size.width, height: bottomVw.frame.size.height)
                    reloadTblVw()
                }
            }
            else{
                //bottomVw.frame.origin.y = view.frame.size.height - ( keyboardFrame.height + 80.0)
                //print("UIResponder.keyboardWillHide")
            }
        }
    }
    
    
}
