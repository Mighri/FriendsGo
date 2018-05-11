//
//  WebviewViewController.swift
//  FriendsGo
//
//  Created by Radhia Mighri on 02/05/2018.
//  Copyright © 2018 Radhia Mighri. All rights reserved.
//

import UIKit
import WebKit

class WebviewViewController: UIViewController {
    @IBOutlet weak var webview: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let url = URL(string: "http://maps.google.com")
        let request = URLRequest(url: url!)
        
        webview.load(request)
        
    }
    override var prefersStatusBarHidden: Bool
        {
        return true
    }
    
    
    @IBAction func back(_ sender: UIButton) {
        
        print("%%%%%%%%%%%%%%%%%%%%")
        
        let mystoryboard:UIStoryboard = UIStoryboard(name:"Menu", bundle: nil)
        
        let ViewController = mystoryboard.instantiateViewController(withIdentifier: "EventViewController") as! EventViewController
        
        //ViewController.event = event
        
        self.navigationController?.pushViewController(ViewController, animated: true)
        
    }
    
}
