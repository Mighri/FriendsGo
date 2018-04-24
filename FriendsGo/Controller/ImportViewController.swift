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

class ImportViewController: UIViewController, FBSDKLoginButtonDelegate {
  
    
    let urlRegisterContact = MyClass.Constants.urlRegisterContact
    let urlUserContact = MyClass.Constants.urlUserContact
    
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
        
        /*   let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "SignViewController") as! SignViewController
         self.navigationController?.pushViewController(secondViewController, animated: true)
         */
        
        button.readPermissions = ["public_profile","email","user_friends"]
        let token = FBSDKAccessToken.current()
        if  (token != nil)  {
            print("***********************")
            friends()
        }
        
    }
    
    
    
    func friends() {
        let params = ["fields": "id, first_name, last_name, email, picture"]
        FBSDKGraphRequest(graphPath: "me/taggable_friends", parameters: params).start { (connection, result , error) -> Void in
            if let error = error {
                print(error)
            } else if let info = result as? [String: Any] {
                print(info)
                /*
                let idUser = UserDefaults.standard.integer(forKey: "Saveid")
                print(idUser)
                let d = String(describing: idUser)
                print(d)
                */
                if let data = info["data"] as? [[String: Any]] {
                   
                    for i in 0...data.count-1 {
                        if let nom = data[i]["first_name"] as? String {
                            print(nom)
                            let prenom = data[i]["last_name"] as? String
                            print(prenom as Any)
                            let idContact = data[i]["id"] as? String
                            print(idContact as Any)
                            
                            let infoPicture = data[i]["picture"] as! [String : AnyObject]
                            let Objet = (infoPicture as [String : AnyObject])["data"]
                            let photo = Objet!["url"] as! String
          
                            let idUser = UserDefaults.standard.string(forKey: "Saveid") as? String
                            
                            let params = [
                                "idU": idUser!,
                        "idContact": idContact!]
                            
                            Service.sharedInstance.postIt(parameters:params , url:self.urlUserContact)
                            
                      
                            let pr = ["Nom": nom,
                                      "Prenom": prenom!,
                                      "photoURL": photo,
                                      "origine": "Facebook",
                                      "idContact": idContact!]
                            
                            Service.sharedInstance.postIt(parameters:pr , url:self.urlRegisterContact)

                        }
                    }
                }
                
            } else {
                print("Unexpected result: \(String(describing: result))")
            }
        }
    }
    
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        
    }
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
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
