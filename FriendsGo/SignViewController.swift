//
//  SignViewController.swift
//  FriendsGo
//
//  Created by Radhia Mighri on 15/03/2018.
//  Copyright © 2018 Radhia Mighri. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import FBSDKCoreKit
import FBSDKShareKit
import GoogleSignIn

class SignViewController: UIViewController, FBSDKLoginButtonDelegate, GIDSignInUIDelegate, GIDSignInDelegate {
    
        //starts here
        let fbButton:FBSDKLoginButton = {
            let button = FBSDKLoginButton()
            button.readPermissions = ["public_profile", "email", "user_friends"]
            return button
        }()
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            self.title = "Sign In"
          
            
            if FBSDKAccessToken.current() == nil {
                print("I got token: \(FBSDKAccessToken.current()?.tokenString)")
                view.addSubview(fbButton)
                fbButton.center = view.center
                fbButton.delegate = self
                self.fetchProfile()
            }
                
            else {
                print("Dont have token")
                self.view.addSubview(fbButton)
                fbButton.center = self.view.center
                fbButton.delegate = self
            }
            
            GIDSignIn.sharedInstance().uiDelegate = self
            GIDSignIn.sharedInstance().delegate = self
            let googleButton = GIDSignInButton(frame: CGRect(x: 30, y: 150, width: 100, height: 50))
            view.addSubview(googleButton)
        }
        
        override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
            // Dispose of any resources that can be recreated.
        }
        
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
            if error != nil {
                print(error.localizedDescription)
                return
            }
            print("I'm in")
        fetchProfile()
        }
        
    
    
    
    
    func fetchProfile(){
        
        print("fetch profile")
        
        let parameters = ["fields": "email, first_name, last_name, picture.type(large)"]
        
        FBSDKGraphRequest(graphPath: "me", parameters: parameters).start(completionHandler:) { ( connection, result, error)-> Void in
            if error != nil {
                print(error)
                return
            }
            /*if  let result = parameters as? AnyObject{
             let email = result["email"] as! String?
             
             print(email)
             }
             */
            let info = result as! [String : AnyObject]
            print(info["email"]!)
            print(info["first_name"]!)
            print(info["last_name"]!)
            print(info["picture"]!)
            
            print(result)
            
            let nom = info["first_name"] as! String
            let prenom = info["last_name"] as! String
            let mail = info["email"] as! String
            print(mail)
            
            
            
            let infoPicture = info["picture"] as! [String : AnyObject]
            let Objet = (infoPicture as! [String : AnyObject])["data"]
            let photo = Objet!["url"] as! String
            
            print(photo)

        }
    }

    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
            print("Logged out")
        }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        
    }


}
