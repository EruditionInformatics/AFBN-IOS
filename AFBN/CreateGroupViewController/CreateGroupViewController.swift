//
//  CreateGroupViewController.swift
//  AFBN
//
//  Created by Erudition Informatics on 01/05/19.
//  Copyright © 2019 Erudition Informatics. All rights reserved.
//

import UIKit

class chosememberTableVwCell: UITableViewCell{
    
    @IBOutlet weak var ticButton:UIButton!
    @IBOutlet weak var memberNameLbl:UILabel!
    @IBOutlet weak var addressLbl:UILabel!
    
}

class chosedmemberTableCell:UITableViewCell{
    @IBOutlet weak var memberNameLbl:UILabel!
}

class CreateGroupViewController: UIViewController {
    
    @IBOutlet weak var backSubVw:UIView!
    @IBOutlet weak var chosememberVw: UIView!
    @IBOutlet weak var chosedmemberVw: UIView!
    
    @IBOutlet weak var chosememberTableVw:UITableView!
    @IBOutlet weak var chosedmemberTableVw:UITableView!
    
    var tic_button:UIButton!
    var ticButtonSelectedArray:[String] = []

    //MARK: View Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        setSelectedArray()
        setShadowOnSubVw()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    func setShadowOnSubVw(){
        
        let shadowSize : CGFloat = 5.0
        let shadowPath = UIBezierPath(rect: CGRect(x: -shadowSize / 2,
                                                   y: -shadowSize / 2,
                                                   width: self.chosememberVw.frame.size.width + shadowSize,
                                                   height: self.chosememberVw.frame.size.height + shadowSize))
        self.chosememberVw.layer.masksToBounds = false
        self.chosememberVw.layer.shadowColor = UIColor.black.cgColor
        self.chosememberVw.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        self.chosememberVw.layer.shadowOpacity = 0.2
        self.chosememberVw.layer.shadowPath = shadowPath.cgPath
        
        let shadowPath1 = UIBezierPath(rect: CGRect(x: -shadowSize / 2,
                                                   y: -shadowSize / 2,
                                                   width: self.chosedmemberVw.frame.size.width + shadowSize,
                                                   height: self.chosedmemberVw.frame.size.height + shadowSize))
        self.chosedmemberVw.layer.masksToBounds = false
        self.chosedmemberVw.layer.shadowColor = UIColor.black.cgColor
        self.chosedmemberVw.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        self.chosedmemberVw.layer.shadowOpacity = 0.2
        self.chosedmemberVw.layer.shadowPath = shadowPath1.cgPath
        
    }
    
    //MARK: Set selected Array
    func setSelectedArray(){
        
        for _ in 1...25{
            ticButtonSelectedArray.append("0")
        }
        print("ticButtonSelectedArray:",ticButtonSelectedArray,ticButtonSelectedArray.count)
        self.chosememberTableVw.reloadData()
    }

}

extension CreateGroupViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if(tableView == self.chosememberTableVw){
            return self.ticButtonSelectedArray.count
        }else{
            return 5
        }
        
    }
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if(tableView == self.chosememberTableVw){
            return 80
        }else{
            return 30
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if(tableView == self.chosememberTableVw){
            
            let chosemember_TableVwCell:chosememberTableVwCell = tableView.dequeueReusableCell(withIdentifier: "chosememberTableVwCell", for: indexPath) as! chosememberTableVwCell
            
            chosemember_TableVwCell.ticButton.layer.borderWidth = 2
            chosemember_TableVwCell.ticButton.layer.borderColor = UIColor.darkGray.cgColor
            chosemember_TableVwCell.ticButton.addTarget(self, action: #selector(self.tic_buttonAction(_:)), for: .touchUpInside)
            chosemember_TableVwCell.ticButton.tag = indexPath.row
            
            if(ticButtonSelectedArray[indexPath.row] == "0"){
                
                chosemember_TableVwCell.ticButton.isSelected = false
                chosemember_TableVwCell.ticButton.backgroundColor = UIColor.white
                
            }else{
                
                chosemember_TableVwCell.ticButton.isSelected = true
                chosemember_TableVwCell.ticButton.backgroundColor = UIColor(red: 91.0/255.0, green: 141.0/255.0, blue: 92.0/255.0, alpha: 1.0)
                
            }
            
            return chosemember_TableVwCell
            
        }else{
            
            let chosedmember_TableVwCell:chosedmemberTableCell = tableView.dequeueReusableCell(withIdentifier: "chosedmemberTableCell", for: indexPath) as! chosedmemberTableCell
            
            return chosedmember_TableVwCell
            
        }
        
        
    }
    
    
    //MARK:The target function
    @objc func tic_buttonAction(_ sender: UIButton){
        print("tic_buttonAction\(sender)")
        self.tic_button = sender
        let index = self.tic_button.tag
        if(self.tic_button.isSelected != true){
            self.tic_button.backgroundColor = UIColor(red: 91.0/255.0, green: 141.0/255.0, blue: 92.0/255.0, alpha: 1.0)
            self.tic_button.isSelected = true
            self.ticButtonSelectedArray[index] = "1"
        }else{
            self.tic_button.backgroundColor = UIColor.white
            self.tic_button.isSelected = false
            self.ticButtonSelectedArray[index] = "0"
        }
        
        self.chosememberTableVw.reloadData()
        
    }
    
    
    
    
}
