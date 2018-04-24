//
//  InvAmisController.swift
//  FriendsGo
//
//  Created by Radhia Mighri on 18/04/2018.
//  Copyright © 2018 Radhia Mighri. All rights reserved.
//

import Foundation
import UIKit

class InvAmisController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate , UINavigationControllerDelegate {
    @IBOutlet var table: UITableView!
    @IBOutlet var searchBar: UISearchBar!
    
    @IBOutlet var imageEvent: UIImageView!
    @IBOutlet var titreEvent: UILabel!
    @IBOutlet var adresseEvent: UILabel!
    
    var friend : Friend!
    var FriendArray = [Friend]()
    var currentFriendArray = [Friend]() //update table
    let urlgetAmis = MyClass.Constants.urlgetAmis
    var searching: Bool! = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpFriends()
        setUpSearchBar()
        alterLayout()
        searchBar.showsCancelButton = false
        
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        
        self.showAnimate()
        
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
        
        let cell = self.table.dequeueReusableCell(withIdentifier: "InvitationEventCell") as! InvitationEventCell
        
        cell.nomAmis.text = currentFriendArray[indexPath.row].Nom+" "+currentFriendArray[indexPath.row].prenom
        
        //cell.Prenom.text = currentFriendArray[indexPath.row].prenom
        /*
        cell.imageUrl.sd_setImage(with: URL(string: self.currentFriendArray[indexPath.row].photoURL), placeholderImage: UIImage(named: "profile"))
        
        cell.iconimage.image = UIImage(named: "FriendsGo")
        */
        return cell
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
                return searching == false
            }
        })
        table.reloadData()
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
    
}



