//
//  NetworkViewController.swift
//  AFBN
//
//  Created by Erudition Informatics on 07/05/19.
//  Copyright © 2019 Erudition Informatics. All rights reserved.
//

import UIKit
import CoreData
import SDWebImage
import AVFoundation
import AVKit

class addFeedNetworkCell:UITableViewCell{
    
    @IBOutlet weak var backVw:UIView!
    @IBOutlet weak var memberImgVw:UIImageView!
    
}

class txtFeedNetworkCell:UITableViewCell{
    
    @IBOutlet weak var backVw:UIView!
    @IBOutlet weak var memberImgVw:UIImageView!
    @IBOutlet weak var feedContentTxtLbl:UILabel!
    @IBOutlet weak var feedPublishByLbl:UILabel!
    @IBOutlet weak var feedPublishDateLbl:UILabel!
    @IBOutlet weak var feedLikeCountLbl:UILabel!
    @IBOutlet weak var feedShareCountLbl:UILabel!
    @IBOutlet weak var feedLikeBtn:UIButton!
    @IBOutlet weak var feedCommentBtn:UIButton!
    
}

class imageFeedNetworkCell:UITableViewCell{
    
    @IBOutlet weak var backVw:UIView!
    @IBOutlet weak var memberImgVw:UIImageView!
    @IBOutlet weak var feedImgVw:UIImageView!
    @IBOutlet weak var feedContentTxtLbl:UILabel!
    @IBOutlet weak var feedPublishByLbl:UILabel!
    @IBOutlet weak var feedPublishDateLbl:UILabel!
    @IBOutlet weak var feedLikeCountLbl:UILabel!
    @IBOutlet weak var feedShareCountLbl:UILabel!
    @IBOutlet weak var feedLikeBtn:UIButton!
    @IBOutlet weak var feedCommentBtn:UIButton!
    
}



class NetworkViewController: UIViewController,urlrequestprotocol {
    
    @IBOutlet weak var networkTableVw: UITableView!
    
    var feedlistArr: NSMutableArray!
    
    var refreshControl = UIRefreshControl()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.feedlistArr = []
        self.loadVw()
        self.refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        self.refreshControl.addTarget(self, action: #selector(refresh), for: UIControl.Event.valueChanged)
        self.networkTableVw.addSubview(refreshControl)
        // Do any additional setup after loading the view.
        /*let isLogedIn = UserDefaults.standard.string(forKey: "user_login")
        //print("isLogedIn",isLogedIn as Any)
        if(isLogedIn == "true"){
            XMPPController.XMPPControllerSharedInstance.connect()
        }*/
    }
    
    override func viewWillAppear(_ animated: Bool){
        super.viewWillAppear(animated)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.hidesBottomBarWhenPushed = false
        
        
    }
    
    //MARK: LoadView from database
    func loadVw(){
        
        let userData = CommonClass.commonSharedInstance.getUserDetailFromDatabase()
        print("userData",userData)
        
        let detailsData = userData[0] as! NSDictionary
        let user_id = String(describing: detailsData["reg_key"]!)
        print("user_id", user_id)
        
        let feedData = CommonClass.commonSharedInstance.getFeedlistFromDatabase()
        print("feedData",feedData)
        
        if(feedData.count > 0){
            
            let feed_detailsData = feedData[0] as! NSDictionary
            print("feed_detailsData",feed_detailsData)
            self.feedlistArr = (feed_detailsData["feedlist"] as! NSMutableArray)
            //print("feedArr",self.feedlistArr)
            //let arrTotalUser = NSArray(array: self.feedlistArr.reversed())
            //print("arrTotalUser sorted Arr::",arrTotalUser)
            
            //self.self.feedlistArr.removeAllObjects()
            //self.self.feedlistArr = (arrTotalUser.mutableCopy() as! NSMutableArray)
            self.networkTableVw.reloadData()
            
            
        }else{
            
            callApiFor_feedlist(userId: user_id)
            
        }
        
        
        
    }
    
    //MARK: -Api call for Feedlist
    func callApiFor_feedlist(userId:String){
        
        //CommonClass.commonSharedInstance.showSpinner(onView: self.view)
        UrlRequestClass.UrlRequestSharedInstance.urlrequestDelegate = self
        UrlRequestClass.UrlRequestSharedInstance.getFeedlist(user_id: userId, viewcontroller_class: self,tag: "1")
        
    }
    
    //MARK: - Api call for FeedLike
    func callApiFor_feedLike(feedId:String,userId:String,likestat:String){
        
        CommonClass.commonSharedInstance.showSpinner(onView: self.view)
        UrlRequestClass.UrlRequestSharedInstance.urlrequestDelegate = self
        UrlRequestClass.UrlRequestSharedInstance.setLike_Dislike(feed_id: feedId, user_id: userId, like_stat:likestat,viewcontroller_class: self, tag: "2")
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    //MARK:Top bar button action
    @IBAction func backBtnAction(_ sender: UIButton){
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let homeViewController = storyBoard.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
        //self.present(singInController, animated: true, completion: nil)
        self.navigationController?.pushViewController(homeViewController, animated: true)
        
    }
    @IBAction func menuBtnAction(_ sender: UIButton){
        
    }
    @IBAction func addFeedBtnAction(_ sender: UIButton){
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let addFeedController = storyBoard.instantiateViewController(withIdentifier: "AddFeedViewController") as! AddFeedViewController
        addFeedController.hidesBottomBarWhenPushed = true
        //self.present(singInController, animated: true, completion: nil)
        self.navigationController?.pushViewController(addFeedController, animated: true)
        
    }
    
    @objc func comment_buttonSelected(sender: UIButton){
        
        let userData = CommonClass.commonSharedInstance.getUserDetailFromDatabase()
        print("userData",userData)
        
        let detailsData = userData[0] as! NSDictionary
        let user_id = String(describing: detailsData["reg_key"]!)
        print("user_id", user_id)
        let userName = String(describing: detailsData["reg_pref_usr_name"]!)
        print("userName", userName)
        
        let buttonPosition:CGPoint = sender.convert(CGPoint.zero, to:self.networkTableVw)
        let indexPath = self.networkTableVw.indexPathForRow(at: buttonPosition)
        print(indexPath!.row)
        
        let dict = self.feedlistArr[indexPath!.row] as! NSDictionary
        let feed_id = String(describing: dict["feed_id"]!)
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let objCommentController = storyBoard.instantiateViewController(withIdentifier: "CommentViewController") as! CommentViewController
        objCommentController.user_id = user_id
        objCommentController.feed_id = feed_id
        objCommentController.user_name = userName
        objCommentController.hidesBottomBarWhenPushed = true
        //self.present(singInController, animated: true, completion: nil)
        self.navigationController?.pushViewController(objCommentController, animated: true)
    }
    
    @objc func like_buttonSelected(sender: UIButton){
        print(sender.tag)
        let likeBtn:UIButton = sender
        
        let buttonPosition:CGPoint = sender.convert(CGPoint.zero, to:self.networkTableVw)
        let indexPath = self.networkTableVw.indexPathForRow(at: buttonPosition)
        print(indexPath!.row)
        
        let userData = CommonClass.commonSharedInstance.getUserDetailFromDatabase()
        print("userData",userData)
        
        let detailsData = userData[0] as! NSDictionary
        let user_id = String(describing: detailsData["reg_key"]!)
        print("user_id", user_id)
        
        let dict = self.feedlistArr[indexPath!.row] as! NSDictionary
        let feed_id = String(describing: dict["feed_id"]!)
        
        var likeCountStr = Int(dict["feed_like_count"] as! String) ?? 0
        print(likeCountStr)
        
        if(likeBtn.isSelected == false){
            
            likeBtn.isSelected = true
            
            callApiFor_feedLike(feedId: feed_id, userId: user_id,likestat: "1")
            
            likeCountStr = likeCountStr + 1
            
            let dictVal = self.updateFeedDictValue(valueDict: dict, likeCount: String(describing: likeCountStr), loginuserlike: "yes")
            self.feedlistArr[indexPath!.row] = dictVal
            CommonClass.commonSharedInstance.deleteFeedData()
            let valueDict:NSDictionary = ["feedlist":self.feedlistArr]
            CommonClass.commonSharedInstance.saveDatabase(user_data:valueDict)
            
            if(likeBtn.tag == 1){
                let cell:imageFeedNetworkCell = self.networkTableVw.cellForRow(at: indexPath!) as! imageFeedNetworkCell
                cell.feedLikeCountLbl.text = String(describing: likeCountStr)
            }else{
                let cell:txtFeedNetworkCell = self.networkTableVw.cellForRow(at: indexPath!) as! txtFeedNetworkCell
                cell.feedLikeCountLbl.text = String(describing: likeCountStr)
            }
            
        }else{
            
            likeBtn.isSelected = false
            
            callApiFor_feedLike(feedId: feed_id, userId: user_id,likestat:"0" )
            
            likeCountStr = likeCountStr - 1
            
            let dictVal = updateFeedDictValue(valueDict: dict, likeCount: String(describing: likeCountStr), loginuserlike: "no")
            self.feedlistArr[indexPath!.row] = dictVal
            CommonClass.commonSharedInstance.deleteFeedData()
            let valueDict:NSDictionary = ["feedlist":self.feedlistArr]
            CommonClass.commonSharedInstance.saveDatabase(user_data:valueDict)
            
            if(likeBtn.tag == 1){
                let cell:imageFeedNetworkCell = self.networkTableVw.cellForRow(at: indexPath!) as! imageFeedNetworkCell
                cell.feedLikeCountLbl.text = String(describing: likeCountStr)
            }else{
                let cell:txtFeedNetworkCell = self.networkTableVw.cellForRow(at: indexPath!) as! txtFeedNetworkCell
                cell.feedLikeCountLbl.text = String(describing: likeCountStr)
            }
            
        }
        
        
        
    }
    
    //MARK: - play video
    func playVideofromurl(vid_url:String){
        let videoURL = URL(string: vid_url)
        let avPlayer = AVPlayer(url: videoURL!)
        //avPlayer = AVPlayer(url: fileURL)
        let avPlayerController = AVPlayerViewController()
        avPlayerController.player = avPlayer
        avPlayerController.view.frame = CGRect(x: 0, y: 80.0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height-200.0)
        // Turn on video controlls
        avPlayerController.showsPlaybackControls = true
        
        // play video
        avPlayerController.player?.play()
        self.view.addSubview(avPlayerController.view)
        self.addChild(avPlayerController)
        //player.play()
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
    
    //MARK: - Update Feed value
    func updateFeedDictValue(valueDict:NSDictionary,likeCount:String,loginuserlike:String) -> NSDictionary{
        
        let feed_dict = [
            "commentcount" : valueDict["commentcount"],
            "feed_content" : valueDict["feed_content"],
            "feed_id" : valueDict["feed_id"],
            "feed_img" : valueDict["feed_img"],
            "feed_like_count" : likeCount,
            "feed_like_list" : valueDict["feed_like_list"],
            "feed_link" : valueDict["feed_link"],
            "feed_proj_name" : valueDict["feed_proj_name"],
            "feed_publish_by" : valueDict["feed_publish_by"],
            "feed_publish_by_email" : valueDict["feed_publish_by_email"],
            "feed_publish_date" : valueDict["feed_publish_date"],
            "feed_publish_stat" : valueDict["feed_publish_stat"],
            "feed_share_count" : valueDict["feed_share_count"],
            "feed_vdo" : valueDict["feed_vdo"],
            "loggedinuserlike" : loginuserlike
        ]
        
        return feed_dict as NSDictionary
    }
    

    
    //MARK: Urlrequest Delegates method
    func urlrequestfinish_with_success(data: NSDictionary, requestType: String, request_class: UIViewController,tag:String) {
        
        if(tag == "1"){
            
            print("data",data)
            let statusCode = data["code"] as! String
            
            if(statusCode == "0"){
                
                self.feedlistArr = (data["message"] as! NSMutableArray)
                
                //print("valueArr::-",valueArr)
                //self.feedlistArr = (valueArr.copy() as! NSMutableArray)
                print("self.feedlistArr::-",self.feedlistArr!)
                let arrTotalUser = NSArray(array: self.feedlistArr.reversed())
                //print("arrTotalUser sorted Arr::",arrTotalUser)
                
                self.self.feedlistArr.removeAllObjects()
                self.self.feedlistArr = (arrTotalUser.mutableCopy() as! NSMutableArray)
                
                DispatchQueue.main.async{
                    
                    let feedData = CommonClass.commonSharedInstance.getFeedlistFromDatabase()
                    print("feedData",feedData)
                    
                    if(feedData.count > 0){
                        
                        CommonClass.commonSharedInstance.deleteFeedData()
                        
                        
                    }
                    
                    let valueDict:NSDictionary = ["feedlist":self.feedlistArr]
                    CommonClass.commonSharedInstance.saveDatabase(user_data:valueDict)
                    CommonClass.commonSharedInstance.removeSpinner()
                    self.networkTableVw.reloadData()
                    if CommonClass.commonSharedInstance.isObjectNotNil(object: self.refreshControl) {
                        self.refreshControl.endRefreshing()
                    }
                    
                }
            }else{
                DispatchQueue.main.async{
                    CommonClass.commonSharedInstance.removeSpinner()
                    CommonClass.commonSharedInstance.show_alert(alert_title: "AFBN", btn_title: "Ok", msg: "Something error occured.", presentingClass: self)
                }
            }
            
        }else{
            print("data",data)
            DispatchQueue.main.async{
                
                CommonClass.commonSharedInstance.removeSpinner()
                
            }
        }
        
        
        
        
    }
    
    func urlrequestfinish_with_error(error: Error) {
        DispatchQueue.main.async{
            
            CommonClass.commonSharedInstance.removeSpinner()
            
        }
        print("error",error)
    }
    
    //MARK: -Taped image for full screen
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        //let tappedImage = tapGestureRecognizer.view as! UIImageView
        let location = tapGestureRecognizer.location(in: self.networkTableVw)
        let indexPath = self.networkTableVw.indexPathForRow(at: location)
        //print(indexPath!.row)
        //print(indexPath!.section)
        let dict = self.feedlistArr[indexPath!.row] as! NSDictionary
        let img_url = dict["feed_img"] as! String
        let vid_url = dict["feed_vdo"] as! String
        if( vid_url.count > 0 ){
            //self.playVideofromurl(vid_url: vid_url)
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let vidController = storyBoard.instantiateViewController(withIdentifier: "VideoViewController") as! VideoViewController
            vidController.videoUrl = vid_url
            self.navigationController?.pushViewController(vidController, animated: false)
        }else{
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let imgController = storyBoard.instantiateViewController(withIdentifier: "FullScreenImageViewController") as! FullScreenImageViewController
            imgController.imgUrl = img_url
            self.navigationController?.pushViewController(imgController, animated: false)
        }
    }
    
    //MARK: - Refresh Tableview
    @objc func refresh(sender:AnyObject) {
        // Code to refresh table view
        let userData = CommonClass.commonSharedInstance.getUserDetailFromDatabase()
        print("userData",userData)
        
        let detailsData = userData[0] as! NSDictionary
        let user_id = String(describing: detailsData["reg_key"]!)
        
        callApiFor_feedlist(userId: user_id)
        
    }

}

extension NetworkViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.feedlistArr.count
        
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        /*if(indexPath.row == 0){
         
         return 120
         
         }else {*/
        
        let dict = self.feedlistArr[indexPath.row] as! NSDictionary
        let img_url = dict["feed_img"] as! String
        let vid_url = dict["feed_vdo"] as! String
        if(img_url.count > 0 || vid_url.count > 0){
            
            return 320
            
        }else{
            
            return 180
            
        }
        
        //}
        
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        /*if(indexPath.row == 0){
         
         let addFeedCell:addFeedNetworkCell = tableView.dequeueReusableCell(withIdentifier: "addFeedNetworkCell", for: indexPath) as! addFeedNetworkCell
         
         let shadowSize : CGFloat = 5.0
         let shadowPath = UIBezierPath(rect: CGRect(x: -shadowSize / 2,
         y: -shadowSize / 2,
         width: addFeedCell.backVw.frame.size.width + shadowSize,
         height: addFeedCell.backVw.frame.size.height + shadowSize))
         addFeedCell.backVw.layer.masksToBounds = false
         addFeedCell.backVw.layer.shadowColor = UIColor.black.cgColor
         addFeedCell.backVw.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
         addFeedCell.backVw.layer.shadowOpacity = 0.2
         addFeedCell.backVw.layer.shadowPath = shadowPath.cgPath
         
         addFeedCell.memberImgVw.layer.cornerRadius = 20
         addFeedCell.memberImgVw.layer.borderWidth = 1
         addFeedCell.memberImgVw.layer.borderColor = UIColor.black.cgColor
         
         return addFeedCell
         
         }else{*/
        
        let dict = self.feedlistArr[indexPath.row] as! NSDictionary
        let img_url = dict["feed_img"] as! String
        let vid_url = dict["feed_vdo"] as! String
        if(img_url.count > 0 || vid_url.count > 0){
            
            if(vid_url.count > 0){
                
                let imgFeedCell:imageFeedNetworkCell = tableView.dequeueReusableCell(withIdentifier: "imageFeedNetworkCell", for: indexPath) as! imageFeedNetworkCell
                
                let shadowSize : CGFloat = 5.0
                let shadowPath = UIBezierPath(rect: CGRect(x: -shadowSize / 2,
                                                           y: -shadowSize / 2,
                                                           width: imgFeedCell.backVw.frame.size.width + shadowSize,
                                                           height: imgFeedCell.backVw.frame.size.height + shadowSize))
                imgFeedCell.backVw.layer.masksToBounds = false
                imgFeedCell.backVw.layer.shadowColor = UIColor.black.cgColor
                imgFeedCell.backVw.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
                imgFeedCell.backVw.layer.shadowOpacity = 0.2
                imgFeedCell.backVw.layer.shadowPath = shadowPath.cgPath
                
                imgFeedCell.memberImgVw.layer.cornerRadius = 20
                imgFeedCell.memberImgVw.layer.borderWidth = 1
                imgFeedCell.memberImgVw.layer.borderColor = UIColor.black.cgColor
                
                let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
                imgFeedCell.feedImgVw.isUserInteractionEnabled = true
                imgFeedCell.feedImgVw.addGestureRecognizer(tapGestureRecognizer)
                
                imgFeedCell.feedImgVw.image = self.generateThumbnailForVideoAtURL(filePathLocal: vid_url as NSString)
                imgFeedCell.feedContentTxtLbl.text = (dict["feed_content"] as! String)
                
                imgFeedCell.feedPublishByLbl.text = (dict["feed_publish_by"] as! String)
                
                let milisecond = dict["feed_publish_date"] as! String
                let dateVar = Date.init(timeIntervalSince1970: TimeInterval(Int(milisecond)!)/1000)
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "dd-MM-yyyy hh:mm"
                print(dateFormatter.string(from: dateVar))
                
                imgFeedCell.feedPublishDateLbl.text = dateFormatter.string(from: dateVar)
                
                imgFeedCell.feedLikeCountLbl.text = (dict["feed_like_count"] as! String)
                imgFeedCell.feedShareCountLbl.text = String(describing: dict["commentcount"]!)
                imgFeedCell.feedCommentBtn.addTarget(self, action: #selector(comment_buttonSelected), for: .touchUpInside)
                imgFeedCell.feedLikeBtn.addTarget(self, action: #selector(like_buttonSelected), for: .touchUpInside)
                imgFeedCell.feedLikeBtn.tag = 1
                let isLiked = (dict["loggedinuserlike"] as! String)
                if(isLiked == "yes"){
                    imgFeedCell.feedLikeBtn.isSelected = true
                }else{
                    imgFeedCell.feedLikeBtn.isSelected = false
                }
                
                return imgFeedCell
                
                
            }else{
                
                let imgFeedCell:imageFeedNetworkCell = tableView.dequeueReusableCell(withIdentifier: "imageFeedNetworkCell", for: indexPath) as! imageFeedNetworkCell
                
                let shadowSize : CGFloat = 5.0
                let shadowPath = UIBezierPath(rect: CGRect(x: -shadowSize / 2,
                                                           y: -shadowSize / 2,
                                                           width: imgFeedCell.backVw.frame.size.width + shadowSize,
                                                           height: imgFeedCell.backVw.frame.size.height + shadowSize))
                imgFeedCell.backVw.layer.masksToBounds = false
                imgFeedCell.backVw.layer.shadowColor = UIColor.black.cgColor
                imgFeedCell.backVw.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
                imgFeedCell.backVw.layer.shadowOpacity = 0.2
                imgFeedCell.backVw.layer.shadowPath = shadowPath.cgPath
                
                imgFeedCell.memberImgVw.layer.cornerRadius = 20
                imgFeedCell.memberImgVw.layer.borderWidth = 1
                imgFeedCell.memberImgVw.layer.borderColor = UIColor.black.cgColor
                
                let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
                imgFeedCell.feedImgVw.isUserInteractionEnabled = true
                imgFeedCell.feedImgVw.addGestureRecognizer(tapGestureRecognizer)
                
                imgFeedCell.feedImgVw.sd_setImage(with: URL(string: img_url), placeholderImage: UIImage(named: "placeholder.png"))
                imgFeedCell.feedContentTxtLbl.text = (dict["feed_content"] as! String)
                
                imgFeedCell.feedPublishByLbl.text = (dict["feed_publish_by"] as! String)
                
                let milisecond = dict["feed_publish_date"] as! String
                let dateVar = Date.init(timeIntervalSince1970: TimeInterval(Int(milisecond)!)/1000)
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "dd-MM-yyyy hh:mm"
                print(dateFormatter.string(from: dateVar))
                
                imgFeedCell.feedPublishDateLbl.text = dateFormatter.string(from: dateVar)
                
                imgFeedCell.feedLikeCountLbl.text = (dict["feed_like_count"] as! String)
                imgFeedCell.feedShareCountLbl.text = String(describing: dict["commentcount"]!)
                imgFeedCell.feedCommentBtn.addTarget(self, action: #selector(comment_buttonSelected), for: .touchUpInside)
                imgFeedCell.feedLikeBtn.addTarget(self, action: #selector(like_buttonSelected), for: .touchUpInside)
                imgFeedCell.feedLikeBtn.tag = 1
                let isLiked = (dict["loggedinuserlike"] as! String)
                if(isLiked == "yes"){
                    imgFeedCell.feedLikeBtn.isSelected = true
                }else{
                    imgFeedCell.feedLikeBtn.isSelected = false
                }
                
                return imgFeedCell
                
            }
            
            
            
        }else{
            
            let txtFeedCell:txtFeedNetworkCell = tableView.dequeueReusableCell(withIdentifier: "txtFeedNetworkCell", for: indexPath) as! txtFeedNetworkCell
            
            let shadowSize : CGFloat = 5.0
            let shadowPath = UIBezierPath(rect: CGRect(x: -shadowSize / 2,
                                                       y: -shadowSize / 2,
                                                       width: txtFeedCell.backVw.frame.size.width + shadowSize,
                                                       height: txtFeedCell.backVw.frame.size.height + shadowSize))
            txtFeedCell.backVw.layer.masksToBounds = false
            txtFeedCell.backVw.layer.shadowColor = UIColor.black.cgColor
            txtFeedCell.backVw.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
            txtFeedCell.backVw.layer.shadowOpacity = 0.2
            txtFeedCell.backVw.layer.shadowPath = shadowPath.cgPath
            
            txtFeedCell.memberImgVw.layer.cornerRadius = 20
            txtFeedCell.memberImgVw.layer.borderWidth = 1
            txtFeedCell.memberImgVw.layer.borderColor = UIColor.black.cgColor
            
            txtFeedCell.feedContentTxtLbl.text = (dict["feed_content"] as! String)
            
            txtFeedCell.feedPublishByLbl.text = (dict["feed_publish_by"] as! String)
            
            let milisecond = dict["feed_publish_date"] as! String
            let dateVar = Date.init(timeIntervalSince1970: TimeInterval(Int(milisecond)!)/1000)
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd-MM-yyyy hh:mm"
            print(dateFormatter.string(from: dateVar))
            
            txtFeedCell.feedPublishDateLbl.text = dateFormatter.string(from: dateVar)
            
            txtFeedCell.feedLikeCountLbl.text = (dict["feed_like_count"] as! String)
            txtFeedCell.feedShareCountLbl.text = String(describing: dict["commentcount"]!)
            txtFeedCell.feedCommentBtn.addTarget(self, action: #selector(comment_buttonSelected), for: .touchUpInside)
            txtFeedCell.feedLikeBtn.addTarget(self, action: #selector(like_buttonSelected), for: .touchUpInside)
            txtFeedCell.feedLikeBtn.tag = 2
            let isLiked = (dict["loggedinuserlike"] as! String)
            if(isLiked == "yes"){
                txtFeedCell.feedLikeBtn.isSelected = true
            }else{
                txtFeedCell.feedLikeBtn.isSelected = false
            }
            
            return txtFeedCell
            
        }
        
        //}
        
        
    }
    
    
    
    
    
}
