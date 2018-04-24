//
//  LeftViewController.swift
//  FriendsGo
//
//  Created by Radhia Mighri on 03/03/2018.
//  Copyright © 2018 Radhia Mighri. All rights reserved.
//

import UIKit
import SDWebImage

enum LeftMenu: Int {
    case Importer = 0
    case Contacts
    case Evénements
    case Map
    case Messages
    case Notifications
    case Invitations
    case Paramètres
    
}

protocol LeftMenuProtocol : class {
    func changeViewController(_ menu: LeftMenu)
}

class LeftViewController : UIViewController, LeftMenuProtocol {
    
    @IBOutlet weak var tableView: UITableView!
    var menus = ["Importer Contacts", "Contacts", "Evénements", "Map", "Messages", "Notifications", "Invitations", "Paramètres"]
    var mainViewController: UIViewController!
    var ContactViewController: UIViewController!
    var EventViewController: UIViewController!
    var MapViewController: UIViewController!
    var nonMenuViewController: UIViewController!
    var NotificationViewController: UIViewController!
    var InvitationViewController: UIViewController!
    var MessageViewController: UIViewController!
    var ImportViewController: UIViewController!
    var ParametersViewController: UIViewController!
    var imageHeaderView: ImageHeaderView!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
         self.tableView.separatorColor = UIColor(red: 224/255, green: 224/255, blue: 224/255, alpha: 1.0)
        
        let storyboard = UIStoryboard(name: "Menu", bundle: nil)

        
        let ContactViewController = storyboard.instantiateViewController(withIdentifier: "contact") as! ContactViewController
        self.ContactViewController = UINavigationController(rootViewController: ContactViewController)
        
        let NotificationViewController = storyboard.instantiateViewController(withIdentifier: "notification") as! NotificationViewController
        self.NotificationViewController = UINavigationController(rootViewController: NotificationViewController)
        
        let InvitationViewController = storyboard.instantiateViewController(withIdentifier: "InvitationViewController") as! InvitationViewController
        self.InvitationViewController = UINavigationController(rootViewController: InvitationViewController)
        
        
        let EventViewController = storyboard.instantiateViewController(withIdentifier: "EventViewController") as! EventViewController
        self.EventViewController = UINavigationController(rootViewController: EventViewController)
        
        let MapViewController = storyboard.instantiateViewController(withIdentifier: "MapViewController") as! MapViewController
        self.MapViewController = UINavigationController(rootViewController: MapViewController)
        
        let MessageViewController = storyboard.instantiateViewController(withIdentifier: "MessageViewController") as! MessageViewController
        self.MessageViewController = UINavigationController(rootViewController: MessageViewController)
        
        let ImportViewController = storyboard.instantiateViewController(withIdentifier: "ImportViewController") as! ImportViewController
        self.ImportViewController = UINavigationController(rootViewController: ImportViewController)
        
        
        let ParametersViewController = storyboard.instantiateViewController(withIdentifier: "ParametersViewController") as! ParametersViewController
        self.ParametersViewController = UINavigationController(rootViewController: ParametersViewController)
        
        
        
        self.tableView.registerCellNib(DataTableViewCell.self)
       // self.tableView.registerCellClass(BaseTableViewCell.self)
       // self.imageHeaderView.Nom.text = "Radhia"
        
        
        /*
        let imageHeaderView = tableView.dequeueReusableCell(withIdentifier: "ImageHeaderView") as! UITableViewCell

        imageHeaderView.Nom.text = "Radhia"
        imageHeaderView.profileImage.sd_setImage(with: URL(string: ""), placeholderImage: nil)
        
        */
        
       //self.imageHeaderView.Nom.text = "mm"
        
         self.imageHeaderView = ImageHeaderView.loadNib()
        self.view.addSubview(self.imageHeaderView)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.imageHeaderView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 160)
        self.view.layoutIfNeeded()
    }
    
    func changeViewController(_ menu: LeftMenu) {
        switch menu {
        case .Importer:
            self.slideMenuController()?.changeMainViewController(self.ImportViewController, close: true)
        case .Contacts:
            self.slideMenuController()?.changeMainViewController(self.ContactViewController, close: true)
        case .Evénements:
            self.slideMenuController()?.changeMainViewController(self.EventViewController, close: true)
        case .Map:
            self.slideMenuController()?.changeMainViewController(self.MapViewController, close: true)
        case .Messages:
            self.slideMenuController()?.changeMainViewController(self.MessageViewController, close: true)
        case .Notifications:
            self.slideMenuController()?.changeMainViewController(self.NotificationViewController, close: true)
        case .Invitations:
            self.slideMenuController()?.changeMainViewController(self.InvitationViewController, close: true)
        case .Paramètres:
            self.slideMenuController()?.changeMainViewController(self.ParametersViewController, close: true)
        }
    }
}

extension LeftViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if let menu = LeftMenu(rawValue: indexPath.row) {
            switch menu {
            case .Importer, .Contacts, .Evénements, .Map, .Messages, .Notifications, .Invitations, .Paramètres:
                return BaseTableViewCell.height()
            }
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let menu = LeftMenu(rawValue: indexPath.row) {
            self.changeViewController(menu)
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if self.tableView == scrollView {
            
        }
    }
}

extension LeftViewController : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menus.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = self.tableView.dequeueReusableCell(withIdentifier: DataTableViewCell.identifier) as! DataTableViewCell
        
        if let menu = LeftMenu(rawValue: indexPath.row) {
            switch menu {
                case .Importer:
           // case .main, .swift, .java, .go, .nonMenu:
                cell.dataImage.image = UIImage(named: "import")
                 cell.dataText.text = self.menus[indexPath.row]
                return cell
                 case .Contacts:
                    cell.dataImage.image = UIImage(named: "contact")
                    cell.dataText.text = self.menus[indexPath.row]
                    return cell
            case .Evénements:
                cell.dataImage.image = UIImage(named: "evenement")
                cell.dataText.text = self.menus[indexPath.row]
                return cell
                case .Map:
                    cell.dataImage.image = UIImage(named: "map")
                    cell.dataText.text = self.menus[indexPath.row]
                    return cell
                case .Messages:
                        cell.dataImage.image = UIImage(named: "message")
                        cell.dataText.text = self.menus[indexPath.row]
                 /*
                cell.dataImage.sd_setImage(with: URL(string: imagesURL[indexPath.row]), placeholderImage: nil)
           cell.dataText.text = self.menus[indexPath.row]
             
                let data = DataTableViewCellData(imageUrl: imagesURL[indexPath.row], text: menus[indexPath.row])
                cell.setData(data)
*/
                  return cell
            case .Notifications:
                cell.dataImage.image = UIImage(named: "notification")
                cell.dataText.text = self.menus[indexPath.row]
                 cell.number.text = " "
                return cell
            case .Invitations:
                cell.dataImage.image = UIImage(named: "invitation")
                cell.dataText.text = self.menus[indexPath.row]
               let nbInvitation = UserDefaults.standard.integer(forKey: "nbreInv")
                let nbInv = String(describing:nbInvitation)
                cell.number.text = nbInv
                return cell
                
            case .Paramètres:
                cell.dataImage.image = UIImage(named: "settings")
                cell.dataText.text = self.menus[indexPath.row]
                return cell
            }
        }
     return UITableViewCell()
    }
}

