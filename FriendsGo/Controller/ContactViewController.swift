//
//  ContactViewController.swift
//  FriendsGo
//
//  Created by Radhia Mighri on 03/03/2018.
//  Copyright © 2018 Radhia Mighri. All rights reserved.
//

import UIKit

class ContactViewController: UIViewController {

    var tabs = [
        ViewPagerTab(title: "  Contacts"),
        ViewPagerTab(title: "  Amis"),
        ViewPagerTab(title: "  Rechercher")
    ]
    
    var viewPager:ViewPagerController!
    var options:ViewPagerOptions!
    
    override func viewDidLoad() {
        super.viewDidLoad()
         self.setNavigationBarItem()
        self.edgesForExtendedLayout = UIRectEdge.init(rawValue: 0)
        
        self.title = "Contacts"
        
        options = ViewPagerOptions(viewPagerWithFrame: self.view.bounds)
        options.tabType = ViewPagerTabType.basic
        options.tabViewImageSize = CGSize(width: 20, height: 20)
        options.tabViewTextFont = UIFont.systemFont(ofSize: 16)
        options.tabViewPaddingLeft = 20
        options.tabViewPaddingRight = 20
        options.isTabHighlightAvailable = true
        
        viewPager = ViewPagerController()
        viewPager.options = options
        viewPager.dataSource = self
        viewPager.delegate = self
        
        self.addChildViewController(viewPager)
        self.view.addSubview(viewPager.view)
        viewPager.didMove(toParentViewController: self)
        
        
        
        
        
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        options.viewPagerFrame = self.view.bounds
    }
}


extension ContactViewController: ViewPagerControllerDataSource {
    
    func numberOfPages() -> Int {
        return tabs.count
    }
    
    func viewControllerAtPosition(position:Int) -> UIViewController {
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ListContactsViewController") as! ListContactsViewController
        
            let vc1 = self.storyboard?.instantiateViewController(withIdentifier: "AmisController") as! AmisViewController
        
        let vc2 = self.storyboard?.instantiateViewController(withIdentifier: "SearchViewController") as! SearchViewController
       /*
        vc2.FriendArray = FriendArray
        self.navigationController?.pushViewController(vc2, animated: true)
        */
        if (position == 0)
        {
            
            // vc.itemText = "\(tabs[position].title!)"
            return vc
        }
        else if (position == 1)
        {
            //   vc.itemText = "\(tabs[position].title!)"
            return vc1
        }
        else{
            // vc.itemText = "\(tabs[position].title!)"
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

extension ContactViewController: ViewPagerControllerDelegate {
    
    func willMoveToControllerAtIndex(index:Int) {
        print("Moving to page \(index)")
    }
    
    func didMoveToControllerAtIndex(index: Int) {
        print("Moved to page \(index)")
    }
}
