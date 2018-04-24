//
//  FB.swift
//  FriendsGo
//
//  Created by Radhia Mighri on 12/04/2018.
//  Copyright © 2018 Radhia Mighri. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import FBSDKCoreKit
import FBSDKShareKit

class FB: UIViewController, FBSDKLoginButtonDelegate {
    
    let loginButton: FBSDKLoginButton = {
        let button = FBSDKLoginButton()
        button.readPermissions = ["email","user_friends"]
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(loginButton)
        //loginButton.center = view.center
        loginButton.delegate = self
        let token = FBSDKAccessToken.current()
        if  (token != nil)  {
            fetchProfile()
            // friends()
        }
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
            print(info["email"])
            print(info["first_name"])
            print(info["last_name"])
            print(result)
            
        }
    }
    
    
    
    func friends() {
        let params = ["fields": "id, first_name, last_name, email, picture"]
        /*  let params = ["fields": "id, first_name, last_name, middle_name, name, email, picture"]*/
        FBSDKGraphRequest(graphPath: "me/taggable_friends", parameters: params).start { (connection, result , error) -> Void in
            
            if error != nil {
                print(error!)
            }
            
            
            // let infos = result as! [String : AnyObject]
            // print(info["email"])
            //  let info = result as! [Friends]!
            // let val = result as! Optional<String>
            // print(val)
            //print(info["email"])
            print(result)
            
        }
    }
    
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result :FBSDKLoginManagerLoginResult!, error: Error!)
    {
        print("login completed")
        fetchProfile()
        //friends()
        
    }
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!){
        
    }
    func loginButtonWillLogin(_ loginButton: FBSDKLoginButton!) -> Bool{
        return true
    }
}




