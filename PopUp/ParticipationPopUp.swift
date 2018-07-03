//
//  ParticipationPopUp.swift
//  FriendsGo
//
//  Created by Radhia Mighri on 18/04/2018.
//  Copyright © 2018 Radhia Mighri. All rights reserved.
//

import Foundation
import UIKit

class ParticipationPopUp: UIViewController, UINavigationControllerDelegate {
    
     let userId = UserDefaults.standard.string(forKey: "Saveid")!
    var event: Event!
    
    let urlUpdateInvEvent = MyClass.Constants.urlUpdateInvEvent
    let urlDeleteInvEvent = MyClass.Constants.urlDeleteInvEvent
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        
        self.showAnimate()
    }
    
    
    @IBAction func participeEventButton(_ sender: AnyObject) {
        
        let paras = ["IdInviteur": event.IdU ,
                     "IdInvite": userId,
                     "Etat" : "Participe",
                     "IdEvent": event.idE
            ] as [String : Any]
        
        
        Service.sharedInstance.postIt(parameters:paras as! [String : String], url:self.urlUpdateInvEvent)
        
       
        UserDefaults.standard.set("Je participe", forKey: "participe")
        
        //close()
        
        let mystoryboard:UIStoryboard = UIStoryboard(name:"Menu", bundle: nil)
        
        let ViewController = mystoryboard.instantiateViewController(withIdentifier: "EventViewController") as! EventViewController
        
        //ViewController.event = event
        
        self.navigationController?.pushViewController(ViewController, animated: true)
    }
    
    
    @IBAction func neParticipePasEventButton(_ sender: AnyObject) {
        
        let paras = ["IdInviteur": event.IdU ,
                     "IdInvite": userId,
                     "Etat" : "Ne participe pas",
                     "IdEvent": event.idE
            ] as [String : Any]
        
        
        Service.sharedInstance.postIt(parameters:paras as! [String : String], url:self.urlUpdateInvEvent)
        
         UserDefaults.standard.set("Je ne participe pas", forKey: "neParticipe")
  //close()
        
        let mystoryboard:UIStoryboard = UIStoryboard(name:"Menu", bundle: nil)
        
        let ViewController = mystoryboard.instantiateViewController(withIdentifier: "EventViewController") as! EventViewController
        
        //ViewController.event = event
        
        self.navigationController?.pushViewController(ViewController, animated: true)
    }
    
    @IBAction func interesseEventButton(_ sender: AnyObject) {
        
        let paras = ["IdInviteur": event.IdU ,
                     "IdInvite": userId,
                     "Etat" : "Intéressé",
                     "IdEvent": event.idE
            ] as [String : Any]
        
        
        Service.sharedInstance.postIt(parameters:paras as! [String : String], url:self.urlUpdateInvEvent)
        
        UserDefaults.standard.set("Je m'intéresse", forKey: "interesse")
      // close()
        
        let mystoryboard:UIStoryboard = UIStoryboard(name:"Menu", bundle: nil)
        
        let ViewController = mystoryboard.instantiateViewController(withIdentifier: "EventViewController") as! EventViewController
        
        //ViewController.event = event
        
        self.navigationController?.pushViewController(ViewController, animated: true)
        
        /*
        let mystoryboard:UIStoryboard = UIStoryboard(name:"Menu", bundle: nil)
        
        let ViewController = mystoryboard.instantiateViewController(withIdentifier: "AnInvitationEventController") as! AnInvitationEventController
        ViewController.event = event
        self.present(ViewController, animated: true, completion: nil)
 */
}
   /*
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Hide the navigation bar on the this view controller
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        // self.participationEvent.text = "ggg"
    }
    */
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // Show the navigation bar on other view controllers
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    @IBAction func supprimerEventButton(_ sender: AnyObject) {
        
        let paras = ["IdInviteur": event.IdU ,
                     "IdInvite": userId,
                     "Etat" : "intéressé",
                     "IdEvent": event.idE
            ] as [String : Any]
        
        Service.sharedInstance.postItAny(parameters:paras, url:self.urlDeleteInvEvent)
        //close()
        
        let mystoryboard:UIStoryboard = UIStoryboard(name:"Menu", bundle: nil)
        
        let ViewController = mystoryboard.instantiateViewController(withIdentifier: "EventViewController") as! EventViewController
        
        //ViewController.event = event
        
        self.navigationController?.pushViewController(ViewController, animated: true)
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
