//
//  CommonClass.swift
//  AFBN
//
//  Created by Erudition Informatics on 26/04/19.
//  Copyright © 2019 Erudition Informatics. All rights reserved.
//

import UIKit
import CoreData

class CommonClass: NSObject {

    static let commonSharedInstance = CommonClass()
    
    var contactDict:NSDictionary = [:]
    var companyInfoDict:NSDictionary = [:]
    var referenceDict:NSDictionary = [:]
    
    var vSpinner:UIView!
    
    func showSpinner(onView : UIView) {
        let spinnerView = UIView.init(frame: onView.bounds)
        spinnerView.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        let ai = UIActivityIndicatorView.init(style: .whiteLarge)
        ai.startAnimating()
        ai.center = spinnerView.center
        
        DispatchQueue.main.async {
            spinnerView.addSubview(ai)
            onView.addSubview(spinnerView)
        }
        
        vSpinner = spinnerView
    }
    
    func removeSpinner() {
        DispatchQueue.main.async {
            self.vSpinner?.removeFromSuperview()
            self.vSpinner = nil
        }
    }

    //MARK: Show alert view
    func show_alert(alert_title:String,btn_title:String,msg:String,presentingClass:UIViewController){
        
        let alert = UIAlertController(title: alert_title, message: msg, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: btn_title, style: .default, handler: { action in
            switch action.style{
            case .default:
                print("default")
                
            case .cancel:
                print("cancel")
                
            case .destructive:
                print("destructive")
                
                
            @unknown default:
                print("default")
            }}))
        presentingClass.present(alert, animated: true, completion: nil)
        
    }
    
    func isObjectNotNil(object:AnyObject!) -> Bool
    {
        if let _:AnyObject = object
        {
            return true
        }
        
        return false
    }
    
    //MARK: CoreData Methods
    
    func saveDatabase(user_data:NSDictionary){
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        // 1
        let managedContext =
            appDelegate.persistentContainer.viewContext
        
        // 2
        let entity =
            NSEntityDescription.entity(forEntityName: "Feedlist",
                                       in: managedContext)!
        
        let user_detail = NSManagedObject(entity: entity,
                                          insertInto: managedContext)
        
        // 3
        user_detail.setValue(user_data, forKeyPath: "feed")
        
        // 4
        do {
            
            try managedContext.save()
            
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    func getFeedlistFromDatabase() -> NSMutableArray{
        
        let saved_userArray:NSMutableArray = []
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        
        // 1
        let managedContext =
            appDelegate?.persistentContainer.viewContext
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Feedlist")
        //request.predicate = NSPredicate(format: "age = %@", "12")
        request.returnsObjectsAsFaults = false
        do {
            
            let result = try managedContext!.fetch(request)
            
            for data in result as! [NSManagedObject] {
                print("getFeedlistFromDatabase singin_details::",data.value(forKey: "feed") as! NSDictionary)
                let user_data = data.value(forKey: "feed") as! NSDictionary
                saved_userArray.add(user_data)
                //return saved_userArray
                
            }
            
        } catch {
            
            print("Failed")
        }
        
        return saved_userArray
    }
    
    
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
    
    func deleteFeedData(){
        
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        
        // 1
        let managedContext =
            appDelegate?.persistentContainer.viewContext
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Feedlist")
        
        request.returnsObjectsAsFaults = false
        do {
            
            let result = try managedContext!.fetch(request)
            
            for data in result as! [NSManagedObject] {
                
                managedContext!.delete(data)
                
            }
            
        } catch {
            
            print("Failed")
        }
        
        
        
    }
    
}
