//
//  RightViewController.swift
//  FriendsGo
//
//  Created by Radhia Mighri on 03/03/2018.
//  Copyright © 2018 Radhia Mighri. All rights reserved.
//

import UIKit

class RightViewController : UIViewController {
  
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func Exit(_ sender: Any) {
        let mystoryboard:UIStoryboard = UIStoryboard(name:"Main", bundle: nil)
        let secondViewController = mystoryboard.instantiateViewController(withIdentifier: "LoginController") as! ViewController
        self.navigationController?.pushViewController(secondViewController, animated: true)
        
        
    }
}

