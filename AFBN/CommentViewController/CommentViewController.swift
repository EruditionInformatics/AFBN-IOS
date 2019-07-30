//
//  CommentViewController.swift
//  AFBN
//
//  Created by Erudition Informatics on 19/07/19.
//  Copyright © 2019 Erudition Informatics. All rights reserved.
//

import UIKit

class commentTableViewCell : UITableViewCell {
    @IBOutlet weak var commentLbl:UILabel!
}

class CommentViewController: UIViewController,urlrequestprotocol {
    
    var user_name:String!
    var user_id:String!
    var feed_id:String!
    var commentArr:NSMutableArray!
    
    @IBOutlet weak var commentList:UITableView!
    @IBOutlet weak var bottomVw:UIView!
    @IBOutlet weak var commenttxtVw:UITextView!
    @IBOutlet weak var postBtn:UIButton!
    
    var isKeyboardOn:Bool = true

    //MARK: - View cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        self.commentArr = []
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool){
        setBottomVwBorderAndOtherView()
        registerForTxtViewKeyboardNotification()
        callApiForCommentList(feedId: self.feed_id)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        
        
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    //MARK: -set bottom view
    func setBottomVwBorderAndOtherView(){
        
        self.bottomVw.layer.borderColor = UIColor.lightGray.cgColor
        self.bottomVw.layer.borderWidth = 1.0
        
        self.commenttxtVw.layer.borderColor = UIColor.lightGray.cgColor
        self.commenttxtVw.layer.borderWidth = 1.0
        self.commenttxtVw.layer.cornerRadius = 8.0
        
        self.postBtn.layer.cornerRadius = 5.0
        
    }
    func reloadTblVw(){
        
        DispatchQueue.main.async {
            let indexPath = NSIndexPath(row: self.commentArr.count-1, section: 0)
            self.commentList.scrollToRow(at: indexPath as IndexPath, at: .bottom, animated: true)
        }
        
    }
    
    //MARK: - perform selector method
    @objc func pushback(dict: NSDictionary){
        self.navigationController?.popViewController(animated: true)
    }
    //MARK: - Call API for post comment
    func CallApiForPostComment(feedId:String,feedComment:String,commentBy:String){
        CommonClass.commonSharedInstance.showSpinner(onView: self.view)
        UrlRequestClass.UrlRequestSharedInstance.urlrequestDelegate = self
        UrlRequestClass.UrlRequestSharedInstance.postFeedComment(feed_id: feedId, comment_txt: feedComment, comment_by_name: commentBy, viewcontroller_class: self, tag: "2")
    }
    
    //MARK: - Call Api for total comment list
    func callApiForCommentList(feedId:String){
        CommonClass.commonSharedInstance.showSpinner(onView: self.view)
        UrlRequestClass.UrlRequestSharedInstance.urlrequestDelegate = self
        UrlRequestClass.UrlRequestSharedInstance.getCommentList(feed_id: feedId, viewcontroller_class: self, tag: "1")
    }
    //MARK: - Button Action
    @IBAction func postBtnAction(_ sender: UIButton){
        if(self.commenttxtVw.text != "Your Comment ..."){
            
            self.commenttxtVw.resignFirstResponder()
            self.CallApiForPostComment(feedId: self.feed_id, feedComment: self.commenttxtVw.text, commentBy: self.user_name)
        }else{
            CommonClass.commonSharedInstance.show_alert(alert_title: "AFBN", btn_title: "Ok", msg: "Please enter Comment.", presentingClass: self)
        }
    }
    
    @IBAction func backBtnAction(_ sender: UIButton){
        self.navigationController?.popViewController(animated: true)
    }
    
    //MARK: - Urlrequest delegates method
    func urlrequestfinish_with_success(data: NSDictionary, requestType: String, request_class: UIViewController, tag: String) {
        
        if(tag == "1"){
            print("urlrequestfinish_with_success",data)
            
            if((data["code"] as! String) == "0"){
                self.commentArr = (data["message"] as! NSMutableArray)
                DispatchQueue.main.async{
                    self.commenttxtVw.text = "Your Comment ..."
                    CommonClass.commonSharedInstance.removeSpinner()
                    self.commentList.reloadData()
                }
            }else{
                
                DispatchQueue.main.async{
                    CommonClass.commonSharedInstance.show_alert(alert_title: "AFBN", btn_title: "Ok", msg: "No Comment available.", presentingClass: self)
                    CommonClass.commonSharedInstance.removeSpinner()
                    //self.perform(#selector(self.pushback), with: nil, afterDelay: 0.5)
                }
            }
            
        }else{
            if((data["code"] as! String) == "0"){
                
                DispatchQueue.main.async{
                    CommonClass.commonSharedInstance.show_alert(alert_title: "AFBN", btn_title: "Ok", msg: "Successfully post your comment", presentingClass: self)
                    CommonClass.commonSharedInstance.removeSpinner()
                    UrlRequestClass.UrlRequestSharedInstance.urlrequestDelegate = self
                    UrlRequestClass.UrlRequestSharedInstance.getCommentList(feed_id: self.feed_id, viewcontroller_class: self, tag: "1")
                }
                
            }else{
                DispatchQueue.main.async{
                    CommonClass.commonSharedInstance.show_alert(alert_title: "AFBN", btn_title: "Ok", msg: "Some internal error.", presentingClass: self)
                    CommonClass.commonSharedInstance.removeSpinner()
                }
            }
        }
    
    }
    
    func urlrequestfinish_with_error(error: Error) {
        print(error)
    }

}

extension CommentViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.commentArr.count
        
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        let dict = self.commentArr[indexPath.row] as! NSDictionary
        let textStr = dict["feed_comment_content"] as! String
        let constraintRect = CGSize(width: 0.85 * self.view.frame.width,
                                    height: .greatestFiniteMagnitude)
        let boundingBox = textStr.boundingRect(with: constraintRect,
                                               options: .usesLineFragmentOrigin,
                                               attributes: [.font: UIFont.systemFont(ofSize: 12) as Any],
                                               context: nil)
        let labelSize = CGSize(width: ceil(boundingBox.width),
                               height: ceil(boundingBox.height))
        
        let labelHeight = labelSize.height
        return (labelHeight + 20)
        
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let dict = self.commentArr[indexPath.row] as! NSDictionary
        let textStr = dict["feed_comment_content"] as! String
        let commentBy = dict["feed_comment_by"] as! String
        
        let Cell:commentTableViewCell = tableView.dequeueReusableCell(withIdentifier: "commentTableViewCell", for: indexPath) as! commentTableViewCell
        
        Cell.commentLbl.text = commentBy + "@" + textStr
        Cell.commentLbl.backgroundColor = UIColor(red: 21.0/255.0, green: 58.0/255.0, blue: 32.0/255.0, alpha: 1.0)
        
        return Cell
    }
    
    
    
    
    
}

extension CommentViewController:UITextViewDelegate{
    
    func registerForTxtViewKeyboardNotification(){
        
        NotificationCenter.default.addObserver(self, selector: #selector(CommentViewController.updateTextView(notification:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(CommentViewController.updateTextView(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        //textView.backgroundColor = UIColor.lightGray
        if textView.text == "Your Comment ..." {
            textView.text = nil
            textView.textColor = UIColor.black
            textView.text = ""
        }
        
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        //textView.backgroundColor = UIColor.white
        if textView.text.isEmpty {
            textView.text = "Your Comment ..."
            textView.textColor = UIColor.lightGray
        }
        
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        let currentText:String = textView.text
        let updatedText = (currentText as NSString).replacingCharacters(in: range, with: text)
        
        
        
        if updatedText.isEmpty {
            
            textView.text = "Your Comment ..."
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
                if(self.isKeyboardOn == true){
                    self.isKeyboardOn = false
                    self.commentList.frame = CGRect(x: 0.0, y: 85.0 , width: commentList.frame.size.width , height: commentList.frame.size.height - keyboardFrame.height)
                    self.bottomVw.frame = CGRect(x: 0.0, y: view.frame.size.height - ( keyboardFrame.height + bottomVw.frame.size.height), width: bottomVw.frame.size.width, height: bottomVw.frame.size.height)
                    if(self.commentArr.count > 0){
                        self.reloadTblVw()
                    }
                    
                }
            }
            else{
                //bottomVw.frame.origin.y = view.frame.size.height - ( keyboardFrame.height + 80.0)
                //print("UIResponder.keyboardWillHide")
            }
        }
    }
    
    
}
