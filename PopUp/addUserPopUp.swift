//
//  addUserPopUp.swift
//  FriendsGo
//
//  Created by Design on 11/06/2018.
//  Copyright © 2018 Radhia Mighri. All rights reserved.
//

import UIKit
import SDWebImage
import FirebaseDatabase


class addUserPopUp: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    @IBOutlet var table: UITableView!
    
    
        private lazy var channelRef = Database.database().reference().child("channels")
    
    
    var friend : Friend!
    var FriendArray = [Friend]()
    var currentFriendArray = [Friend]() //update table
    let urlgetAmis = MyClass.Constants.urlgetAmis
        let urlRegisterConversation = MyClass.Constants.urlRegisterConversation
      let urlGetConversations = MyClass.Constants.urlGetConversations
    
    let userId = UserDefaults.standard.string(forKey: "Saveid")!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpFriends()
     
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        
        self.showAnimate()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        //view.endEditing(true)
        self.removeAnimate()
        //self.view.removeFromSuperview()
    }
    
    func showAnimate()
    {
        self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        self.view.alpha = 0.0;
        UIView.animate(withDuration: 0.25, animations: {
            self.view.alpha = 1.0
            self.view.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        });
    }
    
    func removeAnimate()
    {
        UIView.animate(withDuration: 0.25, animations: {
            self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
            self.view.alpha = 0.0;
        }, completion:{(finished : Bool)  in
            if (finished)
            {
                self.view.removeFromSuperview()
            }
        });
    }
    
    func show(vc:UIViewController) {
        vc.addChildViewController(self)
        vc.view.addSubview(self.view)
    }
    
    func close() {
        self.view.removeFromSuperview()
        self.removeFromParentViewController()
    }
    private func setUpFriends() {
        
        let p = ["IdU" : userId]
        
        Service.sharedInstance.loadInfoAny(parameters: p, url: urlgetAmis) { (state, Objets) in
            if state {
                self.FriendArray = Objets!
                self.currentFriendArray = self.FriendArray
                self.table.reloadData()
                
                print("Objets")
            } else {
                print("nooo")
            }
        }
    }
 
    
    // Table
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if currentFriendArray != nil, currentFriendArray.count > 0
        {
            return currentFriendArray.count
        }
        return currentFriendArray.count
        
        //return currentFriendArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = self.table.dequeueReusableCell(withIdentifier: "Cell") as! TableCell
        
        cell.Nom.text = currentFriendArray[indexPath.row].Nom+" "+currentFriendArray[indexPath.row].prenom
        
        //cell.Prenom.text = currentFriendArray[indexPath.row].prenom
        
        cell.imageUrl.sd_setImage(with: URL(string: self.currentFriendArray[indexPath.row].photoURL), placeholderImage: UIImage(named: "profile"))
        
       //cell.iconimage.image = UIImage(named: "FriendsGo")
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let reciverId = String(describing :currentFriendArray[indexPath.row].id!)
        let recieverName = String(describing :currentFriendArray[indexPath.row].prenom+" "+currentFriendArray[indexPath.row].Nom)
 
        
         let ps = ["senderID": self.userId,
                   "ChannelName": currentFriendArray[indexPath.row].prenom+" "+currentFriendArray[indexPath.row].Nom]
         
         Service.sharedInstance.loadConversations(parameters:ps, url:urlGetConversations) { (state, Objets) in
         if state {
         print(Objets!)
         print("Conversation existe")
         
         }
            
         else
         {
                 print("Conversation n'existe pas")
            
            self.createChannel(name: recieverName)
             print("Channel crée")

 
            let paras = ["senderID": self.userId,
                         "RecieverID": reciverId,
                         "ChannelName": recieverName
            ]
            
            Service.sharedInstance.postItAny(parameters:paras, url:self.urlRegisterConversation)
            
         }
         }
        close()
        
    }
    func createChannel(name:String){
        let name = [
            "name":name
        ]
        let ref = channelRef.childByAutoId()
        ref.setValue(name)
        
        // UserDefaults.standard.set(ref, forKey: "ref")
        
        
    }
    
}




