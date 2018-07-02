//
//  InvitationEventPopUp.swift
//  FriendsGo
//
//  Created by Radhia Mighri on 17/04/2018.
//  Copyright © 2018 Radhia Mighri. All rights reserved.
//

import Foundation
import UIKit

class InvitationEventPopUp: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        
        self.showAnimate()
        
    }
    
    @IBAction func amis(_ sender: UIButton) {
        
        let popOverVC = UIStoryboard(name: "Menu", bundle: nil).instantiateViewController(withIdentifier: "SVC") as! InviteAmisEventController
        self.addChildViewController(popOverVC)
        popOverVC.view.frame = self.view.frame
        self.view.addSubview(popOverVC.view)
          popOverVC.didMove(toParentViewController: self)
        //popOverVC.show(vc: self.navigationController!)
 
        /*
        let mystoryboard:UIStoryboard = UIStoryboard(name:"Menu", bundle: nil)
        
        let ViewController = mystoryboard.instantiateViewController(withIdentifier: "SVC") as! SVC
        self.navigationController?.pushViewController(ViewController, animated: true)
 */
    }
    
    @IBAction func contacts(_ sender: UIButton) {
        
        let popOverVC = UIStoryboard(name: "MWAPopup", bundle: nil).instantiateViewController(withIdentifier: "ConfDeleteEventPopUp") as! ConfDeleteEventPopUp
        self.addChildViewController(popOverVC)
        //popOverVC.view.frame = self.view.frame
        self.view.addSubview(popOverVC.view)
         popOverVC.didMove(toParentViewController: self)
       // popOverVC.show(vc: self.navigationController!)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        //view.endEditing(true)
        self.removeAnimate()
        //self.view.removeFromSuperview()
    }
    
    func showAnimate()
    {
        self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        self.view.alpha = 0.0;
        UIView.animate(withDuration: 0.25, animations: {
            self.view.alpha = 1.0
            self.view.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        });
    }
    
    func removeAnimate()
    {
        UIView.animate(withDuration: 0.25, animations: {
            self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
            self.view.alpha = 0.0;
        }, completion:{(finished : Bool)  in
            if (finished)
            {
                self.view.removeFromSuperview()
            }
        });
    }
    
    func show(vc:UIViewController) {
        vc.addChildViewController(self)
        vc.view.addSubview(self.view)
    }
    
    func close() {
        self.view.removeFromSuperview()
        self.removeFromParentViewController()
    }
    
}


