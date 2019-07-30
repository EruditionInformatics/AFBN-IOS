//
//  ViewController.swift
//  AFBN
//
//  Created by Erudition Informatics on 23/04/19.
//  Copyright © 2019 Erudition Informatics. All rights reserved.
//

import UIKit




class FirstSplashController: UIViewController,UIScrollViewDelegate,splashControllerProtocol {
    
    @IBOutlet weak var ScrollView: UIScrollView!
    @IBOutlet weak var PageControl: UIPageControl!
    
    
    
    var Slide:SlideView!
    
    var slides:[SlideView] = []
    
    //MARK: View Cycle Method
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        ScrollView.delegate = self
        if Reachability.isConnectedToNetwork(){
            print("Internet Connection Available!")
        }else{
            print("Internet Connection not Available!")
        }
        if(UserDefaults.standard.bool(forKey: "user_login") == false){
            setUIDesign()
        }else{
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let tabbarController = storyBoard.instantiateViewController(withIdentifier: "TabBarViewController") as! TabBarViewController
            //self.present(singInController, animated: true, completion: nil)
            self.navigationController?.pushViewController(tabbarController, animated: false)
        }
        
        //CommonClass.commonSharedInstance.showSpinner(onView: self.view)
        //self.removeSpinner()
        
    }
    
    //MARK: Add Pagination Design to UI
    func setUIDesign(){
        
        slides = createSlides()
        setupSlideScrollView(slides: slides)
        
        PageControl.numberOfPages = slides.count
        PageControl.currentPage = 0
        view.bringSubviewToFront(PageControl)
        
    }

    func createSlides() -> [SlideView] {
        
        let slide1:SlideView = Bundle.main.loadNibNamed("SlideView", owner: self, options: nil)?.first as! SlideView
        slide1.imgView.image = UIImage(named: "splash_1.1")
        slide1.titleLbl.text = "Welcome to Cargo Network"
        slide1.descLbl.text = ""
        slide1.descLbl1.text = "It is easy now to find your partners and get their contacts around the world"
        slide1.memberBtn.isHidden = true
        slide1.signInBtn.isHidden = true
        
        let slide2:SlideView = Bundle.main.loadNibNamed("SlideView", owner: self, options: nil)?.first as! SlideView
        slide2.imgView.image = UIImage(named: "splash_2.2")
        slide2.titleLbl.text = "Search and find partners"
        slide2.descLbl.text = ""
        slide2.descLbl1.text = "It is easy now to find your partners and get their contacts around the world"
        slide2.memberBtn.isHidden = true
        slide2.signInBtn.isHidden = true
        
        let slide3:SlideView = Bundle.main.loadNibNamed("SlideView", owner: self, options: nil)?.first as! SlideView
        slide3.imgView.image = UIImage(named: "splash_3.3")
        slide3.titleLbl.text = "Invite and Chat with Members"
        slide3.descLbl.text = ""
        slide3.descLbl1.text = "It is easy now to find your partners and get their contacts around the world"
        slide3.memberBtn.isHidden = true
        slide3.signInBtn.isHidden = true
        
        let slide4:SlideView = Bundle.main.loadNibNamed("SlideView", owner: self, options: nil)?.first as! SlideView
        slide4.imgView.image = UIImage(named: "splash_4.4")
        slide4.titleLbl.text = "Benefits of AFBN Network"
        slide4.descLbl1.text = ""
        slide4.descLbl.text = "1. Introduce you to the best, reliable freight forwarders in Africa. \n2. We are negotiating contracts and agreements with big organization to have priority to lead business in Africa. \n3. Premium founder and building member benefits. \n4. AFBN Networks will secure and protect your money. \n5. Insuring internal sales leads with our internal system. \n6. Sharing opportunities among members in each country. \n7. Follow up of business flow between members and push members to increase opportunities. \n8. Our network is exclusive to 3 members in each country, unless in well-developed area such as Shanghai, New York, etc."
        slide4.memberBtn.isHidden = false
        slide4.signInBtn.isHidden = false
        slide4.splashDelegate = self
        slide4.mainBackScroll.contentInset = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 50.0, right: 0.0)
        
        
        return [slide1, slide2, slide3, slide4]
    }
    
    func setupSlideScrollView(slides : [SlideView]) {
        ScrollView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        ScrollView.contentSize = CGSize(width: view.frame.width * CGFloat(slides.count), height: 0.0)//view.frame.height
        ScrollView.isPagingEnabled = true
        
        
        for i in 0 ..< slides.count {
            slides[i].frame = CGRect(x: view.frame.width * CGFloat(i), y: 0, width: view.frame.width, height: view.frame.height)
            
            ScrollView.addSubview(slides[i])
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let pageIndex = round(ScrollView.contentOffset.x/view.frame.width)
        PageControl.currentPage = Int(pageIndex)
        
    }
    
    //MARK: Custom Protocol Method//
    func moveTo_memberController(){
        print("moveTo_memberController")
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let termsController = storyBoard.instantiateViewController(withIdentifier: "TermsViewController") as! TermsViewController
        //self.present(singInController, animated: true, completion: nil)
        self.navigationController?.pushViewController(termsController, animated: false)
        
    }
    func moveTo_singInController(){
        print("moveTo_singInController")
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let singInController = storyBoard.instantiateViewController(withIdentifier: "SingInViewController") as! SingInViewController
        //self.present(singInController, animated: true, completion: nil)
        self.navigationController?.pushViewController(singInController, animated: false)
        
        
        
        /*let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let tabbarController = storyBoard.instantiateViewController(withIdentifier: "TabBarViewController") as! TabBarViewController
        //self.present(singInController, animated: true, completion: nil)
        self.navigationController?.pushViewController(tabbarController, animated: true)*/
    }
    
    
    

}

