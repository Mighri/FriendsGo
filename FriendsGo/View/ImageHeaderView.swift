//
//  ImageHeadeVew.swift
//  FriendsGo
//
//  Created by Radhia Mighri on 03/03/2018.
//  Copyright © 2018 Radhia Mighri. All rights reserved.
//

import UIKit
import SDWebImage

class ImageHeaderView : UIView{
    
    @IBOutlet weak var profileImage : UIImageView!
    @IBOutlet weak var backgroundImage : UIImage!
    @IBOutlet weak var Nom : UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
     self.backgroundColor = UIColor(hex: "E0E0E0")
        self.profileImage.layoutIfNeeded()
        self.profileImage.layer.cornerRadius = self.profileImage.bounds.size.height / 2
        self.profileImage.clipsToBounds = true
        self.profileImage.layer.borderWidth = 1
    self.profileImage.layer.borderColor = UIColor.white.cgColor
        
        
        
        
        //let user = UserDefaults.standard.object(forKey: "SaveMe") as! Friend
         let nom = UserDefaults.standard.string(forKey: "SaveName") as! String
         let prenom = UserDefaults.standard.string(forKey: "SavePrenom") as! String
         let email = UserDefaults.standard.string(forKey: "SaveEmail") as! String
         let photo = UserDefaults.standard.string(forKey: "SavePhoto") as! String
       //print(user.Nom)
         print(nom)
         print(prenom)
         print(email)
         print(photo)
        
        self.Nom.text = prenom+" "+nom
        self.profileImage.sd_setImage(with: URL(string: photo), placeholderImage: UIImage(named: "profile"))
    }
    
}

