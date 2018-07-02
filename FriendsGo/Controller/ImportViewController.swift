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
       let urlGetUsername = MyClass.Constants.urlGetUsername
    
    var friend : Friend!
     var correspondance : Correspondance!
    var FriendArray = [Friend]()
    var correspondances = [Correspondance]()
    
    let urlRegisterContact = MyClass.Constants.urlRegisterContact
    let urlUserContact = MyClass.Constants.urlUserContact
    let urlImportContactsFBG = MyClass.Constants.urlImportContactsFBG
     let urlgetCorrespondance = MyClass.Constants.urlgetCorrespondance
      let urlgetAmis = MyClass.Constants.urlgetAmis
    
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
    
    
    func displayMessage(userMessage:String) -> Void {
        DispatchQueue.main.async
            {
                let alertController = UIAlertController(title: "Erreur", message: userMessage, preferredStyle: .alert)
                
                let OKAction = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction!) in
                    // Code in this block will trigger when OK button tapped.
                    print("Ok button tapped")
                    DispatchQueue.main.async
                        {
                            self.dismiss(animated: true, completion: nil)
                    }
                }
                alertController.addAction(OKAction)
                self.present(alertController, animated: true, completion:nil)
        }
    }
    
    
    @IBAction func fbLogin(_ sender: Any) {
        
        
        print(self.userId)
        
        let pz = ["IdU" : self.userId] as [String : Any]
        
        Service.sharedInstance.loadInfoAny(parameters: pz, url: urlGetUsername) { (state, Objets) in
            if state {
                self.friend = Objets![0]
                if (self.friend.origine == "Facebook")
                {
                    
                }
                else
                {
                    // Display Alert message and return
                    self.displayMessage(userMessage: "Veuillez connecter avec votre  compte Facebook")
                    return
                }
                print("Objets")
            } else {
                print("nooo")
            }
            
        }
        
        
        
        
        let p = ["inscrivia" : "Facebook"]
        
        Service.sharedInstance.loadInfoAny(parameters: p, url: urlImportContactsFBG) { (state, Objets) in
            if state {
                
                self.FriendArray = Objets!
                
                for i in 0...self.FriendArray.count-1 {
                self.friend = Objets![i]
                
                
                    let p = ["IdUkjk" : self.userId, "idContacttt" : self.friend.id]
                    
                    Service.sharedInstance.loadCorrespondance(parameters: p as! [String : String], url: self.urlgetCorrespondance) { (state, Objets) in
                        if state {
                            
                            print("déjà importé")
                            
                        } else {
                            
                            
                            
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
                            
                            
                            
                            print("nooo")
                        }
                        
                    }
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
                    
                    
                    let p = ["IdUkjk" : self.userId, "idContacttt" : self.friend.id]
                    
                    Service.sharedInstance.loadCorrespondance(parameters: p as! [String : String], url: self.urlgetCorrespondance) { (state, Objets) in
                        if state {
                            
                            print("déjà importé")
                            
                        } else {
                            
                            
                            
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
                            
                            
                            
                            print("nooo")
                        }
                        
                    }
                    
                    
                    
                    
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
