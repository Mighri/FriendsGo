//
//  ListContactsViewController.swift
//  FriendsGo
//
//  Created by Radhia Mighri on 23/03/2018.
//  Copyright © 2018 Radhia Mighri. All rights reserved.
//

import UIKit
import SDWebImage

class ListContactsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    @IBOutlet var table: UITableView!
    @IBOutlet var searchBar: UISearchBar!
    var friend : Friend!
    var FriendArray = [Friend]()
    var currentFriendArray = [Friend]() //update table
    let urlgetContacts = MyClass.Constants.urlgetContacts
    let userId = UserDefaults.standard.string(forKey: "Saveid")!
    var searching: Bool! = false
    let urlDeleteContact = MyClass.Constants.urlDeleteContact
    let urlAddTelephoneContact = MyClass.Constants.urlAddTelephoneContact
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpFriends()
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
       // searchBar.showsCancelButton = true
    }
    /*
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searching = false
        searchBar.endEditing(true)
        //searchBar.showsCancelButton = false
    }
 */
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searching = false
        searchBar.endEditing(true)
        //searchBar.showsCancelButton = false
    }
    private func setUpFriends() {

        let p = ["idU" : userId]
        
        Service.sharedInstance.loadInfoAny(parameters: p, url: urlgetContacts) { (state, Objets) in
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
        
       let cell = self.table.dequeueReusableCell(withIdentifier: "Cell") as! TableCell
        
        cell.Nom.text = currentFriendArray[indexPath.row].Nom+" "+currentFriendArray[indexPath.row].prenom
        
        cell.imageUrl.sd_setImage(with: URL(string: self.currentFriendArray[indexPath.row].photoURL), placeholderImage: UIImage(named: "profile"))
        
        //cell.iconimage.image = UIImage(named: "logo-facebook")
        
        
        if(self.currentFriendArray[indexPath.row].origine == "Facebook")
        {
            cell.iconimage.image = UIImage(named: "fb-icon")
        }
        else if(self.currentFriendArray[indexPath.row].origine == "Google")
        {
            cell.iconimage.image = UIImage(named: "Google-icon")
        }
        
        print(self.currentFriendArray[indexPath.row].telephone)

        if(self.currentFriendArray[indexPath.row].telephone == "NULL")
        {
           print("No Phone number")
        }
        else
        {
            cell.iconimage2.image = UIImage(named: "phone-icon")
            UserDefaults.standard.set(self.currentFriendArray[indexPath.row].telephone, forKey: "telContact")
        }

        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        print(self.currentFriendArray[indexPath.row].idS)
        UserDefaults.standard.set(self.currentFriendArray[indexPath.row].idS, forKey: "ag")
        
        createTwoButtonCustomPopup()
    }

    @objc func suppContact()
    {
     let tagg = UserDefaults.standard.string(forKey: "ag")
        print(tagg!)
     let parameters = ["idU": tagg!]
     
        Service.sharedInstance.postIt(parameters:parameters, url:self.urlDeleteContact)

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
 
    func createTwoButtonHeadCustomPopup() {
        
        let popup = MWAPopup.createPopup(aPopupType: .TwoButtonsHead, titleString: "Êtes-vous sûr?", messageString: "Supprimer ce contact!", buttonNames: ["Non!", "Oui!"])
        
        popup?.titleTextFont = UIFont.systemFont(ofSize: 22)
        popup?.titleTextColor = .black
        
        popup?.messageTextFont = UIFont.boldSystemFont(ofSize: 16)
        popup?.messageTextColor = .black
        popup?.show(vc: self.navigationController!)
        //popup?.show(vc: self)
        popup?.onFirstButtonTapped = { () in
            print("Yes Tapped")
            
            self.suppContact()
            self.createSingleButtonCustomPopup()
        }
        popup?.onSecondButtonTapped = { () in
            print("No Tapped")
        }
    }
    
    
    func createTwoButtonCustomPopup() {
        let popup = MWAPopupC.createPopupWithout(aPopupType: .TwoButtons, buttonNames: ["Ajouter un numéro de               téléphone", "Supprimer"])
       
        popup?.show(vc: self.navigationController!)
        //popup?.show(vc: self)
        // button Supprimer
        popup?.onFirstButtonTapped = { () in
            print("Yes Tapped")
           // self.createSingleButtonCustomPopup()
            self.createTwoButtonHeadCustomPopup()
        }
        // Button ajouter n° de contact
        popup?.onSecondButtonTapped = { () in
            print("No Tapped")
            self.createSingleTextfieldCustomPopup()
        }
    }
    
    func createSingleButtonCustomPopup() {
        
        let popup = MWAPopup.createPopup(aPopupType: .SingleButton, titleString: "Supprimé!", messageString: "Votre contact a été supprimé!", buttonNames: ["OK"])
        
        popup?.titleTextFont = UIFont.systemFont(ofSize: 22)
        popup?.titleTextColor = .black
        
        popup?.messageTextFont = UIFont.boldSystemFont(ofSize: 16)
        popup?.messageTextColor = .black
         popup?.show(vc: self.navigationController!)
        //popup?.show(vc: self)
        popup?.onFirstButtonTapped = { () in
            print("OK Tapped")
        }
    
    }
    
    func createSingleTextfieldCustomPopup() {
        
        let popup = MWAPopup.createPopup(aPopupType: .TextFieldTwoButtons, titleString: " ", messageString: "Numéro de téléphone", buttonNames: ["OK", "Annuler"])
        
        popup?.titleTextFont = UIFont.systemFont(ofSize: 22)
        popup?.titleTextColor = .black
        
        popup?.messageTextFont = UIFont.boldSystemFont(ofSize: 16)
        popup?.messageTextColor = .black
        
        popup?.setTextFieldBorderStyle(style: .none)
        
        //  popup?.textFieldBackgroundImage = UIImage(named: "textfield_bg")
        popup?.textFieldBackgroundColor = UIColor(hex: "414141")
        
        popup?.textFieldTextColor = .white
        popup?.textFieldTextFont = UIFont.systemFont(ofSize: 12)
       
        let telContact = UserDefaults.standard.string(forKey: "telContact")
        
        if (telContact  != "NULL")
        {
            popup?.textFieldPlaceholder = telContact
        }
        else
        {
             popup?.textFieldPlaceholder = "N° de téléphone"
        }
       
        
        popup?.textFieldPlaceholderColor = .white
        popup?.textFieldPlaceholderFont = UIFont.boldSystemFont(ofSize: 11)
        popup?.show(vc: self.navigationController!)
        //popup?.show(vc: self)
       
        popup?.onFirstButtonTapped = { () in
            print("Entered Information::" + (popup?.textField.text)!)
          
            if ((popup?.textField.text!.isPhone())! || (telContact?.isPhone())!)
            {
                let tagg = UserDefaults.standard.string(forKey: "ag")
                print(tagg!)
                let parameters = ["idU": tagg!,
                                  "telephone": popup?.textField.text!]
                
                Service.sharedInstance.postIt(parameters:parameters as! [String : String], url:self.urlAddTelephoneContact)
            }
            else {
                 self.displayMessage(userMessage: "N° téléphone invalide")
                 return
              
            }
        }
        popup?.onSecondButtonTapped = { () in
            print("Cancel Tapped")
        }
    }

    func displayMessage(userMessage:String) -> Void {
        DispatchQueue.main.async
            {
                let alertController = UIAlertController(title: "Erreur", message: userMessage, preferredStyle: .alert)
                
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


extension String {
    
    public func isPhone()->Bool {
        if self.isAllDigits() == true {
            let phoneRegex = "[235689][0-9]([0-9]{3})?[0-9]{6}"
            let predicate = NSPredicate(format: "SELF MATCHES %@", phoneRegex)
            return  predicate.evaluate(with: self)
        }else {
            return false
        }
    }
    
    private func isAllDigits()->Bool {
        let charcterSet  = NSCharacterSet(charactersIn: "+0123456789").inverted
        let inputString = self.components(separatedBy: charcterSet)
        let filtered = inputString.joined(separator: "")
        return  self == filtered
    }
}


