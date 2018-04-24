//
//  MapViewController.swift
//  FriendsGo
//
//  Created by Radhia Mighri on 03/03/2018.
//  Copyright © 2018 Radhia Mighri. All rights reserved.
//

import UIKit

class MapViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setNavigationBarItem()
        self.title = "Map"
    }
}

