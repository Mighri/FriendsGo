//
//  LogViewController.swift
//  FriendsGo
//
//  Created by Design on 07/06/2018.
//  Copyright © 2018 Radhia Mighri. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import FBSDKCoreKit
import FBSDKShareKit
import GoogleSignIn


class LogViewController: UIViewController, FBSDKLoginButtonDelegate, GIDSignInUIDelegate, UITextFieldDelegate {
    
    let loginButton: FBSDKLoginButton = {
        let button = FBSDKLoginButton()
        button.readPermissions = ["email","user_friends"]
        return button
    }()
    
    @IBOutlet weak var signInButton: GIDSignInButton!
    
    @IBOutlet weak var emailAddressTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    let urlAuthMail = MyClass.Constants.urlAuthMail
    let urlRegisterFBG = MyClass.Constants.urlRegisterFBG
    let urlverifUser = MyClass.Constants.urlverifUser
    let urlupdateUser = MyClass.Constants.urlupdateUser
    
    var friend : Friend!
    var amis : [Friend]!
    let button = FBSDKLoginButton()
   
    
    @IBOutlet weak var fd: NSLayoutConstraint!
    
    open override func viewDidLoad() {
        super.viewDidLoad()
          self.title = "FriendsGo"
    
        
        
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        
        notificationCenter.addObserver(self, selector: #selector(keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        
        
      
        /*
         view.addSubview(loginButton)
         loginButton.center = view.center
         loginButton.delegate = self
         let token = FBSDKAccessToken.current()
         if  (token != nil)  {
         fetchProfile()
         // friends()
         }
         */
        GIDSignIn.sharedInstance().uiDelegate = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.notificationReceived(_:)), name:  NSNotification.Name(rawValue: "ToggleAuthUINotification"), object: nil)
        
        emailAddressTextField.delegate = self
        passwordTextField.delegate = self
        
        
        //  view.addSubview(loginButton)
        //  loginButton.center = view.center
        loginButton.delegate = self
        
        
        
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        let userInfo = (notification as NSNotification).userInfo!
        let keyboardHeight =  (userInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        fd.constant = keyboardHeight.height
    }
    
    @objc func keyboardWillHide(_ notification: Notification) {
        fd.constant = 0
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
   
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailAddressTextField
        {
            passwordTextField.becomeFirstResponder()
        }
        else if  textField == passwordTextField
        {
            textField.resignFirstResponder()
        }
        return true
    }
    
    
    
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result :FBSDKLoginManagerLoginResult!, error: Error!)
    {
        print("login completed")
        fetchProfile()
        //friends()
        
    }
    // - Google GIDSignIn
    
    // pressed the Sign In button
    func signInWillDispatch(signIn: GIDSignIn!, error: Error!) {
        // myActivityIndicator.stopAnimating()
    }
    
    // Present a view that prompts the user to sign in with Google
    func signIn(signIn: GIDSignIn!,
                presentViewController Google: UIViewController!) {
        self.present(Google, animated: true, completion: nil)
        
        print("Sign In G+")
    }
    
    // Dismiss the "Sign in with Google" view
    func signIn(signIn: GIDSignIn!,
                dismissViewController Google: UIViewController!) {
        self.dismiss(animated: true, completion: nil)
        print("Sign In dismissed")
        
    }
    
    
    @IBAction func didTapSignOut(_ sender: AnyObject) {
        GIDSignIn.sharedInstance().signOut()
    }
    
    @objc func notificationReceived(_ notification: Notification) {
        guard let fullName = notification.userInfo?["fullName"] as? String
            else {
                return
                
        }
        
        print(fullName)
        
        let mail = notification.userInfo?["email"] as? String
        print(mail!)
        let givenName = notification.userInfo?["givenName"] as? String
        print(givenName!)
        let familyName = notification.userInfo?["familyName"] as? String
        print(familyName!)
        let photoURL = notification.userInfo?["photoURL"] as? URL
        
        
        print(String(describing: photoURL!))
        //       print(photoURL!)
        
        let photoo = String(describing: photoURL!)
        print(photoo)
        
        // verif user existance
        
        let ps = ["Mail": mail!]
        
        Service.sharedInstance.loadInfo(parameters:ps, url:urlverifUser) { (state, Objets) in
            if state {
                print(Objets!)
                print("Utilisateur existe")
                //update user account
                
                let pr = ["Nom": familyName,
                          "Prenom": givenName,
                          "Mail": mail,
                          "InscriVia": "Google",
                          "photoURL": photoo]
                
                Service.sharedInstance.postIt(parameters:pr as! [String : String], url:self.urlupdateUser)
                
                let delegate =  UIApplication.shared.delegate as! AppDelegate
                delegate.createMenuView()
            }
            else
            {
                print("Utilisateur n'existe pas")
                // Register Google user account
                
                let p = ["Nom": familyName,
                         "Prenom": givenName,
                         "Mail": mail,
                         "InscriVia": "Google",
                         "photoURL": photoo]
                
                
                Service.sharedInstance.postIt(parameters:p as! [String : String], url:self.urlRegisterFBG)
                
                let delegate =  UIApplication.shared.delegate as! AppDelegate
                delegate.createMenuView()
                
            }
        }
    }
    
    @IBAction func fbLogin(_ sender: Any) {
        
        let token = FBSDKAccessToken.current()
        if  (token != nil)  {
            fetchProfile()
            // friends()
        }
        
    }
    
    @IBAction func loginSubmitted(_ sender: Any) {
        
        
        if (
            (emailAddressTextField.text?.isEmpty)! ||
                (passwordTextField.text?.isEmpty)!)
        {
            // Display Alert message and return
            displayMessage(userMessage: "Les champs sont obligatoires")
            return
        }
        // - Params
        
        let parameters = ["Mail": emailAddressTextField.text!,
                          "MotDePasse": passwordTextField.text!]
        
        //Service.sharedInstance.login()
        
        Service.sharedInstance.loadInfo(parameters:parameters, url:urlAuthMail) { (state, Objets) in
            if state {
                print(Objets!)
                self.friend = Objets![0]
                print(self.friend)
                print("Utilisateur existe")
                
                let delegate =  UIApplication.shared.delegate as! AppDelegate
                delegate.createMenuView()
                
            }
            else
            {
                print("Utilisateur n'existe pas")
                
                // Display Alert message and return
                self.displayMessage(userMessage: "Echec d'authentification")
                return
            }
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
            
            // verif user existance
            
            let ps = ["Mail": mail]
            
            Service.sharedInstance.loadInfo(parameters:ps, url:self.urlverifUser) { (state, Objets) in
                if state {
                    print(Objets!)
                    print("Utilisateur existe")
                    
                    //update user account
                    
                    let pr = ["Nom": nom,
                              "Prenom": prenom,
                              "Mail": mail,
                              "InscriVia": "Facebook",
                              "photoURL": photo]
                    
                    Service.sharedInstance.postIt(parameters:pr as! [String : String], url:self.urlupdateUser)
                    
                    let delegate =  UIApplication.shared.delegate as! AppDelegate
                    delegate.createMenuView()
                }
                else
                {
                    print("Utilisateur n'existe pas")
                    // Register Google user account
                    
                    let p = ["Nom": nom,
                             "Prenom": prenom,
                             "Mail": mail,
                             "InscriVia": "Facebook",
                             "photoURL": photo]
                    
                    
                    Service.sharedInstance.postIt(parameters:p as! [String : String], url:self.urlRegisterFBG)
                    
                    let delegate =  UIApplication.shared.delegate as! AppDelegate
                    delegate.createMenuView()
                }
            }
        }
    }
    
    
    func friends() {
        let params = ["fields": "id, first_name, last_name, email, picture"]
        FBSDKGraphRequest(graphPath: "me/taggable_friends", parameters: params).start { (connection, result , error) -> Void in
            if let error = error {
                print(error)
            } else if let info = result as? [String: Any] {
                print(info)
                if let data = info["data"] as? [[String: Any]] {
                    for object in data {
                        if let nom = object["first_name"] as? String {
                            print(nom)
                            let prenom = object["last_name"] as? String
                            print(prenom)
                            let id = object["id"] as? String
                            print(id)
                        }
                    }
                }
            } else {
                print("Unexpected result: \(String(describing: result))")
            }
        }
    }
    /*
     func loginButton(_ button: FBSDKLoginButton!, didCompleteWith result :FBSDKLoginManagerLoginResult!, error: Error!)
     {
     print("login completed")
     fetchProfile()
     // friends()
     //list()
     
     }
     */
    func loginButtonDidLogOut(_ button: FBSDKLoginButton!){
        
    }
    func loginButtonWillLogin(_ button: FBSDKLoginButton!) -> Bool{
        return true
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
}



