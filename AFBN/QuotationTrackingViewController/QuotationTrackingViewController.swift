//
//  QuotationTrackingViewController.swift
//  AFBN
//
//  Created by Erudition Informatics on 10/05/19.
//  Copyright © 2019 Erudition Informatics. All rights reserved.
//

import UIKit

class QuotationTrackingCollectionViewCell:UICollectionViewCell{
    
    @IBOutlet weak var iconImgVw:UIImageView!
    @IBOutlet weak var titleTxtLbl:UILabel!
    
}

class QuotationTrackingViewController: UIViewController {
    
    @IBOutlet weak var quotationTrackingCollectionVw:UICollectionView!
    
    var icon_imgArray = [String]()
    var icon_titleArray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        icon_imgArray = ["invoices_tracking1","invoices_tracking2","invoices_tracking3","invoices_tracking4"]
        icon_titleArray = ["Quotation","Quotation Statistics","Received\nQuotation","Received Quotation\nStatistics"]
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

//MARK: Collectionview Delegates and DataSource
extension QuotationTrackingViewController: UICollectionViewDelegate , UICollectionViewDataSource ,UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int
    {
        return 1;
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let collectionViewCell:QuotationTrackingCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "QuotationTrackingCollectionViewCell", for: indexPath) as! QuotationTrackingCollectionViewCell
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
            
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let quotationController = storyBoard.instantiateViewController(withIdentifier: "QuotationViewController") as! QuotationViewController
            //self.present(singInController, animated: true, completion: nil)
            self.navigationController?.pushViewController(quotationController, animated: true)
            
        }
        
    }
    
    
}
