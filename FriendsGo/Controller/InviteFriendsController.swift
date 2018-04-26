//
//  InviteFriendsController.swift
//  FriendsGo
//
//  Created by Radhia Mighri on 17/04/2018.
//  Copyright © 2018 Radhia Mighri. All rights reserved.
//

import UIKit

class InviteFriendsController: UIViewController {
    var event: Event!
    
    var tabs = [
        ViewPagerTab(title: "Participants"),
        ViewPagerTab(title: "Intéressés"),
        ViewPagerTab(title: "Non participants")
    ]
    
    var viewPager:ViewPagerControllerB!
    var options:ViewPagerOptionsB!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.edgesForExtendedLayout = UIRectEdge.init(rawValue: 0)
        
         options = ViewPagerOptionsB(viewPagerWithFrame: self.view.bounds)
        
        // add friend
        
        //options = ViewPagerOptionsB(viewPagerWithFrame: CGRect(x: 0, y: 100, width: 320, height: 468))
        
        options.tabType = ViewPagerTabType.basic
        //options.tabViewImageSize = CGSize(width: 20, height: 20)
        options.tabViewTextFont = UIFont.systemFont(ofSize: 16)
        //options.tabViewPaddingLeft = 20
        //options.tabViewPaddingRight = 20
        options.isTabHighlightAvailable = true
        
        viewPager = ViewPagerControllerB()
        viewPager.options = options
        viewPager.dataSource = self
        viewPager.delegate = self
        
        self.addChildViewController(viewPager)
        self.view.addSubview(viewPager.view)
        viewPager.didMove(toParentViewController: self)
        
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        //options.viewPagerFrame = self.view.bounds
    }
}


extension InviteFriendsController: ViewPagerControllerDataSourceB {
    
    func numberOfPages() -> Int {
        return tabs.count
    }
    
    func viewControllerAtPosition(position:Int) -> UIViewController {
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ParticipantsController") as! ParticipantsController
        
        let vc1 = self.storyboard?.instantiateViewController(withIdentifier: "InterestedFriendsController") as! InterestedFriendsController
        
        let vc2 = self.storyboard?.instantiateViewController(withIdentifier: "NonParticipantsController") as! NonParticipantsController
        
        if (position == 0)
        {
         vc.event = event
            return vc
        }
        else if (position == 1)
        {
            vc1.event = event
            return vc1
        }
        else{
            vc2.event = event
            return vc2
            
        }
        
    }
    
    func tabsForPages() -> [ViewPagerTab] {
        return tabs
    }
    
    func startViewPagerAtIndex() -> Int {
        return 0
    }
}

extension InviteFriendsController: ViewPagerControllerDelegateB {
    
    func willMoveToControllerAtIndex(index:Int) {
        print("Moving to page \(index)")
    }
    
    func didMoveToControllerAtIndex(index: Int) {
        print("Moved to page \(index)")
    }
}

