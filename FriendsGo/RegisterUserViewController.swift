//
//  RegisterUserViewController.swift
//  FriendsGo
//
//  Created by Radhia Mighri on 27/02/2018.
//  Copyright © 2018 Radhia Mighri. All rights reserved.
//


import UIKit

class RegisterUserViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailAddressTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var repeatPasswordTextField: UITextField!
    
    let urlverifUser = MyClass.Constants.urlverifUser
    let urlRegisterMail = MyClass.Constants.urlRegisterMail

    var friend : Friend!
    var amis : [Friend]!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        emailAddressTextField.delegate = self
        passwordTextField.delegate = self
        firstNameTextField.delegate = self
        lastNameTextField.delegate = self
        repeatPasswordTextField.delegate = self
       // self.hideKeyboardWhenTappedAround()
    }

    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == firstNameTextField
        {
            lastNameTextField.becomeFirstResponder()
        }
        else if  textField == lastNameTextField
        {
            textField.resignFirstResponder()
        }
        else if  textField == emailAddressTextField
        {
            textField.resignFirstResponder()
        }
        else if  textField == passwordTextField
        {
            textField.resignFirstResponder()
        }
        else if  textField == repeatPasswordTextField
        {
            textField.resignFirstResponder()
        }
        return true
    }
    
    
    @IBAction func cancelButtonTapped(_ sender: Any) {
        print("Cancel button tapped")
        
        self.dismiss(animated: true, completion: nil)
        
        let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "LoginController") as! LogViewController
        
        self.navigationController?.pushViewController(secondViewController, animated: true)
        
    }
    
    
    func validateEmail(enteredEmail:String) -> Bool {
        
        let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailFormat)
        return emailPredicate.evaluate(with: enteredEmail)
        
    }
    
    
    @IBAction func signupButtonTapped(_ sender: Any) {
        print("Sign up button tapped")
        
        // Validate required fields are not empty
        if (firstNameTextField.text?.isEmpty)! ||
            (lastNameTextField.text?.isEmpty)! ||
            (emailAddressTextField.text?.isEmpty)! ||
            (passwordTextField.text?.isEmpty)!
        {
            // Display Alert message and return
            displayMessage(userMessage: "Tous les champs sont obligatoires")
            return
        }
        
        // Validate password
        if ((passwordTextField.text?.elementsEqual(repeatPasswordTextField.text!))! != true)
        {
            // Display alert message and return
            displayMessage(userMessage: "Les mots de passe ne correspondent pas")
            return
        }
        
    if (validateEmail(enteredEmail: emailAddressTextField.text!) != true){
        
        // Display alert message and return
        displayMessage(userMessage: "E-Mail invalide")
        return
            
        }
        
        //let p = ["Mail": emailAddressTextField.text!]
        
        
        let parameters = ["Mail": emailAddressTextField.text!,
                          "MotDePasse": passwordTextField.text!]
        
        Service.sharedInstance.loadInfo(parameters:parameters, url:urlverifUser) { (state, Objets) in
            if state {
                print(Objets!)
                print("Utilisateur existe")
                
                // Display Alert message and return
                self.displayMessage(userMessage: "Ce compte existe déjà")
                return
                
                
            }
            else
            {
                print("Utilisateur n'existe pas")
                
                
                let paras = ["Nom": self.firstNameTextField.text!,
                                  "Prenom": self.lastNameTextField.text!,
                                  "Mail": self.emailAddressTextField.text!,
                                  "InscriVia": "FriendsGo",
                                  "MotDePasse": self.passwordTextField.text!]
                
                
                Service.sharedInstance.postIt(parameters:paras, url:self.urlRegisterMail)
                
                
                
                
                
                
                let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "LoginController") as! LogViewController
                
                self.navigationController?.pushViewController(secondViewController, animated: true)
                
                
            }
        }
    }
    
    
    
    func removeActivityIndicator(activityIndicator: UIActivityIndicatorView)
    {
        DispatchQueue.main.async
            {
                activityIndicator.stopAnimating()
                activityIndicator.removeFromSuperview()
        }
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

