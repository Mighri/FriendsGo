//
//  LoginViewController.swift
//  FriendsGo
//
//  Created by Radhia Mighri on 02/06/2018.
//  Copyright © 2018 Radhia Mighri. All rights reserved.
//
/*
import UIKit
import FirebaseAuth


class LoginViewController: UIViewController {
    
    let loginButon:UIButton = {
        let button = UIButton()
        button.setTitle("Login Anonymoulsy", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    @objc func loginAction(){
        Auth.auth().signInAnonymously { (user, error) in
            if error != nil{
                print("error in registering",error!)
                return
            }
            //let uid = user.us
            let uid = user?.user.uid
            UserDefaults.standard.set(uid, forKey: "userId")
            self.present(UINavigationController(rootViewController: ChannelViewController(style: UITableViewStyle.plain)), animated: true, completion: nil)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(loginButon)
        loginButon.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 0).isActive = true
        loginButon.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10).isActive = true
        loginButon.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10).isActive = true
        loginButon.addTarget(self, action: #selector(loginAction), for: .touchUpInside)

        // Do any additional setup after loading the view.
    }

  
    

   

}
*/
