//
//  SearchViewController.swift
//  FriendsGo
//
//  Created by Radhia Mighri on 25/03/2018.
//  Copyright © 2018 Radhia Mighri. All rights reserved.
//

import UIKit
import SDWebImage


class SearchViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    @IBOutlet var table: UITableView!
    @IBOutlet var searchBar: UISearchBar!
    var friend : Friend!
    var  invitations = [InvitationFG]()
    var FriendArray = [Friend]()
    var FriendsEmpty = [Friend]()
    var currentFriendArray = [Friend]() //update table
    let urlgetUsers = MyClass.Constants.urlgetUsers
    let urlInvitationFG = MyClass.Constants.urlInvitationFG
    let urlverifInvitation = MyClass.Constants.urlverifInvitation
    let userId = UserDefaults.standard.string(forKey: "Saveid")!
     var searching: Bool! = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpFriends()
        setUpSearchBar()
        alterLayout()
        searchBar.showsCancelButton = false
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searching = false
        searchBar.endEditing(true)
        searchBar.showsCancelButton = false
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searching = true
        searchBar.showsCancelButton = true
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searching = false
        searchBar.endEditing(true)
        searchBar.showsCancelButton = false
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searching = false
        searchBar.endEditing(true)
        searchBar.showsCancelButton = false
    }
    private func setUpFriends() {
        
       let p = ["inscrivia" : "FriendsGo"]
        
        Service.sharedInstance.loadInfoAny(parameters: p, url: urlgetUsers) { (state, Objets) in
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
        
       
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = self.table.dequeueReusableCell(withIdentifier: "Cell") as! TableCell
        
        cell.Nom.text = currentFriendArray[indexPath.row].Nom+" "+currentFriendArray[indexPath.row].prenom
        
        //cell.Prenom.text = currentFriendArray[indexPath.row].prenom
        
        cell.imageUrl.sd_setImage(with: URL(string: self.currentFriendArray[indexPath.row].photoURL), placeholderImage: UIImage(named: "profile"))
        
        
        
        
        if(self.currentFriendArray[indexPath.row].inscrivia == "Facebook")
        {
            cell.iconimage.image = UIImage(named: "fb-icon")
        }
        else if(self.currentFriendArray[indexPath.row].inscrivia == "Google")
        {
            cell.iconimage.image = UIImage(named: "Google-icon")
        }
        else if(self.currentFriendArray[indexPath.row].inscrivia == "FriendsGo")
        {
            cell.iconimage.image = UIImage(named: "FriendsGo")
        }
        
        
        //cell.iconimage.image = UIImage(named: "logo-facebook")
        
       cell.button.tag = indexPath.row
        cell.button.addTarget(self, action: #selector(addButtonPressed), for: .touchUpInside)
     //  cell.button.addTarget(self, action: "addButtonPressed", for: .touchUpInside)
         //print(cell.button.tag)
        
        
        
        
        return cell
    }
    
   @objc func addButtonPressed(sender: UIButton) {
        let buttonTag = sender.tag
        //print(buttonTag)
       // print(self.currentFriendArray[buttonTag].id)
        //print("Hey")
    
    /*
    let idUser = UserDefaults.standard.string(forKey: "Saveid")
    // let userId = String(describing:idUser)
    
   // print(idUser!)
    
    let userId = Int(idUser!)
    
    //print(userId!)
    */
    /*
    let parameters = ["idU": self.userId,
                      "idInvite": self.FriendArray[buttonTag].id]
    /*
    let parameters = ["IdU": "90",
                      "IdInvite": "92"] as [String : String]
    */
    Service.sharedInstance.loadInvitation(parameters:parameters as! [String : String], url:urlverifInvitation) { (state, Objets) in
        if state {
           self.invitations = Objets!
            print("Invitation envoyé")
            
            // Display Alert message and return
            self.displayMessage(userMessage: "déjà invité")
            return

        }
        else
        {
            print("Invitation n'existe pas")
            
            
            let paras = ["idU": self.userId,
                         "idInvite": self.currentFriendArray[buttonTag].id,
                         "EtatInvitation" : "En attente",
                         "Moyen": "FriendsGo"
                ] as [String : Any]
            
            
            Service.sharedInstance.postItAny(parameters:paras, url:self.urlInvitationFG)
            
            
            
        }
    }
    */
    
    let paras = ["idU": userId,
                 "idInvite": self.currentFriendArray[buttonTag].id,
                 "EtatInvitation" : "En attente",
                 "Moyen": "FriendsGo"
        ] as [String : Any]
    
    
    Service.sharedInstance.postItAny(parameters:paras, url:self.urlInvitationFG)
  
    
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    // This two functions can be used if you want to show the search bar in the section header
    //    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    //        return searchBar
    //    }
    
    //    // search bar in section header
    //    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    //        return UITableViewAutomaticDimension
    //    }
    
    // Search Bar
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        currentFriendArray = FriendArray.filter({ friend -> Bool in
            switch searchBar.selectedScopeButtonIndex {
            case 0:
                if searchText.isEmpty { searching = true }
                return (friend.Nom+" "+friend.prenom).lowercased().contains(searchText.lowercased())
            default:
              // currentFriendArray = FriendsEmpty
                return searching == false
            }
        })
        table.reloadData()
        
        
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
                let alertController = UIAlertController(title: "Alerte", message: userMessage, preferredStyle: .alert)
                
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





