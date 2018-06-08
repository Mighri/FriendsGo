//
//  MessageViewController.swift
//  FriendsGo
//
//  Created by Radhia Mighri on 06/03/2018.
//  Copyright © 2018 Radhia Mighri. All rights reserved.
//
 
import UIKit
import SDWebImage
import FirebaseAuth
import FirebaseDatabase

/*
class Channel:NSObject{
    var id:String?
    var name:String?
    init(id:String,name:String) {
        self.id = id
        self.name = name
    }
}
*/
class MessageViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    
    
    
    
    //var channel : Channel?
   // private lazy var channelRef = Database.database().reference().child("channels")
    //private var channelrefHandle:DatabaseHandle?
    
    
    
    
    
    @IBOutlet var table: UITableView!
    @IBOutlet var searchBar: UISearchBar!
    var friend : Friend!
    var FriendArray = [Friend]()
    var currentFriendArray = [Friend]() //update table
    let urlgetAmis = MyClass.Constants.urlgetAmis
    var searching: Bool! = false
    let userId = UserDefaults.standard.string(forKey: "Saveid")!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isTranslucent = false
        setUpFriends()
        setUpSearchBar()
        searchBar.placeholder = "Rechercher"
    }
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searching = false
        searchBar.endEditing(true)
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searching = true
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searching = false
        searchBar.endEditing(true)
    }
 
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setNavigationBarItem()
        self.title = "Messages"
    }
   
    
    
    
  
   /*
    deinit {
        if let ref = channelrefHandle{
            channelRef.removeObserver(withHandle: ref)
        }
    }
    
    */
    
    
    
    
    
    
    private func setUpFriends() {
        
        let p = ["IdU" : userId]
        print(userId)
        Service.sharedInstance.loadInfoAny(parameters: p, url: urlgetAmis) { (state, Objets) in
            if state {
                self.FriendArray = Objets!
                //self.currentFriendArray = self.FriendArray
                //self.table.reloadData()
                
                print("Objets")
            } else {
                print("nooo")
            }
        }
    }

    private func setUpSearchBar() {
        searchBar.delegate = self
    }
    
    func alterLayout() {
        table.tableHeaderView = UIView()
        // search bar in section header
        table.estimatedSectionHeaderHeight = 50
        // search bar in navigation bar
        //navigationItem.leftBarButtonItem = UIBarButtonItem(customView: searchBar)
        navigationItem.titleView = searchBar
        searchBar.showsScopeBar = false // you can show/hide this dependant on your layout
        searchBar.placeholder = "Chercher"
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
        
        cell.imageUrl.sd_setImage(with: URL(string: self.currentFriendArray[indexPath.row].photoURL), placeholderImage: UIImage(named: "profile"))
        
        cell.iconimage.image = UIImage(named: "FriendsGo")
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let reciverId = String(describing :currentFriendArray[indexPath.row].id)
        let recieverName = currentFriendArray[indexPath.row].prenom+" "+currentFriendArray[indexPath.row].Nom
        
        
        
        
        
    let view = ChatViewController(collectionViewLayout: UICollectionViewFlowLayout())
        
      view.recieverName = recieverName
         view.reciverId = reciverId
      self.navigationController?.pushViewController(view, animated: true)
        
        
        
        
        
        /*
        Auth.auth().signInAnonymously { (user, error) in
            if error != nil{
                print("error in registering",error!)
                return
            }
            //let uid = user.us
            //let uid = user?.user.uid
            let uid = user?.uid
            UserDefaults.standard.set(uid, forKey: "userId")
           // self.present(UINavigationController(rootViewController: ChannelViewController(style: UITableViewStyle.plain)), animated: true, completion: nil)
            
            self.createChannel(name: self.userId+reciverId)
            self.channelrefHandle = self.channelRef.observe(DataEventType.childAdded, with: { (snapshot) in
                let data = snapshot.value as! NSDictionary
                if let name = data["name"] as? String{
                    let channel : Channel
                    channel = Channel(id: snapshot.key, name: name)
                    
                    let view = ChatViewController(collectionViewLayout: UICollectionViewFlowLayout())
                    view.channel = channel
                    view.channelRef = self.channelRef.child(channel.id!)
                    view.recieverName = recieverName
                    self.navigationController?.pushViewController(view, animated: true)
                }
            })

        }
 */
        /*
        let mystoryboard:UIStoryboard = UIStoryboard(name:"Menu", bundle: nil)
        
        let ViewController = mystoryboard.instantiateViewController(withIdentifier: "Chat") as! LoginViewController
        
    //ViewController.userFriend = currentFriendArray[indexPath.row]
        
   self.navigationController?.pushViewController(ViewController, animated: true)
        */
        
        //self.navigationController?.pushViewController(ChatViewController(collectionViewLayout: UICollectionViewFlowLayout()), animated: true)
        
    }

    
    /*
    func createChannel(name:String){
        let name = [
            "name":name
        ]
        let ref = channelRef.childByAutoId()
        ref.setValue(name)
    }
    */
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        currentFriendArray = FriendArray.filter({ friend -> Bool in
            switch searchBar.selectedScopeButtonIndex {
            case 0:
                if searchText.isEmpty {
                    searching = true
                currentFriendArray = FriendArray
                     table.reloadData()
                }
                return (friend.Nom+" "+friend.prenom).lowercased().contains(searchText.lowercased())
            default:
               // self.currentFriendArray = self.FriendArray
                //table.reloadData()
                return searching == false
                
            }
        })
        table.reloadData()
    }
}


 

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
    
    
    
    
    //var channel : Channel?
    // private lazy var channelRef = Database.database().reference().child("channels")
    //private var channelrefHandle:DatabaseHandle?
    
    
    var channels = [Channel]()
    private lazy var channelRef = Database.database().reference().child("channels")
    private var channelrefHandle:DatabaseHandle?
    
    
    @IBOutlet var table: UITableView!
    @IBOutlet var searchBar: UISearchBar!
    var friend : Friend!
    var FriendArray = [Friend]()
    var currentFriendArray = [Friend]() //update table
    let urlgetAmis = MyClass.Constants.urlgetAmis
    var searching: Bool! = false
    let userId = UserDefaults.standard.string(forKey: "Saveid")!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isTranslucent = false
        setUpFriends()
        setUpSearchBar()
        searchBar.placeholder = "Rechercher"
        
        self.view.backgroundColor = .white
        configureNavBar()
       
        self.observeChannels()
        
        
    }
    
    func observeChannels(){
        channelrefHandle = channelRef.observe(DataEventType.childAdded, with: { (snapshot) in
            let data = snapshot.value as! NSDictionary
            if let name = data["name"] as? String{
                self.channels.append(Channel(id: snapshot.key, name: name))
                DispatchQueue.main.async {
                   // self.tableView.reloadData()
                }
            }
        })
    }
    
    
    deinit {
        if let ref = channelrefHandle{
            channelRef.removeObserver(withHandle: ref)
        }
    }
    
    @objc func addAction(){
        let alert = UIAlertController(title: "Add Channel", message: "Give Channel Name!!!", preferredStyle: .alert)
        alert.addTextField { (textfield) in
            textfield.placeholder = "Channel Name"
        }
        alert.addAction(UIAlertAction(title: "Create Channel", style: UIAlertActionStyle.default, handler: { (_) in
            if (alert.textFields?.first?.hasText)!{
                self.createChannel(name: (alert.textFields?.first?.text!)!)
            }
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    func createChannel(name:String){
        let name = [
            "name":name
        ]
        let ref = channelRef.childByAutoId()
        ref.setValue(name)
    }
    
    func configureNavBar(){
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.add, target: self, action: #selector(addAction))
        self.navigationItem.title = "Channels"
    }
    
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searching = false
        searchBar.endEditing(true)
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searching = true
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searching = false
        searchBar.endEditing(true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setNavigationBarItem()
        self.title = "Messages"
    }
    
    
    
    
    
    /*
     deinit {
     if let ref = channelrefHandle{
     channelRef.removeObserver(withHandle: ref)
     }
     }
     
     */
 
    
    private func setUpFriends() {
        
        let p = ["IdU" : userId]
        print(userId)
        Service.sharedInstance.loadInfoAny(parameters: p, url: urlgetAmis) { (state, Objets) in
            if state {
                self.FriendArray = Objets!
                //self.currentFriendArray = self.FriendArray
                //self.table.reloadData()
                
                print("Objets")
            } else {
                print("nooo")
            }
        }
    }
    
    private func setUpSearchBar() {
        searchBar.delegate = self
    }
    
    func alterLayout() {
        table.tableHeaderView = UIView()
        // search bar in section header
        table.estimatedSectionHeaderHeight = 50
        // search bar in navigation bar
        //navigationItem.leftBarButtonItem = UIBarButtonItem(customView: searchBar)
        navigationItem.titleView = searchBar
        searchBar.showsScopeBar = false // you can show/hide this dependant on your layout
        searchBar.placeholder = "Chercher"
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
      
        
        return cell
    }
 
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let reciverId = String(describing :currentFriendArray[indexPath.row].id)
        let recieverName = currentFriendArray[indexPath.row].prenom+" "+currentFriendArray[indexPath.row].Nom
        
        
        
        self.createChannel(name: recieverName)
        
        let channel = self.channels[indexPath.row]
        let view = ChatViewController(collectionViewLayout: UICollectionViewFlowLayout())
        view.channel = channel
        view.recieverName = recieverName
        view.reciverId = reciverId
        view.channelRef = self.channelRef.child(self.channels[indexPath.row].id!)
        self.navigationController?.pushViewController(view, animated: true)
        
        
        
        
 
        
        /*
         Auth.auth().signInAnonymously { (user, error) in
         if error != nil{
         print("error in registering",error!)
         return
         }
         //let uid = user.us
         //let uid = user?.user.uid
         let uid = user?.uid
         UserDefaults.standard.set(uid, forKey: "userId")
         // self.present(UINavigationController(rootViewController: ChannelViewController(style: UITableViewStyle.plain)), animated: true, completion: nil)
         
         self.createChannel(name: self.userId+reciverId)
         self.channelrefHandle = self.channelRef.observe(DataEventType.childAdded, with: { (snapshot) in
         let data = snapshot.value as! NSDictionary
         if let name = data["name"] as? String{
         let channel : Channel
         channel = Channel(id: snapshot.key, name: name)
         
         let view = ChatViewController(collectionViewLayout: UICollectionViewFlowLayout())
         view.channel = channel
         view.channelRef = self.channelRef.child(channel.id!)
         view.recieverName = recieverName
         self.navigationController?.pushViewController(view, animated: true)
         }
         })
         
         }
         */
        /*
         let mystoryboard:UIStoryboard = UIStoryboard(name:"Menu", bundle: nil)
         
         let ViewController = mystoryboard.instantiateViewController(withIdentifier: "Chat") as! LoginViewController
         
         //ViewController.userFriend = currentFriendArray[indexPath.row]
         
         self.navigationController?.pushViewController(ViewController, animated: true)
         */
        
        //self.navigationController?.pushViewController(ChatViewController(collectionViewLayout: UICollectionViewFlowLayout()), animated: true)
        
    }
    
    
    /*
     func createChannel(name:String){
     let name = [
     "name":name
     ]
     let ref = channelRef.childByAutoId()
     ref.setValue(name)
     }
     */
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        currentFriendArray = FriendArray.filter({ friend -> Bool in
            switch searchBar.selectedScopeButtonIndex {
            case 0:
                if searchText.isEmpty {
                    searching = true
                    currentFriendArray = FriendArray
                    table.reloadData()
                }
                return (friend.Nom+" "+friend.prenom).lowercased().contains(searchText.lowercased())
            default:
                // self.currentFriendArray = self.FriendArray
                //table.reloadData()
                return searching == false
                
            }
        })
        table.reloadData()
    }
}
*/
