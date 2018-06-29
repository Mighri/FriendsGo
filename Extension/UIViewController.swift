//
//  UIViewController.swift
//  FriendsGo
//
//  Created by Radhia Mighri on 03/03/2018.
//  Copyright © 2018 Radhia Mighri. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func setNavigationBarItem() {
        self.addLeftBarButtonWithImage(UIImage(named: "ic_menu_black_24dp")!)
        self.addRightBarButtonWithImage(UIImage(named: "dot")!)
        self.slideMenuController()?.removeLeftGestures()
       // self.slideMenuController()?.removeRightGestures()
        self.slideMenuController()?.addLeftGestures()
        //self.slideMenuController()?.addRightGestures()
        
    }
    
    
    public func addRightBarButtonWithImage(_ buttonImage: UIImage) {
        
      navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named:"dot"), style: .plain, target: self, action: #selector(tapRight))
        
    }
 
    @objc public func tapRight() {
        
   print("*********************************************")
        
        let mystoryboard:UIStoryboard = UIStoryboard(name:"Main", bundle: nil)
     
        let secondViewController = mystoryboard.instantiateViewController(withIdentifier: "LoginController") as! LogViewController
        self.navigationController?.pushViewController(secondViewController, animated: true)
        
    }
 
    func removeNavigationBarItem() {
        self.navigationItem.leftBarButtonItem = nil
        self.navigationItem.rightBarButtonItem = nil
        self.slideMenuController()?.removeLeftGestures()
        //self.slideMenuController()?.removeRightGestures()
    }
}

