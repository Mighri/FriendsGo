//
//  NotificationsViewController.swift
//  FriendsGo
//
//  Created by Radhia Mighri on 06/03/2018.
//  Copyright © 2018 Radhia Mighri. All rights reserved.
//
import UIKit
import SDWebImage

class NotificationViewController: UITableViewController {
    
    var FriendArray = [Friend]()
    
    let urlgetInvitations  = MyClass.Constants.urlgetInvitations
    let urlUpdateInvitation  = MyClass.Constants.urlUpdateInvitation
    let urlDeleteInvitation = MyClass.Constants.urlDeleteInvitation
    
    let userId = UserDefaults.standard.string(forKey: "Saveid")!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        let p = ["idinvite" : userId]
        
        Service.sharedInstance.loadInfoAny(parameters: p, url: urlgetInvitations) { (state, Objets) in
            if state {
                self.FriendArray = Objets!
                UserDefaults.standard.set(self.FriendArray.count, forKey: "nbreInv")
                self.tableView.reloadData()
                print("Objets")
            } else {
                print("nooo")
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setNavigationBarItem()
        self.title = "Notifications"
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
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "NotificationCell", for: indexPath) as! NotificationCell
        /*
        cell.Nom.text = FriendArray[indexPath.row].Nom+" "+FriendArray[indexPath.row].prenom
        
        //cell.Prenom.text = currentFriendArray[indexPath.row].prenom
        
        cell.imageUrl.sd_setImage(with: URL(string: self.FriendArray[indexPath.row].photoURL), placeholderImage: UIImage(named: "profile"))
        
        
        //cell.iconimage.image = UIImage(named: "logo-facebook")
        
        cell.buttonConfimer.tag = indexPath.row
        cell.buttonConfimer.addTarget(self, action: #selector(buttonConfimer), for: .touchUpInside)
        //  cell.button.addTarget(self, action: "addButtonPressed", for: .touchUpInside)
        //print(cell.button.tag)
        
        cell.buttonAnnuler.tag = indexPath.row
        cell.buttonAnnuler.addTarget(self, action: #selector(buttonSupprimer), for: .touchUpInside)
        
        cell.message.isHidden = true
        */
        return cell
    }
    
    @objc func buttonConfimer(sender: UIButton) {
        let buttonTag = sender.tag
        //print(buttonTag)
        //print(self.FriendArray[buttonTag].id)
        //print("Hey")
        
        
        let paras = ["idU": self.FriendArray[buttonTag].id,
                     "idInvite": userId,
                     "EtatInvitation" : "Acceptée",
                     "Moyen": "FriendsGo"]
        
        
        Service.sharedInstance.postIt(parameters:paras as! [String : String], url:self.urlUpdateInvitation)
        
        let button = sender as! UIButton
        let view = button.superview!
        let cell = view.superview as! TableCellInvitation
        cell.message.text = "Invitation acceptée"
        
        print(sender.tag)
        if  cell.message.isHidden == true
        {
            cell.buttonAnnuler.isHidden = true
            cell.message.isHidden = false
            sender.isHidden = true
        } else {
            cell.message.isHidden = true
        }
    }
    
    
    @objc func buttonSupprimer(sender: UIButton) {
        let buttonTag = sender.tag
        
        let parameters = ["idU": self.FriendArray[buttonTag].id,
                          "idInvite": userId]
        
        Service.sharedInstance.postIt(parameters:parameters as! [String : String], url:self.urlDeleteInvitation)
        
        let button = sender as! UIButton
        let view = button.superview!
        let cell = view.superview as! TableCellInvitation
        cell.message.text = "Demande supprimée"
        
        print(sender.tag)
        if  cell.message.isHidden == true
        {
            cell.buttonConfimer.isHidden = true
            cell.message.isHidden = false
            sender.isHidden = true
        } else {
            cell.message.isHidden = true
        }
        
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    
}


