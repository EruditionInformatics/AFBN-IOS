//
//  TermsViewController.swift
//  AFBN
//
//  Created by Erudition Informatics on 26/04/19.
//  Copyright © 2019 Erudition Informatics. All rights reserved.
//

import UIKit

class termsTxtTableViewCell : UITableViewCell {
    
    @IBOutlet weak var txtVw: UITextView!
    
}

class termsTxtAndButtonViewCell : UITableViewCell {
    
    @IBOutlet weak var headerLbl : UILabel!
    @IBOutlet weak var textVw: UITextView!
    @IBOutlet weak var nextBtn : UIButton!
    
}

class TermsViewController: UIViewController {
    
    @IBOutlet weak var termTableVw: UITableView!

    @IBOutlet weak var buttonImgVw: UIImageView!
    
    @IBOutlet weak var termsBtn: UIButton!
    @IBOutlet weak var contactsBtn: UIButton!
    @IBOutlet weak var companyInfoBtn: UIButton!
    @IBOutlet weak var referenceBtn: UIButton!
    
    @IBOutlet weak var buttonVw: UIView!
    
    
    
    //MARK: View Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    //MARK: Button Action
    @IBAction func termsBtnAction(_ sender: UIButton) {
        buttonImgVw.image = UIImage(named: "terms_selected")
        
//        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//        let termsController = storyBoard.instantiateViewController(withIdentifier: "TermsViewController") as! TermsViewController
//        //self.present(singInController, animated: true, completion: nil)
//        self.navigationController?.pushViewController(termsController, animated: false)
        
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
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let referenceController = storyBoard.instantiateViewController(withIdentifier: "ReferenceViewController") as! ReferenceViewController
        //self.present(singInController, animated: true, completion: nil)
        self.navigationController?.pushViewController(referenceController, animated: false)
        
    }

    func calculateHeight(inString:String) -> CGFloat
    {
        let messageString = inString
        let attributes : [NSAttributedString.Key : Any] = [NSAttributedString.Key(rawValue: NSAttributedString.Key.font.rawValue) : UIFont.systemFont(ofSize: 15.0)]
        
        let attributedString : NSAttributedString = NSAttributedString(string: messageString, attributes: attributes)
        
        let rect : CGRect = attributedString.boundingRect(with: CGSize(width: 375.0, height: CGFloat.greatestFiniteMagnitude), options: .usesLineFragmentOrigin, context: nil)
        
        let requredSize:CGRect = rect
        return requredSize.height
    }
    
}

extension TermsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 2
        
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if(indexPath.row == 0){
            
            let heightOfRow = self.calculateHeight(inString: Constant.constant.str1)
            
            return (heightOfRow + 80)
            
        }else{
            
            let heightOfRow = self.calculateHeight(inString: Constant.constant.str2)
            
            return (heightOfRow + 60)
            
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if(indexPath.row == 0){
            
            let termsTxtVwViewCell:termsTxtTableViewCell = tableView.dequeueReusableCell(withIdentifier: "termsTxtTableViewCell", for: indexPath) as! termsTxtTableViewCell
            termsTxtVwViewCell.txtVw.text = Constant.constant.str1
            
            return termsTxtVwViewCell
            
        }else{
            
            let termsTxtandBtnVwViewCell:termsTxtAndButtonViewCell = tableView.dequeueReusableCell(withIdentifier: "termsTxtAndButtonViewCell", for: indexPath) as! termsTxtAndButtonViewCell
            termsTxtandBtnVwViewCell.textVw.text = Constant.constant.str2
            
            return termsTxtandBtnVwViewCell
            
        }
        
        
    }
    
    
    
    
    
}
