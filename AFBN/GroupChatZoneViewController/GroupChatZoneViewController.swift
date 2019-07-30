//
//  GroupChatZoneViewController.swift
//  AFBN
//
//  Created by Erudition Informatics on 08/05/19.
//  Copyright © 2019 Erudition Informatics. All rights reserved.
//

import UIKit

class groupChatTableVwCell:UITableViewCell{
    
    @IBOutlet weak var groupChatImg:UIImageView!
    @IBOutlet weak var groupChatNameLbl:UILabel!
    @IBOutlet weak var groupchatCountLbl:UILabel!
    
}

class GroupChatZoneViewController: UIViewController {
    
    @IBOutlet weak var groupChatTableVw:UITableView!
    @IBOutlet weak var groupchatMsgCountLbl:UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setView()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    //MARK: set view design
    func setView(){
        
        groupchatMsgCountLbl.layer.cornerRadius = 25
        groupchatMsgCountLbl.layer.borderWidth = 1
        groupchatMsgCountLbl.layer.borderColor = UIColor.white.cgColor
        
    }
    //MARK: Button Action
    @IBAction func createGroupBtnAction(_ sender: UIButton) {
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let createGroupController = storyBoard.instantiateViewController(withIdentifier: "CreateGroupViewController") as! CreateGroupViewController
        //self.present(singInController, animated: true, completion: nil)
        createGroupController.hidesBottomBarWhenPushed = false
        self.navigationController?.pushViewController(createGroupController, animated: true)
        
    }

}

extension GroupChatZoneViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 20
        
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 80
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let groupChatCell:groupChatTableVwCell = tableView.dequeueReusableCell(withIdentifier: "groupChatTableVwCell", for: indexPath) as! groupChatTableVwCell
        
        groupChatCell.groupChatImg.layer.cornerRadius = 35
        groupChatCell.groupChatImg.layer.borderWidth = 1
        groupChatCell.groupChatImg.layer.borderColor = UIColor.black.cgColor
        
        groupChatCell.groupchatCountLbl.layer.cornerRadius = 25
        groupChatCell.groupchatCountLbl.layer.borderWidth = 1
        groupChatCell.groupchatCountLbl.layer.borderColor = UIColor.black.cgColor
        
        
        return groupChatCell
        
        
    }
    
    
    
    
    
}
