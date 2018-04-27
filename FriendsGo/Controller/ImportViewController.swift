//
//  ImportViewController.swift
//  FriendsGo
//
//  Created by Radhia Mighri on 06/03/2018.
//  Copyright © 2018 Radhia Mighri. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import FBSDKCoreKit
import FBSDKShareKit

class ImportViewController: UIViewController{
      let userId = UserDefaults.standard.string(forKey: "Saveid")!
    var friend : Friend!
    var FriendArray = [Friend]()
   // var correspondance = Correspondance
    
    let urlRegisterContact = MyClass.Constants.urlRegisterContact
    let urlUserContact = MyClass.Constants.urlUserContact
    let urlImportContactsFBG = MyClass.Constants.urlImportContactsFBG
     let urlgetCorrespondance = MyClass.Constants.urlgetCorrespondance
    
    
    @IBOutlet weak var facebookButton : UIButton!
    @IBOutlet weak var googleButton : UIButton!
    let button = FBSDKLoginButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setNavigationBarItem()
        
        facebookButton.layer.cornerRadius = 20
        facebookButton.clipsToBounds = true
        facebookButton.backgroundColor = UIColor.white.withAlphaComponent(0.4)
        
        
        googleButton.layer.cornerRadius = 20
        googleButton.clipsToBounds = true
        googleButton.backgroundColor = UIColor.white.withAlphaComponent(0.4)
        
        self.title = "FriendsGo"
     
    }
    @IBAction func fbLogin(_ sender: Any) {
        
        /*
        let params = [
            "idU": self.userId,
            "idContact": self.friend.id]
        Service.sharedInstance.loadCorrespondance(parameters:params as! [String : String] , url:self.urlgetCorrespondance) { (state, Objets) in
            if state {
                
                //self.FriendArray = Objets!
                print("Objets")
            }
        else
        {
            print("nooo")
        }
    }
        */
        
        let p = ["inscrivia" : "Facebook"]
        
        Service.sharedInstance.loadInfoAny(parameters: p, url: urlImportContactsFBG) { (state, Objets) in
            if state {
                
                self.FriendArray = Objets!
                
                for i in 0...self.FriendArray.count-1 {
                self.friend = Objets![i]
                
                
                let params = [
                    "idU": self.userId,
                    "idContact": self.friend.id]
                
                Service.sharedInstance.postIt(parameters:params as! [String : String] , url:self.urlUserContact)
                
                
                let pr = ["Nom": self.friend.Nom,
                          "Prenom": self.friend.prenom,
                          "photoURL": self.friend.photoURL,
                          "origine": "Facebook",
                          "idContact": self.friend.id]
                
                Service.sharedInstance.postIt(parameters:pr as! [String : String] , url:self.urlRegisterContact)
                
                
                print("Objets")
                }
                
            } else {
                print("nooo")
            }
        }
    }
    
    
    
    
    
    @IBAction func importGoogle(_ sender: Any) {
        
        let p = ["inscrivia" : "Google"]
        
        Service.sharedInstance.loadInfoAny(parameters: p, url: urlImportContactsFBG) { (state, Objets) in
            if state {
                
                self.FriendArray = Objets!
                
                for i in 0...self.FriendArray.count-1 {
                    self.friend = Objets![i]
                    
                    
                    let params = [
                        "idU": self.userId,
                        "idContact": self.friend.id]
                    
                    Service.sharedInstance.postIt(parameters:params as! [String : String] , url:self.urlUserContact)
                    
                    
                    let pr = ["Nom": self.friend.Nom,
                              "Prenom": self.friend.prenom,
                              "photoURL": self.friend.photoURL,
                              "origine": "Google",
                              "idContact": self.friend.id]
                    
                    Service.sharedInstance.postIt(parameters:pr as! [String : String] , url:self.urlRegisterContact)
                    
                    
                    print("Objets")
                }
                
            } else {
                print("nooo")
            }
        }
    }
}
 
    
    extension ImportViewController : SlideMenuControllerDelegate {
        
        func leftWillOpen() {
            print("SlideMenuControllerDelegate: leftWillOpen")
        }
        
        func leftDidOpen() {
            print("SlideMenuControllerDelegate: leftDidOpen")
        }
        
        func leftWillClose() {
            print("SlideMenuControllerDelegate: leftWillClose")
        }
        
        func leftDidClose() {
            print("SlideMenuControllerDelegate: leftDidClose")
        }
        
        func rightWillOpen() {
            print("SlideMenuControllerDelegate: rightWillOpen")
        }
        
        func rightDidOpen() {
            print("SlideMenuControllerDelegate: rightDidOpen")
        }
        
        func rightWillClose() {
            print("SlideMenuControllerDelegate: rightWillClose")
        }
        
        func rightDidClose() {
            print("SlideMenuControllerDelegate: rightDidClose")
        }
}
