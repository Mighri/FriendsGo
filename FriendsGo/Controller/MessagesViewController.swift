//
//  MessagesViewController.swift
//  FriendsGo
//
//  Created by Design on 14/06/2018.
//  Copyright © 2018 Radhia Mighri. All rights reserved.
//

/*
import UIKit
import SDWebImage
import FirebaseAuth
import FirebaseDatabase


class Channel:NSObject{
    var id:String?
    var name:String?
    init(id:String,name:String) {
        self.id = id
        self.name = name
    }
}

class MessageViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    
    
    
    var channels = [Channel]()
    private lazy var channelRef = Database.database().reference().child("channels")
    private var channelrefHandle:DatabaseHandle?
    
    
    
    
    @IBOutlet var table: UITableView!
 
    var friend : Friend!
    var friendd : Friend!
    var conv : Message!
    
    
    var FriendArray = [Friend]()
    var currentFriendArray = [Friend]() //update table
    let urlgetAmis = MyClass.Constants.urlgetAmis
    let urlGetChannels = MyClass.Constants.urlGetChannels
    let urlGetMessageReciever = MyClass.Constants.urlgetMessageReciever
    let urlGetConvReciever = MyClass.Constants.urlGetConvReciever
    let urlGetUsername = MyClass.Constants.urlGetUsername
    
    var searching: Bool! = false
    let userId = UserDefaults.standard.string(forKey: "Saveid")!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Auth.auth().signInAnonymously { (user, error) in
            if error != nil{
                print("error in registering",error!)
                return
            }
            
            let uid = user?.uid
            
        }
        self.observeChannels()
  
     
        
    }
    
    func observeChannels(){
        channelrefHandle = channelRef.observe(DataEventType.childAdded, with: { (snapshot) in
            let data = snapshot.value as! NSDictionary
            if let name = data["name"] as? String{
                self.channels.append(Channel(id: snapshot.key, name: name))
                DispatchQueue.main.async {
                    self.table.reloadData()
                }
            }
        })
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setNavigationBarItem()
        self.title = "Messages"
    }

    deinit {
        if let ref = channelrefHandle{
            channelRef.removeObserver(withHandle: ref)
        }
    }

  

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.channels.count
    }
    
 
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = self.table.dequeueReusableCell(withIdentifier: "Cell") as! TableCell
        
        print(self.channels[indexPath.row].name!)
        
        print(userId)
        
  cell.Nom.text = self.channels[indexPath.row].name!
        
        let parameters = ["ChannelName": self.channels[indexPath.row].name!,
                          "senderID": userId]
        
        Service.sharedInstance.loadConversations(parameters:parameters as! [String: Any], url:urlGetChannels) { (state, Objets) in
            if state {
                print(Objets!)
                print("Channel existe")
                print(self.channels[indexPath.row].name!)
                
                cell.Nom.text = self.channels[indexPath.row].name!
                //tableView.separatorStyle = .none
            }
                
            else
                
            {
                
                let pp = ["ChannelName": self.channels[indexPath.row].name!,
                          "RecieverID": self.userId]
                
                Service.sharedInstance.loadConversations(parameters: pp, url: self.urlGetConvReciever) { (state, Objets) in
                    if state {
                        self.conv = Objets![0]
                        
                        print(self.conv.senderID)
                        
                        let ppp = ["IdU": self.conv.senderID!]
                        
                        Service.sharedInstance.loadInfoAny(parameters: ppp, url: self.urlGetUsername) { (state, Objets) in
                            if state {
                                self.friendd = Objets![0]
                                
                                cell.Nom.text = self.friendd.prenom+" "+self.friendd.Nom
                                
                                print("Message Reciever Name")
                            }
                            else {
                                
                                print("no Message Reciever Name")
                            }
                        }
                        
                    }
                    else
                        
                    {
                        
                    }
                    
                    
                }
                
                print("Channel n'existe pas")
                UserDefaults.standard.set(indexPath.row, forKey: "tagCell")
                
            }
        }
        
        
        return cell
        
    }
 
    /*
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
          let cell = self.table.dequeueReusableCell(withIdentifier: "Cell") as! TableCell
        cell.Nom.text = self.channels[indexPath.row].name
        return cell
    }
    */
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        let tagg = UserDefaults.standard.integer(forKey: "tagCell")
        //print(tagg)
        var rowHeight:CGFloat = 0.0
        
        if(indexPath.row == tagg){
            
            rowHeight = 0.0
            
        }
            
        else{
            
            rowHeight = 55.0    //or whatever you like
        }
        return rowHeight
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let channel = self.channels[indexPath.row]
        let view = ChatViewController(collectionViewLayout: UICollectionViewFlowLayout())
        view.channel = channel
        view.channelRef = self.channelRef.child(self.channels[indexPath.row].id!)
        self.navigationController?.pushViewController(view, animated: true)
 
    }
    
    @IBAction func addUser()
    {
        let popOverVC = UIStoryboard(name: "MWAPopup", bundle: nil).instantiateViewController(withIdentifier: "addUserPopUp") as! addUserPopUp
        //popOverVC.event = event
        self.addChildViewController(popOverVC)
        //popOverVC.view.frame = self.view.frame
        self.view.addSubview(popOverVC.view)
        popOverVC.didMove(toParentViewController: self)
        //popOverVC.show(vc: self)
        
    }
}
 */
