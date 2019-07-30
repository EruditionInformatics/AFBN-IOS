//
//  AddFeedViewController.swift
//  AFBN
//
//  Created by Erudition Informatics on 08/05/19.
//  Copyright © 2019 Erudition Informatics. All rights reserved.
//

import UIKit
import CoreData
import MobileCoreServices
import QuartzCore
import AVFoundation
import AVKit

class AddFeedViewController: UIViewController,urlrequestprotocol {
    
     @IBOutlet weak var backVw:UIView!
    @IBOutlet weak var postBtn:UIButton!
    @IBOutlet weak var txtbackVw:UIView!
    @IBOutlet weak var memberImgVw:UIImageView!
    @IBOutlet weak var userNameLbl:UILabel!
    @IBOutlet weak var feedTxtVw:UITextView!
    
    var user_id:String = ""
    var filePath :String!
    var filename :String!
    var imageName:String!
    var isImage:String!
    
    var vidData:Data!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.imageName = ""
        self.isImage = "0"
        setSubviewsDesign()
        registerForTxtViewKeyboardNotification()
        // Do any additional setup after loading the view.
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
    //MARK:Set subview design
    func setSubviewsDesign(){
        
        let shadowSize : CGFloat = 5.0
        let shadowPath = UIBezierPath(rect: CGRect(x: -shadowSize / 2,
                                                   y: -shadowSize / 2,
                                                   width: backVw.frame.size.width + shadowSize,
                                                   height: backVw.frame.size.height + shadowSize))
        backVw.layer.masksToBounds = false
        backVw.layer.shadowColor = UIColor.black.cgColor
        backVw.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        backVw.layer.shadowOpacity = 0.2
        backVw.layer.shadowPath = shadowPath.cgPath
        
        txtbackVw.layer.cornerRadius = 8
        txtbackVw.layer.borderWidth = 1
        txtbackVw.layer.borderColor = UIColor.black.cgColor
        
        memberImgVw.layer.cornerRadius = 27.5
        memberImgVw.layer.borderWidth = 1
        memberImgVw.layer.borderColor = UIColor.black.cgColor
        
        let userData = self.getUserDetailFromDatabase()
        print("userData",userData)
        
        let detailsData = userData[0] as! NSDictionary
        self.user_id = String(describing: detailsData["reg_key"]!)
        print(self.user_id)
        
        self.userNameLbl.text = (detailsData["reg_pref_usr_name"] as! String)
        
    }
    
    //MARK: CoreData Methods
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
    
    //MARK:Top bar button action
    @IBAction func backBtnAction(_ sender: UIButton){
        
        self.navigationController?.popToRootViewController(animated: true)
        
        
    }
    @IBAction func menuBtnAction(_ sender: UIButton){
        
    }
    
    @IBAction func picBtnAction(_ sender: UIButton){
        ImagePickerManager().pickImage(self,"pic"){ info in
            //here is the image
            print("image dict",info)//
            if(info["UIImagePickerControllerImageURL"] != nil){
                
                self.memberImgVw.image = (info["UIImagePickerControllerOriginalImage"] as! UIImage)
                self.imageName = String(describing: info["UIImagePickerControllerImageURL"]!)
                let compArr = self.imageName.components(separatedBy: ":")
                self.imageName = (compArr.last)!
                
            }else{
                
                self.memberImgVw.image = (info["UIImagePickerControllerOriginalImage"] as! UIImage)
                let compArr = self.imageName.components(separatedBy: ":")
                self.imageName = (compArr.last)!
                
            }
            self.isImage = "1"
            print(self.imageName!)
        }
    }
    
    @IBAction func vidBtnAction(_ sender: UIButton){
        ImagePickerManager().pickImage(self, "video") { info in
            print("image dict",info)
            let filePath = String(describing:info["UIImagePickerControllerMediaURL"]!)
            let file_PathArr = filePath.components(separatedBy: ":///")
            self.memberImgVw.image = self.generateThumbnailForVideoAtURL(filePathLocal: (file_PathArr[1] as NSString))
            self.vidData = self.memberImgVw.image!.jpegData(compressionQuality: 1)
            self.isImage = "2"
        }
    }
    
    @IBAction func postBtnAction(_ sender: UIButton){
        
        if(self.feedTxtVw.text != "Write something interesting"){
            
            if(self.imageName.count > 0){
                
                callApiFor_createfeed(user_id:self.user_id)
                
            }else{
                
                if(self.isImage == "1"){
                    
                    let imageData = self.memberImgVw.image!.jpegData(compressionQuality: 1)
                    callApiFor_createfeed_ImageDataWithtext(user_id: self.user_id, imgData: imageData!)
                    
                }else if(self.isImage == "2"){
                    callApiFor_createfeed_VideoDataWithtext(user_id: self.user_id, vidData: self.vidData)
                }else{
                    
                    callApiFor_createfeed_Onlytext(user_id: self.user_id)
                    
                }
                
                
            }
            
            self.feedTxtVw.resignFirstResponder()
        }
        
    }
    
    //MARK: - Capture video snapshot
    func generateThumbnailForVideoAtURL(filePathLocal: NSString) -> UIImage? {
        
        let vidURL = NSURL(fileURLWithPath:filePathLocal as String)
        let asset = AVURLAsset(url: vidURL as URL)
        let generator = AVAssetImageGenerator(asset: asset)
        generator.appliesPreferredTrackTransform = true
        
        let timestamp = CMTime(seconds: 1, preferredTimescale: 60)
        
        do {
            let imageRef = try generator.copyCGImage(at: timestamp, actualTime: nil)
            return UIImage(cgImage: imageRef)
        }
        catch let error as NSError
        {
            print("Image generation failed with error \(error)")
            return nil
        }
        
    }
    
    
    //MARK: -Api call Create Feed With Image and Text for Feedlist
    func callApiFor_createfeed(user_id:String){
        
        CommonClass.commonSharedInstance.showSpinner(onView: self.view)
        UrlRequestClass.UrlRequestSharedInstance.urlrequestDelegate = self
        UrlRequestClass.UrlRequestSharedInstance.createFeed(user_id: user_id,user_name:self.userNameLbl.text! ,feed_text: self.feedTxtVw.text, feed_img: self.imageName, feed_video: "", viewcontroller_class: self,tag:"1")
        
    }
    
    //MARK: -Api call Create Feed With Only Text for Feedlist
    func callApiFor_createfeed_Onlytext(user_id:String){
        
        CommonClass.commonSharedInstance.showSpinner(onView: self.view)
        UrlRequestClass.UrlRequestSharedInstance.urlrequestDelegate = self
        UrlRequestClass.UrlRequestSharedInstance.createTxtFeed(user_id: user_id, user_name: self.userNameLbl.text!, feed_text: self.feedTxtVw.text, viewcontroller_class: self,tag:"2")
        
    }
    
    //MARK: -Api call Create Feed With Image Data Text for Feedlist
    func callApiFor_createfeed_ImageDataWithtext(user_id:String ,imgData:Data){
        
        CommonClass.commonSharedInstance.showSpinner(onView: self.view)
        UrlRequestClass.UrlRequestSharedInstance.urlrequestDelegate = self
        UrlRequestClass.UrlRequestSharedInstance.createFeed(user_id: user_id, user_name: self.userNameLbl.text!, feed_text: self.feedTxtVw.text, imageData: imgData, viewcontroller_class: self,tag:"3")
        
    }
    
    //MARK: -Api call Create Feed With Video Data Text for Feedlist
    func callApiFor_createfeed_VideoDataWithtext(user_id:String ,vidData:Data){
        
        CommonClass.commonSharedInstance.showSpinner(onView: self.view)
        UrlRequestClass.UrlRequestSharedInstance.urlrequestDelegate = self
        UrlRequestClass.UrlRequestSharedInstance.createFeed(user_id: user_id, user_name: self.userNameLbl.text!, feed_text: self.feedTxtVw.text, vidData: vidData, viewcontroller_class: self,tag:"3")
        
    }
    
    //MARK: -URLRequestDelegates method
    func urlrequestfinish_with_success(data: NSDictionary, requestType: String, request_class: UIViewController,tag:String) {
        print("data",data)
        DispatchQueue.main.async{
            
            self.feedTxtVw.text = "Write something interesting"
            CommonClass.commonSharedInstance.removeSpinner()
            self.navigationController?.popToRootViewController(animated: true)
        }
    }
    
    func urlrequestfinish_with_error(error: Error) {
        print("error",error)
        DispatchQueue.main.async{
            
            CommonClass.commonSharedInstance.removeSpinner()
            
        }
    }

}

extension AddFeedViewController:UITextViewDelegate{
    
    func registerForTxtViewKeyboardNotification(){
        
        NotificationCenter.default.addObserver(self, selector: #selector(AddFeedViewController.updateTextView(notification:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(AddFeedViewController.updateTextView(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        //textView.backgroundColor = UIColor.lightGray
        if(textView.text == "Write something interesting"){
            
            textView.text = ""
            
        }
        
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        //textView.backgroundColor = UIColor.white
        
        
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
                view.frame.origin.y = -keyboardFrame.height + 150.0
            }
        }
    }
    
    
}

