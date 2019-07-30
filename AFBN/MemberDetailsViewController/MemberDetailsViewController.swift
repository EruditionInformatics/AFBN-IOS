//
//  MemberDetailsViewController.swift
//  AFBN
//
//  Created by Erudition Informatics on 01/05/19.
//  Copyright © 2019 Erudition Informatics. All rights reserved.
//

import UIKit

class memberDetailsImageCell:UITableViewCell{
 
    
    
    
}

class memberDetailsAddressCell:UITableViewCell{
    
    
    
    
}

class memberDetailsContactCell:UITableViewCell{
    
    
    
    
}
class memberDetailsButtonCell:UITableViewCell{
    
    
    
}

class MemberDetailsViewController: UIViewController {
    
    @IBOutlet weak var memberDetailsTableVw:UITableView!

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

}

extension MemberDetailsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 4
        
        
    }
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if(indexPath.row == 0){
            return 200
        }else if(indexPath.row == 1){
            return 100
        }else if(indexPath.row == 2){
            return 300
        }else{
            return 100
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if(indexPath.row == 0){
            let image_Cell:memberDetailsImageCell = tableView.dequeueReusableCell(withIdentifier: "memberDetailsImageCell", for: indexPath) as! memberDetailsImageCell
            
            return image_Cell
        }else if(indexPath.row == 1){
            let address_Cell:memberDetailsAddressCell = tableView.dequeueReusableCell(withIdentifier: "memberDetailsAddressCell", for: indexPath) as! memberDetailsAddressCell
            
            return address_Cell
        }else if(indexPath.row == 2){
            let contacts_Cell:memberDetailsContactCell = tableView.dequeueReusableCell(withIdentifier: "memberDetailsContactCell", for: indexPath) as! memberDetailsContactCell
            
            return contacts_Cell
        }else{
            let button_Cell:memberDetailsButtonCell = tableView.dequeueReusableCell(withIdentifier: "memberDetailsButtonCell", for: indexPath) as! memberDetailsButtonCell
            
            return button_Cell
        }
    }
    
    
    //MARK:The target function
//    @objc func manageAllbuttonAction(_ sender: UIButton){
//        print("manageAllbuttonAction\(sender)")
//
//    }
    
    
    
    
}
