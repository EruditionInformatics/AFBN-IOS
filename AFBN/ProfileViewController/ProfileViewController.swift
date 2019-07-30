//
//  ProfileViewController.swift
//  AFBN
//
//  Created by Erudition Informatics on 25/04/19.
//  Copyright © 2019 Erudition Informatics. All rights reserved.
//

import UIKit

class profileCollectionViewCell:UICollectionViewCell{
    @IBOutlet weak var iconImgVw:UIImageView!
    @IBOutlet weak var titleTxtLbl:UILabel!
}

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var moreBtn: UIButton!
    @IBOutlet weak var rightArrowBtn: UIButton!
    
    var icon_imgArray = [String]()
    var icon_titleArray = [String]()
    
    @IBOutlet weak var profileCollectionView: UICollectionView!

    //MARK: View Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        icon_imgArray = ["company_details","relationship_contacts","photos","videos","company_profile","posts_feed","quotations","invoices","reports"]
        icon_titleArray = ["Company Details","Relationship Contacts","Photos","Videos","Company Profile","Posts Feed","Quotation","Invoices","Reports"]
        
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

}

//MARK: Collectionview Delegates and DataSource
extension ProfileViewController: UICollectionViewDelegate , UICollectionViewDataSource ,UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int
    {
        return 1;
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 9
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let collectionViewCell:profileCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "profileCollectionViewCell", for: indexPath) as! profileCollectionViewCell
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
    
    
}
