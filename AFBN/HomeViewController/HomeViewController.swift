//
//  HomeViewController.swift
//  AFBN
//
//  Created by Erudition Informatics on 25/04/19.
//  Copyright © 2019 Erudition Informatics. All rights reserved.
//

import UIKit


class homeCollectionViewCell:UICollectionViewCell{
    @IBOutlet weak var iconImgVw:UIImageView!
    @IBOutlet weak var titleTxtLbl:UILabel!
}

class HomeViewController: UIViewController {

    @IBOutlet weak var moreBtn: UIButton!
    @IBOutlet weak var rightArrowBtn: UIButton!
    
    @IBOutlet weak var homeCollectionView: UICollectionView!
    
    var icon_imgArray = [String]()
    var icon_titleArray = [String]()
    
    //MARK: View Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        icon_imgArray = ["members","network","tabbar_profile","group_chat_zone","quotation_tracking","invoice_tracking","business_exchange","anual_events","library","company_indication","user_report"]
        icon_titleArray = ["Members","Network","My Profile","Group Chat Zone","Quotation Tracking","Invoice Tracking","Business Exchange","Annual Events","Library","Company Indication","User Report"]
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    //MARK: Top Bar Button Action
    @IBAction func moreBtnAction(_ sender: UIButton) {
    }
    @IBAction func rightArrowBtnAction(_ sender: UIButton) {
    }
    
    /*override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "member_segue" {
            if segue.destination is MembersViewController {
                print("segue working")
                
            }
        }
    
    }*/
}

//MARK: Collectionview Delegates and DataSource
extension HomeViewController: UICollectionViewDelegate , UICollectionViewDataSource ,UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int
    {
        return 1;
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 11
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let collectionViewCell:homeCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "homeCollectionViewCell", for: indexPath) as! homeCollectionViewCell
        collectionViewCell.layer.shadowColor = UIColor.gray.cgColor
        collectionViewCell.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        collectionViewCell.layer.shadowRadius = 2.0
        collectionViewCell.layer.shadowOpacity = 1.0
        collectionViewCell.layer.masksToBounds = false
        collectionViewCell.layer.shadowPath=UIBezierPath(roundedRect:collectionViewCell.bounds,cornerRadius:collectionViewCell.contentView.layer.cornerRadius).cgPath
        
        collectionViewCell.iconImgVw.image = UIImage(named: icon_imgArray[indexPath.item])
        collectionViewCell.titleTxtLbl.text = icon_titleArray[indexPath.item]
        
        return collectionViewCell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        //let padding: CGFloat =  50
        let collectionViewSize = collectionView.frame.size.width - 20.0
        
        return CGSize(width: collectionViewSize/2, height: 100.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath){
        
        if(indexPath.item == 0){
            //self.performSegue(withIdentifier: "member_segue", sender: self)
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let memberController = storyBoard.instantiateViewController(withIdentifier: "MembersViewController") as! MembersViewController
            //self.present(singInController, animated: true, completion: nil)
            memberController.hidesBottomBarWhenPushed = false
            self.navigationController?.pushViewController(memberController, animated: true)
            
        }else if(indexPath.item == 1){
            //self.performSegue(withIdentifier: "member_segue", sender: self)
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let networkController = storyBoard.instantiateViewController(withIdentifier: "NetworkViewController") as! NetworkViewController
            //self.present(singInController, animated: true, completion: nil)
            networkController.hidesBottomBarWhenPushed = false
            self.navigationController?.pushViewController(networkController, animated: true)
            
        }else if(indexPath.item == 3){
            //self.performSegue(withIdentifier: "member_segue", sender: self)
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let groupChatController = storyBoard.instantiateViewController(withIdentifier: "GroupChatZoneViewController") as! GroupChatZoneViewController
            //self.present(singInController, animated: true, completion: nil)
            //networkController.hidesBottomBarWhenPushed = false
            self.navigationController?.pushViewController(groupChatController, animated: true)
            
        }else if(indexPath.item == 4){
            //self.performSegue(withIdentifier: "member_segue", sender: self)
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let quotationTrackingController = storyBoard.instantiateViewController(withIdentifier: "QuotationTrackingViewController") as! QuotationTrackingViewController
            //self.present(singInController, animated: true, completion: nil)
            //networkController.hidesBottomBarWhenPushed = false
            self.navigationController?.pushViewController(quotationTrackingController
                , animated: true)
            
        }else if(indexPath.item == 5){
            //self.performSegue(withIdentifier: "member_segue", sender: self)
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let invoicesTrackingController = storyBoard.instantiateViewController(withIdentifier: "InvoicesTrackingViewController") as! InvoicesTrackingViewController
            //self.present(singInController, animated: true, completion: nil)
            //networkController.hidesBottomBarWhenPushed = false
            self.navigationController?.pushViewController(invoicesTrackingController
                , animated: true)
            
        }
        
    }
    
    
}

