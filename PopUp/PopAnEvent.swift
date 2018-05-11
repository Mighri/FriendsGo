//
//  PopAnEvent.swift
//  FriendsGo
//
//  Created by Radhia Mighri on 17/04/2018.
//  Copyright © 2018 Radhia Mighri. All rights reserved.
//

import Foundation
import UIKit

class PopAnEvent: UIViewController {
    @IBOutlet weak  var inviteFriendButton: UIButton!
    @IBOutlet weak  var updateEventButton: UIButton!
    @IBOutlet weak  var deleteEventButton: UIButton!
     var event: Event!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        
        self.showAnimate()
        
        
        
        inviteFriendButton.layer.cornerRadius = 40
        inviteFriendButton.clipsToBounds = true
        
        
        updateEventButton.layer.cornerRadius = 40
        updateEventButton.clipsToBounds = true
        
        deleteEventButton.layer.cornerRadius = 40
        deleteEventButton.clipsToBounds = true
    }
    
    
    @IBAction func updateEvent(_ sender: AnyObject) {
        
        let popOverVC = UIStoryboard(name: "MWAPopup", bundle: nil).instantiateViewController(withIdentifier: "UpdateEvent") as! UpdateEvent
        popOverVC.event = event
        self.addChildViewController(popOverVC)
        //popOverVC.view.frame = self.view.frame
         self.view.addSubview(popOverVC.view)
        popOverVC.didMove(toParentViewController: self)
        
    }
    
    
    @IBAction func inviteFriend(_ sender: AnyObject) {
  /*
        let popOverVC = UIStoryboard(name: "Menu", bundle: nil).instantiateViewController(withIdentifier: "InviteForEventController") as! InviteForEventController
        popOverVC.event = event
        self.addChildViewController(popOverVC)
        //popOverVC.view.frame = self.view.frame
        self.view.addSubview(popOverVC.view)
        popOverVC.didMove(toParentViewController: self)

 
 */
        
     
        let mystoryboard:UIStoryboard = UIStoryboard(name:"Menu", bundle: nil)
        
        let ViewController = mystoryboard.instantiateViewController(withIdentifier: "InviteForEventController") as! InviteForEventController
          ViewController.event = event
     //self.present(ViewController, animated: true, completion: nil)
     self.navigationController?.pushViewController(ViewController, animated: true)
 
    }
    
    @IBAction func deleteEvent(_ sender: AnyObject) {
        //createTwoButtonCustomPopup()
      
        let popOverVC = UIStoryboard(name: "MWAPopup", bundle: nil).instantiateViewController(withIdentifier: "DeleteEventPopUp") as! DeleteEventPopUp
        popOverVC.event = event
        self.addChildViewController(popOverVC)
        //popOverVC.view.frame = self.view.frame
        self.view.addSubview(popOverVC.view)
      popOverVC.didMove(toParentViewController: self)
       // popOverVC.show(vc: self.navigationController!)
      
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
    
    
    /*
     func createEventCustomPopup() {
     
     let popup = File.createPopup(aPopupType: .pop)
     popup?.show(vc: self.navigationController!)
     //popup?.show(vc: self)
     
     popup?.onFirstButtonTapped = { () in
     }
     popup?.onSecondButtonTapped = { () in
     print("Cancel Tapped")
     }
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
            
            
            let mystoryboard:UIStoryboard = UIStoryboard(name:"Menu", bundle: nil)
            
            let ViewController = mystoryboard.instantiateViewController(withIdentifier: "EventViewController") as! EventViewController
            
            
            self.navigationController?.pushViewController(ViewController, animated: true)
            
            
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
        
        popup?.textFieldPlaceholder = "N° de téléphone"
        
        popup?.textFieldPlaceholderColor = .white
        popup?.textFieldPlaceholderFont = UIFont.boldSystemFont(ofSize: 11)
        popup?.show(vc: self.navigationController!)
        //popup?.show(vc: self)
        
        popup?.onFirstButtonTapped = { () in
            print("Entered Information::" + (popup?.textField.text)!)
            
            if (popup?.textField.text!.isPhone())!
            {
                let tagg = UserDefaults.standard.string(forKey: "ag")
                print(tagg!)
                let parameters = ["idU": tagg!,
                                  "telephone": popup?.textField.text!]
                
                //Service.sharedInstance.postIt(parameters:parameters as! [String : String], url:self.urlAddTelephoneContact)
            }
            
        }
        popup?.onSecondButtonTapped = { () in
            print("Cancel Tapped")
        }
    }
     */
    
}
