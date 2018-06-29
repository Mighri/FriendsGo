//
//  CustomNavigationController.swift
//  Google Contacts Viewer
//
//  Created by Kalyan Vishnubhatla on 12/19/16.
//
//

import Foundation

class CustomNavigationController: UINavigationController {
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        let nav = self.navigationBar
        nav.barStyle = UIBarStyle.black
        nav.barTintColor = UIColor.brown
        nav.tintColor = UIColor.white
        //nav.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
    }
}
