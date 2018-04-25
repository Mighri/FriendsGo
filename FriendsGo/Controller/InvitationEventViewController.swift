//
//  InvitationEventViewController.swift
//  FriendsGo
//
//  Created by Radhia Mighri on 04/04/2018.
//  Copyright © 2018 Radhia Mighri. All rights reserved.
//

import UIKit

class InvitationEventViewController : UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    
    @IBOutlet var table: UITableView!
    @IBOutlet var searchBar: UISearchBar!
    var event : Event!
    var eventArray = [Event]()
    var currentEventArray = [Event]() //update table
    //let urlgetAmis = MyClass.Constants.urlgetAmis
    var searching: Bool! = false
    
    let urlGetInvEvent = MyClass.Constants.urlGetInvEvent
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpEvents()
        setUpSearchBar()
        alterLayout()
        //searchBar.showsCancelButton = false
    }
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searching = false
        searchBar.endEditing(true)
        //searchBar.showsCancelButton = false
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searching = true
        //searchBar.showsCancelButton = true
    }
    /*
     func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
     searching = false
     searchBar.endEditing(true)
     searchBar.showsCancelButton = false
     }
     */
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searching = false
        searchBar.endEditing(true)
        //searchBar.showsCancelButton = false
    }
    
    private func setUpEvents() {
        
        
        let userId = UserDefaults.standard.string(forKey: "Saveid")
        print(userId!)
        let p = ["IdInvited" : userId!] as [String : Any]
        
        Service.sharedInstance.loadEvent(parameters: p as [String : Any], url: urlGetInvEvent) { (state, Objets) in
            if state {
                self.eventArray = Objets!
                self.currentEventArray = self.eventArray
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
        
        if currentEventArray != nil, currentEventArray.count > 0
        {
            return currentEventArray.count
        }
        return currentEventArray.count
        
        //return currentFriendArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = self.table.dequeueReusableCell(withIdentifier: "EventCell") as! EventCell
        
        cell.titre.text = currentEventArray[indexPath.row].titre
        
        cell.date.text = currentEventArray[indexPath.row].date
        
        cell.heure.text = currentEventArray[indexPath.row].heure
        cell.adresse.text = currentEventArray[indexPath.row].adresse
        
        //print(currentEventArray[indexPath.row].image)
        
        let dataDecoded : Data = Data(base64Encoded: currentEventArray[indexPath.row].image, options: Data.Base64DecodingOptions.ignoreUnknownCharacters)!
        
        cell.imageEvent.image = UIImage(data: dataDecoded)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 135
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        /*
         let popOverVC = UIStoryboard(name: "MWAPopup", bundle: nil).instantiateViewController(withIdentifier: "pop") as! MWAPopupEventM
         self.addChildViewController(popOverVC)
         //popOverVC.view.frame = self.view.frame
         self.view.addSubview(popOverVC.view)
         // popOverVC.didMove(toParentViewController: self)
         popOverVC.show(vc: self.navigationController!)
         */
        
        let mystoryboard:UIStoryboard = UIStoryboard(name:"Menu", bundle: nil)
        
        let ViewController = mystoryboard.instantiateViewController(withIdentifier: "AnInvitationEventController") as! AnInvitationEventController
        
        ViewController.event = currentEventArray[indexPath.row]
        
        self.navigationController?.pushViewController(ViewController, animated: true)
        
        
        //  createEventCustomPopup()
        
    }
    
    // Search Bar
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        currentEventArray = eventArray.filter({ event -> Bool in
            switch searchBar.selectedScopeButtonIndex {
            case 0:
                if searchText.isEmpty { searching = true }
                return (event.titre+" "+event.descriptif).lowercased().contains(searchText.lowercased())
            default:
                return searching == false
            }
        })
        table.reloadData()
    }
    
    
    @IBAction func addEventt(_ sender: Any) {
        //createAddEventCustomPopup()
        
        
        let popOverVC = UIStoryboard(name: "MWAPopup", bundle: nil).instantiateViewController(withIdentifier: "pop") as! MWAPopupEventM
        self.addChildViewController(popOverVC)
        //popOverVC.view.frame = self.view.frame
        self.view.addSubview(popOverVC.view)
        // popOverVC.didMove(toParentViewController: self)
        popOverVC.show(vc: self.navigationController!)
        
    }
    
    
    func createAddEventCustomPopup() {
        
        let popup = MWAPopupAddEvent.createPopup(aPopupType: .addEventView, titleString: " ", messageString: " ", buttonNames: ["Annuler", "Enregistrer"])
        
        popup?.titleTextFont = UIFont.systemFont(ofSize: 22)
        popup?.titleTextColor = .black
        
        popup?.messageTextFont = UIFont.boldSystemFont(ofSize: 16)
        popup?.messageTextColor = .black
        
        popup?.setTextFieldBorderStyle(style: .none)
        
        //  popup?.textFieldBackgroundImage = UIImage(named: "textfield_bg")
        popup?.textFieldBackgroundColor = UIColor(hex: "414141")
        
        popup?.textFieldTextColor = .white
        popup?.textFieldTextFont = UIFont.systemFont(ofSize: 12)
        
        popup?.textFieldPlaceholder = "N° de téléphone"
        
        popup?.textFieldPlaceholderColor = .white
        popup?.textFieldPlaceholderFont = UIFont.boldSystemFont(ofSize: 11)
        popup?.show(vc: self.navigationController!)
        //popup?.show(vc: self)
        
        popup?.onFirstButtonTapped = { () in
            
        }
        popup?.onSecondButtonTapped = { () in
            print("Cancel Tapped")
        }
    }
}













