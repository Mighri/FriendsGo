//
//  InterestedFriendsController.swift
//  FriendsGo
//
//  Created by Radhia Mighri on 17/04/2018.
//  Copyright © 2018 Radhia Mighri. All rights reserved.
//

import UIKit
import SDWebImage

class  InterestedFriendsController: UITableViewController {
    var FriendArray = [Friend]()
    var event: Event!
    let urlGetInteresed = MyClass.Constants.urlGetInteresed
    
    let userId = UserDefaults.standard.string(forKey: "Saveid")!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let p = ["IdU" : userId,
                 "IDEvent" : event.idE!]
        
        Service.sharedInstance.loadInfoAny(parameters: p, url: urlGetInteresed) { (state, Objets) in
            if state {
                self.FriendArray = Objets!
                self.tableView.reloadData()
                print("Objets")
            } else {
                print("nooo")
            }
            
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //self.setNavigationBarItem()
        //self.title = "Invitations"
    }
    
    // Table
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if FriendArray != nil, FriendArray.count > 0
        {
            return FriendArray.count
        }
        return 0
        //return FriendArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "InvitationEventCell", for: indexPath) as! InvitationEventCell
        cell.nomAmis.text = self.FriendArray[indexPath.row].Nom+" "+self.FriendArray[indexPath.row].prenom
        
        cell.imageAmis.sd_setImage(with: URL(string: self.FriendArray[indexPath.row].photoURL), placeholderImage: UIImage(named: "profile"))
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    
}


