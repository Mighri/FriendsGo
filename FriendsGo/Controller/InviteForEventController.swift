//
//  InviteForEventController.swift
//  FriendsGo
//
//  Created by Radhia Mighri on 24/04/2018.
//  Copyright © 2018 Radhia Mighri. All rights reserved.
//

import UIKit

class InviteForEventController: UIViewController, UINavigationControllerDelegate {
    
    var tabs = [
        ViewPagerTab(title: "     Contacts    "),
        ViewPagerTab(title: "     Amis        ")
    ]
    
    @IBOutlet var imageEvent: UIImageView!
    @IBOutlet var titreEvent: UILabel!
    @IBOutlet var adresseEvent: UILabel!
    
    var viewPager:ViewPagerControllerB!
    var options:ViewPagerOptionsB!
    
    var event: Event!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.edgesForExtendedLayout = UIRectEdge.init(rawValue: 0)
        
        titreEvent.text = event.titre
        adresseEvent.text = event.adresse
        //let imagedecoded = Data(base64Encoded: event.image, options: Data.Base64DecodingOptions.ignoreUnknownCharacters)!
        //imageEvent.image = UIImage(data: imagedecoded)!
          imageEvent.sd_setImage(with: URL(string: event.image), placeholderImage: nil)
        //options = ViewPagerOptionsB(viewPagerWithFrame: self.view.bounds)
        
        options = ViewPagerOptionsB(viewPagerWithFrame: CGRect(x: 0, y: 150, width: 320, height: 600))
        
        options.tabType = ViewPagerTabType.basic
        options.tabViewTextFont = UIFont.systemFont(ofSize: 16)
        options.tabViewPaddingLeft = 20
        options.tabViewPaddingRight = 20
        options.isTabHighlightAvailable = true
        
        
        viewPager = ViewPagerControllerB()
        viewPager.options = options
        viewPager.dataSource = self
        viewPager.delegate = self
        
        self.addChildViewController(viewPager)
        self.view.addSubview(viewPager.view)
        viewPager.didMove(toParentViewController: self)
        
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Hide the navigation bar on the this view controller
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Show the navigation bar on other view controllers
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    
    
    @IBAction func back(_ sender: UIButton) {

        let mystoryboard:UIStoryboard = UIStoryboard(name:"Menu", bundle: nil)
        
        let ViewController = mystoryboard.instantiateViewController(withIdentifier: "EventViewController") as! EventViewController
        
        //ViewController.event = event
        
      self.navigationController?.pushViewController(ViewController, animated: true)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        //options.viewPagerFrame = self.view.bounds
    }
}


extension InviteForEventController: ViewPagerControllerDataSourceB {
    
    func numberOfPages() -> Int {
        return tabs.count
    }
    
    func viewControllerAtPosition(position:Int) -> UIViewController {
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "InviteContactController") as! InviteContactController
        
        let vc1 = self.storyboard?.instantiateViewController(withIdentifier: "SVC") as! InviteAmisEventController
        
        if (position == 0)
        {
            return vc
        }
        else
        {
            vc1.event = event
            return vc1
        }
    }
    
    func tabsForPages() -> [ViewPagerTab] {
        return tabs
    }
    
    func startViewPagerAtIndex() -> Int {
        return 0
    }
}

extension InviteForEventController: ViewPagerControllerDelegateB {
    
    func willMoveToControllerAtIndex(index:Int) {
        print("Moving to page \(index)")
    }
    
    func didMoveToControllerAtIndex(index: Int) {
        print("Moved to page \(index)")
    }
}



