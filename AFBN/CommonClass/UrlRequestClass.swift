//
//  UrlRequestClass.swift
//  AFBN
//
//  Created by Erudition Informatics on 26/04/19.
//  Copyright © 2019 Erudition Informatics. All rights reserved.
//

import UIKit
import MobileCoreServices

protocol urlrequestprotocol{
    
    func urlrequestfinish_with_success(data:NSDictionary,requestType:String,request_class:UIViewController,tag:String)
    func urlrequestfinish_with_error(error:Error)
    
}

class UrlRequestClass: NSObject {
    
    static let UrlRequestSharedInstance = UrlRequestClass()
    
    var urlrequestDelegate:urlrequestprotocol?
    
    //MARK: - Registration Urlrequest
    func getRegister(contactDict:NSDictionary,companyInfoDict:NSDictionary,referenceDict:NSDictionary,file_path:String,viewcontroller_class:UIViewController,tag:String){
        
        print("contactDict",contactDict)
        print("companyInfoDict",companyInfoDict)
        print("referenceDict",referenceDict)
        
        let contactArr = contactDict["contactInfo"] as! NSArray
        let dict1 = contactArr[0] as! NSDictionary
        let dict2 = contactArr[1] as! NSDictionary
        let dict3 = contactArr[2] as! NSDictionary
        let copanyInfoArr = contactDict["companyInfo"] as! NSArray
        let dic1 = copanyInfoArr[0] as! NSDictionary
        let dic2 = copanyInfoArr[1] as! NSDictionary
        let dic3 = copanyInfoArr[2] as! NSDictionary
        let dic4 = copanyInfoArr[3] as! NSDictionary
        let dic5 = copanyInfoArr[4] as! NSDictionary
        let dic6 = copanyInfoArr[5] as! NSDictionary
        let referenceInfoArr = referenceDict["referenceInfo"] as! NSArray
        let dictn1 = referenceInfoArr[0] as! NSDictionary
        let dictn2 = referenceInfoArr[1] as! NSDictionary
        let dictn3 = referenceInfoArr[2] as! NSDictionary
        let dictn4 = referenceInfoArr[3] as! NSDictionary
        let dictn5 = referenceInfoArr[4] as! NSDictionary
        let dictn6 = referenceInfoArr[5] as! NSDictionary
        
        let parameters = ["reg_key_cont_name":dict1["name"] as! String,
            "reg_key_cont_position":dict1["position"] as! String,
            "reg_key_cont_email":dict1["email"] as! String,
            "reg_key_cont_mobile":dict1["mobile"] as! String,
            "reg_key_cont_emergency_no":dict1["emergency_no"] as! String,
            "reg_key_cont_skype":dict1["skype_id"] as! String,
            "reg_sec_cont_name":dict2["name"] as! String,
            "reg_sec_cont_position":dict2["position"] as! String,
            "reg_sec_cont_email":dict2["email"] as! String,
            "reg_sec_cont_mobile":dict2["mobile"] as! String,
            "reg_sec_cont_emergency_no":dict2["emergency_no"] as! String,
            "reg_sec_cont_skype":dict2["skype_id"] as! String,
            "reg_pref_usr_name":dict3["user_name"] as! String,
            "reg_pref_usr_pw":dict3["password"] as! String,
            "company_name":dic1["company_name"] as! String,
            "year_of_estublishment":dic1["year_east"] as! String,
            "summary_about_the_company":dic1["company_summary"] as! String,
            "company_website":dic1["website"] as! String,
            "tell_number":dic1["tell_no"] as! String,
            "fax_number":dic1["fax_no"] as! String,
            "emergency_no":dic1["emergency_no"] as! String,
            "amount_of_stuff":dic1["staff_amount"] as! String,
            "amount_of_branches":dic1["branch_amount"] as! String,
            "location_of_branches":dic1["branch_location"] as! String,
            "amount_of_locations":dic1["location_amount"] as! String,
            "branches_address":dic1["branch_address"] as! String,
            "please_state_your_annual_sales_volume_for_your_firm_in_the_us":dic1["anual_sales"] as! String,
            "please_advise_us_of_your_annual_tonnage_for_air_and_ocean_freigh":dic1["anual_tonnage"] as! String,
            "company_profile":dic2["company_profile"] as! String,
            "motor_carrier":dic3["carrier"] as! String,
            "export_packaging_facility":dic3["packing_facility"] as! String,
            "export_managment_company":dic3["meng_company"] as! String,
            "int_consultant":dic3["int_consultant"] as! String,
            "licenced_custom_house_brokerage_operation":dic3["brokarage_opt"] as! String,
            "other_membership_certificate":dic3["membership_cert"] as! String,
            "FMC_Licenced_Foreign_Freight_Forwarder_License_Number":dic3["license_no"] as! String,
            "NVOCC_no":dic3["nvocc_no"] as! String,
            "iata_sale_aget":dic3["sales_agents"] as! String,
            "ISO9001_2015_regis":dic3["iso9002_registered"] as! String,
            "custom_house_broker_license":dic3["brokarage_opt"] as! String,
            "address_line1":dic4["line1"] as! String,
            "address_line2":dic4["line2"] as! String,
            "address_line3":dic4["line3"] as! String,
            "pobox":dic4["p.o.box"] as! String,
            "city":dic4["city"] as! String,
            "coutry":dic4["country"] as! String,
            "phoe":dic4["phone"] as! String,
            "fax":dic4["fax"] as! String,
            "afbn_reason":dic5["reasons"] as! String,
            "market_strength":dic6["reasons"] as! String,
            "company_1_name":dictn1["company_name"] as! String,
            "company_1_type":dictn1["business_type"] as! String,
            "company_1_contact":dictn1["contact"] as! String,
            "company_1_position":dictn1["position"] as! String,
            "company_1_country":dictn1["country"] as! String,
            "company_1_city":dictn1["city"] as! String,
            "company_1_mobile":dictn1["mobile"] as! String,
            "company_1_phone":dictn1["phone"] as! String,
            "company_1_fax":dictn1["fax"] as! String,
            "company_1_email":dictn1["email"] as! String,
            "company_1_emergencyno":dictn1["emergency_no"] as! String,
            "company_2_name":dictn2["company_name"] as! String,
            "company_2_type":dictn2["business_type"] as! String,
            "company_2_contact":dictn2["contact"] as! String,
            "company_2_position":dictn2["position"] as! String,
            "company_2_country":dictn2["country"] as! String,
            "company_2_city":dictn2["city"] as! String,
            "company_2_mobile":dictn2["mobile"] as! String,
            "company_2_phone":dictn2["phone"] as! String,
            "company_2_fax":dictn2["fax"] as! String,
            "company_2_email":dictn2["email"] as! String,
            "company_2_emergencyno":dictn2["emergency_no"] as! String,
            "company_3_name":dictn3["company_name"] as! String,
            "company_3_type":dictn3["business_type"] as! String,
            "company_3_contact":dictn3["contact"] as! String,
            "company_3_position":dictn3["position"] as! String,
            "company_3_country":dictn3["country"] as! String,
            "company_3_city":dictn3["city"] as! String,
            "company_3_mobile":dictn3["mobile"] as! String,
            "company_3_phone":dictn3["phone"] as! String,
            "company_3_fax":dictn3["fax"] as! String,
            "company_3_email":dictn3["email"] as! String,
            "company_3_emergencyno":dictn3["emergency_no"] as! String,
            "clinet_1_company":dictn4["company_name"] as! String,
            "clinet_1_contact":dictn4["contact"] as! String,
            "clinet_1_position":dictn3["position"] as! String,
            "clinet_1_country":dictn3["country"] as! String,
            "clinet_1_city":dictn3["city"] as! String,
            "clinet_1_mobile":dictn3["mobile"] as! String,
            "clinet_1_phone":dictn3["phone"] as! String,
            "clinet_1_fax":dictn3["fax"] as! String,
            "clinet_1_email":dictn3["email"] as! String,
            "clinet_1_emergencyno":dictn3["emergency_no"] as! String,
            "clinet_2_company":dictn5["company_name"] as! String,
            "clinet_2_contact":dictn5["contact"] as! String,
            "clinet_2_position":dictn5["position"] as! String,
            "clinet_2_country":dictn5["country"] as! String,
            "clinet_2_city":dictn5["city"] as! String,
            "clinet_2_mobile":dictn5["mobile"] as! String,
            "clinet_2_phone":dictn5["phone"] as! String,
            "clinet_2_fax":dictn5["fax"] as! String,
            "clinet_2_email":dictn5["email"] as! String,
            "clinet_2_emergencyno":dictn5["emergency_no"] as! String,
            "clinet_3_company":dictn6["company_name"] as! String,
            "clinet_3_contact":dictn6["contact"] as! String,
            "clinet_3_position":dictn6["position"] as! String,
            "clinet_3_country":dictn6["country"] as! String,
            "clinet_3_city":dictn6["city"] as! String,
            "clinet_3_mobile":dictn6["mobile"] as! String,
            "clinet_3_phone":dictn6["phone"] as! String,
            "clinet_3_fax":dictn6["fax"] as! String,
            "clinet_3_email":dictn6["email"] as! String,
            "clinet_3_emergencyno":dictn6["emergency_no"] as! String]
        
        let boundary = generateBoundaryString()
        
        //create the url with URL
        let url = URL(string: Constant.BASE_URL + Constant.REGISTRATION_URL)! //change the url
        
        //create the session object
        let session = URLSession.shared
        
        //now create the URLRequest object using the url object
        var request = URLRequest(url: url)
        request.httpMethod = "POST" //set http method as POST
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        //let path1 = Bundle.main.path(forResource: "image1", ofType: "png")!
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted) // pass dictionary to nsdata object and set it as request body
            //request.httpBody = try createBody( filePathKey: "file", paths: [path1], boundary: boundary)
        } catch let error {
            //print(error.localizedDescription)
            self.urlrequestDelegate?.urlrequestfinish_with_error(error: error)
        }
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        //create dataTask using the session object to send data to the server
        let task = session.dataTask(with: request as URLRequest, completionHandler: { data, response, error in
            
            guard error == nil else {
                return
            }
            
            guard let data = data else {
                return
            }
            
            do {
                //create json object from data
                if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] {
                    //print(json)
                    self.urlrequestDelegate?.urlrequestfinish_with_success(data: json as NSDictionary, requestType: Constant.REGISTRATION_URL,request_class: viewcontroller_class,tag:tag)
                    // handle json...
                }
            } catch let error {
                print(error.localizedDescription)
                self.urlrequestDelegate?.urlrequestfinish_with_error(error: error)
            }
        })
        task.resume()
        
    }
    
    //MARK: - Login Urlrequest
    func getSingin(email:String,password:String,viewcontroller_class:UIViewController,tag:String){
        
        let parameters = ["email_id": email,"password": password] as [String : Any]
        
        //create the url with URL
        let url = URL(string: Constant.BASE_URL + Constant.SINGIN_URL)! //change the url
        
        //create the session object
        let session = URLSession.shared
        
        //now create the URLRequest object using the url object
        var request = URLRequest(url: url)
        request.httpMethod = "POST" //set http method as POST
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted) // pass dictionary to nsdata object and set it as request body
        } catch let error {
            print(error.localizedDescription)
            self.urlrequestDelegate?.urlrequestfinish_with_error(error: error)
        }
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        //create dataTask using the session object to send data to the server
        let task = session.dataTask(with: request as URLRequest, completionHandler: { data, response, error in
            
            guard error == nil else {
                return
            }
            
            guard let data = data else {
                return
            }
            
            do {
                //create json object from data
                if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] {
                    //print(json)
                    self.urlrequestDelegate?.urlrequestfinish_with_success(data: json as NSDictionary, requestType: Constant.SINGIN_URL,request_class: viewcontroller_class,tag:tag)
                    // handle json...
                }
            } catch let error {
                print(error.localizedDescription)
                self.urlrequestDelegate?.urlrequestfinish_with_error(error: error)
            }
        })
        task.resume()
        
    }
    
    //MARK: - FEEDLIST Urlrequest
    func getFeedlist(user_id:String,viewcontroller_class:UIViewController,tag:String){
        
        let parameters = ["userid": user_id] as [String : Any]
        
        //create the url with URL
        let url = URL(string: Constant.BASE_URL + Constant.FEEDLIST_URL)! //change the url
        
        //create the session object
        let session = URLSession.shared
        
        //now create the URLRequest object using the url object
        var request = URLRequest(url: url)
        request.httpMethod = "POST" //set http method as POST
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted) // pass dictionary to nsdata object and set it as request body
        } catch let error {
            print(error.localizedDescription)
            self.urlrequestDelegate?.urlrequestfinish_with_error(error: error)
        }
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        //create dataTask using the session object to send data to the server
        let task = session.dataTask(with: request as URLRequest, completionHandler: { data, response, error in
            
            guard error == nil else {
                return
            }
            
            guard let data = data else {
                return
            }
            
            do {
                //create json object from data
                if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] {
                    //print(json)
                    self.urlrequestDelegate?.urlrequestfinish_with_success(data: json as NSDictionary, requestType: Constant.SINGIN_URL,request_class: viewcontroller_class,tag:tag)
                    // handle json...
                }
            } catch let error {
                print(error.localizedDescription)
                self.urlrequestDelegate?.urlrequestfinish_with_error(error: error)
            }
        })
        task.resume()
        
    }
    
    //MARK: - FEED CREATE Image and text Urlrequest
    func createFeed(user_id:String,user_name:String,feed_text:String,feed_img:String,feed_video:String,viewcontroller_class:UIViewController,tag:String){
        
        let parameters = [
            "feed_content":feed_text,
            "feed_publish_by":user_name,
            "feed_publish_by_email":user_id
            ] as [String : Any]
        //"feed_img":"",
        let boundary = generateBoundaryString()
        
        //create the url with URL
        let url = URL(string: Constant.BASE_URL + Constant.FEEDCREATE_URL)! //change the url
        
        //create the session object
        let session = URLSession.shared
        
        //now create the URLRequest object using the url object
        var request = URLRequest(url: url)
        request.httpMethod = "POST" //set http method as POST
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        //let compArr = feed_img.components(separatedBy: ".")
        let path1 = feed_img//Bundle.main.path(forResource: compArr.first, ofType: compArr.last)!
        
        do {
            
            request.httpBody = try createBody(with: (parameters as! [String : String])  ,filePathKey : "feed_img", paths: [path1], boundary: boundary)
        } catch let error {
            //print(error.localizedDescription)
            self.urlrequestDelegate?.urlrequestfinish_with_error(error: error)
        }
        
        
        
        //create dataTask using the session object to send data to the server
        let task = session.dataTask(with: request as URLRequest, completionHandler: { data, response, error in
            
            guard error == nil else {
                return
            }
            
            guard let data = data else {
                return
            }
            
            do {
                //create json object from data
                if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] {
                    //print(json)
                    self.urlrequestDelegate?.urlrequestfinish_with_success(data: json as NSDictionary, requestType: Constant.SINGIN_URL,request_class: viewcontroller_class,tag:tag)
                    // handle json...
                }
            } catch let error {
                print(error.localizedDescription)
                self.urlrequestDelegate?.urlrequestfinish_with_error(error: error)
            }
        })
        task.resume()
        
    }
    
    //MARK: - FEED CREATE Image Data and text Urlrequest
    func createFeed(user_id:String,user_name:String,feed_text:String,imageData:Data,viewcontroller_class:UIViewController,tag:String){
        
        let parameters = [
            "feed_content":feed_text,
            "feed_publish_by":user_name,
            "feed_publish_by_email":user_id
            ] as [String : Any]
        //"feed_img":"",
        let boundary = generateBoundaryString()
        
        //create the url with URL
        let url = URL(string: Constant.BASE_URL + Constant.FEEDCREATE_URL)! //change the url
        
        //create the session object
        let session = URLSession.shared
        
        //now create the URLRequest object using the url object
        var request = URLRequest(url: url)
        request.httpMethod = "POST" //set http method as POST
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        
        do {
            
            request.httpBody = try createBodyWithImageData(with: (parameters as! [String : String]), filePathKey: "feed_img", imageData: imageData, boundary: boundary)
            
        } catch let error {
            //print(error.localizedDescription)
            self.urlrequestDelegate?.urlrequestfinish_with_error(error: error)
        }
        
        
        
        //create dataTask using the session object to send data to the server
        let task = session.dataTask(with: request as URLRequest, completionHandler: { data, response, error in
            
            guard error == nil else {
                return
            }
            
            guard let data = data else {
                return
            }
            
            do {
                //create json object from data
                if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] {
                    //print(json)
                    self.urlrequestDelegate?.urlrequestfinish_with_success(data: json as NSDictionary, requestType: Constant.SINGIN_URL,request_class: viewcontroller_class,tag:tag)
                    // handle json...
                }
            } catch let error {
                print(error.localizedDescription)
                self.urlrequestDelegate?.urlrequestfinish_with_error(error: error)
            }
        })
        task.resume()
        
    }
    
    //MARK: - FEED CREATE Video Data and text Urlrequest
    func createFeed(user_id:String,user_name:String,feed_text:String,vidData:Data,viewcontroller_class:UIViewController,tag:String){
        
        let parameters = [
            "feed_content":feed_text,
            "feed_publish_by":user_name,
            "feed_publish_by_email":user_id
            ] as [String : Any]
        //"feed_img":"",
        let boundary = generateBoundaryString()
        
        //create the url with URL
        let url = URL(string: Constant.BASE_URL + Constant.FEEDCREATE_URL)! //change the url
        
        //create the session object
        let session = URLSession.shared
        
        //now create the URLRequest object using the url object
        var request = URLRequest(url: url)
        request.httpMethod = "POST" //set http method as POST
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        
        do {
            
            request.httpBody = try createBodyWithImageData(with: (parameters as! [String : String]), filePathKey: "feed_vdo", imageData: vidData, boundary: boundary)
            
        } catch let error {
            //print(error.localizedDescription)
            self.urlrequestDelegate?.urlrequestfinish_with_error(error: error)
        }
        
        
        
        //create dataTask using the session object to send data to the server
        let task = session.dataTask(with: request as URLRequest, completionHandler: { data, response, error in
            
            guard error == nil else {
                return
            }
            
            guard let data = data else {
                return
            }
            
            do {
                //create json object from data
                if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] {
                    //print(json)
                    self.urlrequestDelegate?.urlrequestfinish_with_success(data: json as NSDictionary, requestType: Constant.SINGIN_URL,request_class: viewcontroller_class,tag:tag)
                    // handle json...
                }
            } catch let error {
                print(error.localizedDescription)
                self.urlrequestDelegate?.urlrequestfinish_with_error(error: error)
            }
        })
        task.resume()
        
    }
    
    //MARK: - FEED CREATE Only text Urlrequest
    func createTxtFeed(user_id:String,user_name:String,feed_text:String,viewcontroller_class:UIViewController,tag:String){
        
        let parameters = [
            "feed_content":feed_text,
            "feed_publish_by":user_name,
            "feed_publish_by_email":user_id
            ] as [String : Any]
        
        
        //create the url with URL
        let url = URL(string: Constant.BASE_URL + Constant.FEEDCREATE_URL)! //change the url
        
        //create the session object
        let session = URLSession.shared
        
        //now create the URLRequest object using the url object
        var request = URLRequest(url: url)
        request.httpMethod = "POST" //set http method as POST
        
        
        
        do {
            
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted) // pass dictionary to nsdata object and set it as request body
        } catch let error {
            //print(error.localizedDescription)
            self.urlrequestDelegate?.urlrequestfinish_with_error(error: error)
        }
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        //create dataTask using the session object to send data to the server
        let task = session.dataTask(with: request as URLRequest, completionHandler: { data, response, error in
            
            guard error == nil else {
                return
            }
            
            guard let data = data else {
                return
            }
            
            do {
                //create json object from data
                if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] {
                    //print(json)
                    self.urlrequestDelegate?.urlrequestfinish_with_success(data: json as NSDictionary, requestType: Constant.FEEDCREATE_URL,request_class: viewcontroller_class,tag:tag)
                    // handle json...
                }
            } catch let error {
                print(error.localizedDescription)
                self.urlrequestDelegate?.urlrequestfinish_with_error(error: error)
            }
        })
        task.resume()
        
    }
    
    //MARK: - FEED LIKE Urlrequest
    func setLike_Dislike(feed_id:String,user_id:String,like_stat:String,viewcontroller_class:UIViewController,tag:String){
        
        let parameters = ["feed_id": feed_id,"user_id": user_id,"likestat":like_stat] as [String : Any]
        
        //create the url with URL
        let url = URL(string: Constant.BASE_URL + Constant.FEED_LIKE_URL)! //change the url
        
        //create the session object
        let session = URLSession.shared
        
        //now create the URLRequest object using the url object
        var request = URLRequest(url: url)
        request.httpMethod = "POST" //set http method as POST
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted) // pass dictionary to nsdata object and set it as request body
        } catch let error {
            print(error.localizedDescription)
            self.urlrequestDelegate?.urlrequestfinish_with_error(error: error)
        }
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        //create dataTask using the session object to send data to the server
        let task = session.dataTask(with: request as URLRequest, completionHandler: { data, response, error in
            
            guard error == nil else {
                return
            }
            
            guard let data = data else {
                return
            }
            
            do {
                //create json object from data
                if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] {
                    //print(json)
                    self.urlrequestDelegate?.urlrequestfinish_with_success(data: json as NSDictionary, requestType: Constant.FEED_LIKE_URL,request_class: viewcontroller_class,tag:tag)
                    // handle json...
                }
            } catch let error {
                print(error.localizedDescription)
                self.urlrequestDelegate?.urlrequestfinish_with_error(error: error)
            }
        })
        task.resume()
        
    }
    
    //MARK: - FEED Comment list Urlrequest
    func getCommentList(feed_id:String,viewcontroller_class:UIViewController,tag:String){
        
        let parameters = ["feed_id": feed_id] as [String : Any]
        
        //create the url with URL
        let url = URL(string: Constant.BASE_URL + Constant.FEED_COMMENT_LIST_URL)! //change the url
        
        //create the session object
        let session = URLSession.shared
        
        //now create the URLRequest object using the url object
        var request = URLRequest(url: url)
        request.httpMethod = "POST" //set http method as POST
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted) // pass dictionary to nsdata object and set it as request body
        } catch let error {
            print(error.localizedDescription)
            self.urlrequestDelegate?.urlrequestfinish_with_error(error: error)
        }
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        //create dataTask using the session object to send data to the server
        let task = session.dataTask(with: request as URLRequest, completionHandler: { data, response, error in
            
            guard error == nil else {
                return
            }
            
            guard let data = data else {
                return
            }
            
            do {
                //create json object from data
                if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] {
                    //print(json)
                    self.urlrequestDelegate?.urlrequestfinish_with_success(data: json as NSDictionary, requestType: Constant.FEED_COMMENT_LIST_URL,request_class: viewcontroller_class,tag:tag)
                    // handle json...
                }
            } catch let error {
                print(error.localizedDescription)
                self.urlrequestDelegate?.urlrequestfinish_with_error(error: error)
            }
        })
        task.resume()
        
    }
    
    //MARK: - FEED Comment post Urlrequest
    func postFeedComment(feed_id:String,comment_txt:String,comment_by_name:String,viewcontroller_class:UIViewController,tag:String){
        
        let parameters = ["feed_id": feed_id,
                          "feed_comment_content":comment_txt,
                          "feed_comment_by":comment_by_name
            ] as [String : Any]
        
        //create the url with URL
        let url = URL(string: Constant.BASE_URL + Constant.FEED_POST_COMMENT_URL)! //change the url
        
        //create the session object
        let session = URLSession.shared
        
        //now create the URLRequest object using the url object
        var request = URLRequest(url: url)
        request.httpMethod = "POST" //set http method as POST
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted) // pass dictionary to nsdata object and set it as request body
        } catch let error {
            print(error.localizedDescription)
            self.urlrequestDelegate?.urlrequestfinish_with_error(error: error)
        }
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        //create dataTask using the session object to send data to the server
        let task = session.dataTask(with: request as URLRequest, completionHandler: { data, response, error in
            
            guard error == nil else {
                return
            }
            
            guard let data = data else {
                return
            }
            
            do {
                //create json object from data
                if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] {
                    //print(json)
                    self.urlrequestDelegate?.urlrequestfinish_with_success(data: json as NSDictionary, requestType: Constant.FEED_POST_COMMENT_URL,request_class: viewcontroller_class,tag:tag)
                    // handle json...
                }
            } catch let error {
                print(error.localizedDescription)
                self.urlrequestDelegate?.urlrequestfinish_with_error(error: error)
            }
        })
        task.resume()
        
    }
    
    //MARK: - Member List Urlrequest
    func getMemberList(user_id:String,viewcontroller_class:UIViewController,tag:String){
        
        let parameters = ["userid": user_id] as [String : Any]
        
        //create the url with URL
        let url = URL(string: Constant.BASE_URL + Constant.MEMBER_LIST_URL)! //change the url
        
        //create the session object
        let session = URLSession.shared
        
        //now create the URLRequest object using the url object
        var request = URLRequest(url: url)
        request.httpMethod = "POST" //set http method as POST
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted) // pass dictionary to nsdata object and set it as request body
        } catch let error {
            print(error.localizedDescription)
            self.urlrequestDelegate?.urlrequestfinish_with_error(error: error)
        }
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        //create dataTask using the session object to send data to the server
        let task = session.dataTask(with: request as URLRequest, completionHandler: { data, response, error in
            
            guard error == nil else {
                return
            }
            
            guard let data = data else {
                return
            }
            
            do {
                //create json object from data
                if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] {
                    //print(json)
                    self.urlrequestDelegate?.urlrequestfinish_with_success(data: json as NSDictionary, requestType: Constant.MEMBER_LIST_URL,request_class: viewcontroller_class,tag:tag)
                    // handle json...
                }
            } catch let error {
                print(error.localizedDescription)
                self.urlrequestDelegate?.urlrequestfinish_with_error(error: error)
            }
        })
        task.resume()
        
    }
    
    //MARK: - Invitation List Urlrequest
    func getInvitationList(user_id:String,viewcontroller_class:UIViewController,tag:String){
        
        let parameters = ["userid": user_id] as [String : Any]
        
        //create the url with URL
        let url = URL(string: Constant.BASE_URL + Constant.INVITATION_LIST_URL)! //change the url
        
        //create the session object
        let session = URLSession.shared
        
        //now create the URLRequest object using the url object
        var request = URLRequest(url: url)
        request.httpMethod = "POST" //set http method as POST
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted) // pass dictionary to nsdata object and set it as request body
        } catch let error {
            print(error.localizedDescription)
            self.urlrequestDelegate?.urlrequestfinish_with_error(error: error)
        }
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        //create dataTask using the session object to send data to the server
        let task = session.dataTask(with: request as URLRequest, completionHandler: { data, response, error in
            
            guard error == nil else {
                return
            }
            
            guard let data = data else {
                return
            }
            
            do {
                //create json object from data
                if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] {
                    //print(json)
                    self.urlrequestDelegate?.urlrequestfinish_with_success(data: json as NSDictionary, requestType: Constant.INVITATION_LIST_URL,request_class: viewcontroller_class,tag:tag)
                    // handle json...
                }
            } catch let error {
                print(error.localizedDescription)
                self.urlrequestDelegate?.urlrequestfinish_with_error(error: error)
            }
        })
        task.resume()
        
    }
    
    //MARK: - Friend List Urlrequest
    func getFriendList(user_id:String,viewcontroller_class:UIViewController,tag:String){
        
        let parameters = ["userid": user_id] as [String : Any]
        
        //create the url with URL
        let url = URL(string: Constant.BASE_URL + Constant.FRIEND_LIST_URL)! //change the url
        
        //create the session object
        let session = URLSession.shared
        
        //now create the URLRequest object using the url object
        var request = URLRequest(url: url)
        request.httpMethod = "POST" //set http method as POST
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted) // pass dictionary to nsdata object and set it as request body
        } catch let error {
            print(error.localizedDescription)
            self.urlrequestDelegate?.urlrequestfinish_with_error(error: error)
        }
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        //create dataTask using the session object to send data to the server
        let task = session.dataTask(with: request as URLRequest, completionHandler: { data, response, error in
            
            guard error == nil else {
                return
            }
            
            guard let data = data else {
                return
            }
            
            do {
                //create json object from data
                if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] {
                    //print(json)
                    self.urlrequestDelegate?.urlrequestfinish_with_success(data: json as NSDictionary, requestType: Constant.FRIEND_LIST_URL,request_class: viewcontroller_class,tag:tag)
                    // handle json...
                }
            } catch let error {
                print(error.localizedDescription)
                self.urlrequestDelegate?.urlrequestfinish_with_error(error: error)
            }
        })
        task.resume()
        
    }
    
    //MARK: -
    
    
    
    
    
    
    
    
    
    
    
    /// Create body of the `multipart/form-data` request
    ///
    /// - parameter parameters:   The optional dictionary containing keys and values to be passed to web service
    /// - parameter filePathKey:  The optional field name to be used when uploading files. If you supply paths, you must supply filePathKey, too.
    /// - parameter paths:        The optional array of file paths of the files to be uploaded
    /// - parameter boundary:     The `multipart/form-data` boundary
    ///
    /// - returns:                The `Data` of the body of the request
    
    private func createBody(with parameters: [String: String]?, filePathKey: String, paths: [String], boundary: String) throws -> Data
    {
        var body = Data()
        
        
        if parameters != nil {
            for (key, value) in parameters! {
                body.append("--\(boundary)\r\n".data(using: String.Encoding.utf8)!)
                body.append("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n".data(using: String.Encoding.utf8)!)
                body.append("\(value)\r\n".data(using: String.Encoding.utf8)!)
            }
        }
        
        for path in paths {
            let url = URL(fileURLWithPath: path)
            let filename = url.lastPathComponent
            let data = try Data(contentsOf: url)
            let mimetype = mimeType(for: path)
            
            body.append("--\(boundary)\r\n")
            body.append("Content-Disposition: form-data; name=\"\(filePathKey)\"; filename=\"\(filename)\"\r\n")
            body.append("Content-Type: \(mimetype)\r\n\r\n")
            body.append(data)
            body.append("\r\n")
        }
        
        body.append("--\(boundary)--\r\n")
        return body
    }
    
    private func createBodyWithImageData(with parameters: [String: String]?, filePathKey: String, imageData: Data, boundary: String) throws -> Data
    {
        var body = Data()
        
        
        if parameters != nil {
            for (key, value) in parameters! {
                body.append("--\(boundary)\r\n".data(using: String.Encoding.utf8)!)
                body.append("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n".data(using: String.Encoding.utf8)!)
                body.append("\(value)\r\n".data(using: String.Encoding.utf8)!)
            }
        }
        
//        let filename = "user-profile.jpg"
//
//        let mimetype = "image/jpg"
        
        let filename = "upload.mov"
        let mimetype = "video/mov"
        
        body.append("--\(boundary)\r\n")
        body.append("Content-Disposition: form-data; name=\"\(filePathKey)\"; filename=\"\(filename)\"\r\n")
        body.append("Content-Type: \(mimetype)\r\n\r\n")
        body.append(imageData)
        body.append("\r\n")
        
        
        body.append("--\(boundary)--\r\n")
        return body
    }
    
    /// Create boundary string for multipart/form-data request
    ///
    /// - returns:            The boundary string that consists of "Boundary-" followed by a UUID string.
    
    private func generateBoundaryString() -> String {
        return "Boundary-\(UUID().uuidString)"
    }
    
    /// Determine mime type on the basis of extension of a file.
    ///
    /// This requires `import MobileCoreServices`.
    ///
    /// - parameter path:         The path of the file for which we are going to determine the mime type.
    ///
    /// - returns:                Returns the mime type if successful. Returns `application/octet-stream` if unable to determine mime type.
    
    private func mimeType(for path: String) -> String {
        let url = URL(fileURLWithPath: path)
        let pathExtension = url.pathExtension
        
        if let uti = UTTypeCreatePreferredIdentifierForTag(kUTTagClassFilenameExtension, pathExtension as NSString, nil)?.takeRetainedValue() {
            if let mimetype = UTTypeCopyPreferredTagWithClass(uti, kUTTagClassMIMEType)?.takeRetainedValue() {
                return mimetype as String
            }
        }
        return "application/octet-stream"
    }

}

extension Data {
    
    /// Append string to Data
    ///
    /// Rather than littering my code with calls to `data(using: .utf8)` to convert `String` values to `Data`, this wraps it in a nice convenient little extension to Data. This defaults to converting using UTF-8.
    ///
    /// - parameter string:       The string to be added to the `Data`.
    
    mutating func append(_ string: String, using encoding: String.Encoding = .utf8) {
        if let data = string.data(using: encoding) {
            append(data)
        }
    }
}
