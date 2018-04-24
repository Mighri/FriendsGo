//
//  AnEventViewController.swift
//  FriendsGo
//
//  Created by Radhia Mighri on 16/04/2018.
//  Copyright © 2018 Radhia Mighri. All rights reserved.
//

import UIKit
import MapKit

class AnEventViewController: UIViewController {
    
    @IBOutlet var descEvent: UILabel!
     @IBOutlet var dateEvent: UILabel!
     @IBOutlet var heureEvent: UILabel!
     @IBOutlet var proprietaireEvent: UILabel!
     @IBOutlet var participationEvent: UILabel!
     @IBOutlet var imageEvent: UIImageView!
        @IBOutlet weak  var InvitedFriendsButton: UIButton!
     var event: Event!
     var friend: Friend!
    let urlGetUsername = MyClass.Constants.urlGetUsername
    
    
    @IBOutlet weak var mapView: MKMapView!
    var matchingItems: [MKMapItem] = [MKMapItem]()
    
    
    override func viewDidLoad() {
        descEvent.text = event.descriptif
        dateEvent.text = event.date
            heureEvent.text = event.heure
       //proprietaireEvent.text = event.IdU
       // participationEvent.text =
        //imageEvent.image = event.image
        
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        
        self.showAnimate()
        
        let p = ["IdU" : event.IdU] as [String : Any]
        
        Service.sharedInstance.loadInfoAny(parameters: p, url: urlGetUsername) { (state, Objets) in
            if state {
                self.friend = Objets![0]
                self.proprietaireEvent.text = self.friend.Nom + " "+self.friend.prenom
                print("Objets")
            } else {
                print("nooo")
            }
            
        }
        
        
        let imagedecoded = Data(base64Encoded: event.image, options: Data.Base64DecodingOptions.ignoreUnknownCharacters)!
        imageEvent.image = UIImage(data: imagedecoded)!
   
    
        mapView.removeAnnotations(mapView.annotations)
        self.performSearch()
        
        
        InvitedFriendsButton.layer.cornerRadius = 20
        InvitedFriendsButton.clipsToBounds = true
    
    }
    
    
    @IBAction func newPopUp(_ sender: AnyObject) {
      
        let popOverVC = UIStoryboard(name: "MWAPopup", bundle: nil).instantiateViewController(withIdentifier: "PopAnEvent") as! PopAnEvent
        popOverVC.event = event
        self.addChildViewController(popOverVC)
        //popOverVC.view.frame = self.view.frame
        self.view.addSubview(popOverVC.view)
       popOverVC.didMove(toParentViewController: self)
        //popOverVC.show(vc: self)
 
    }
    
    @IBAction func back(_ sender: UIButton) {
        
        print("%%%%%%%%%%%%%%%%%%%%")
        let mystoryboard:UIStoryboard = UIStoryboard(name:"Menu", bundle: nil)
        
        let ViewController = mystoryboard.instantiateViewController(withIdentifier: "MyEventsViewController") as! MyEventsViewController
        
        //self.present(ViewController, animated: true, completion: nil)
       self.navigationController?.pushViewController(ViewController, animated: true)
 
    }
    
    func performSearch() {
        
        matchingItems.removeAll()
        let request = MKLocalSearchRequest()
        request.naturalLanguageQuery = event.adresse
        request.region = mapView.region
        
        let search = MKLocalSearch(request: request)
        
        search.start(completionHandler: {(response, error) in
            
            if error != nil {
                print("Error occured in search: \(error!.localizedDescription)")
            } else if response!.mapItems.count == 0 {
                print("No matches found")
            } else {
                print("Matches found")
                
                for item in response!.mapItems {
                    print("Name = \(item.name)")
                    print("Phone = \(item.phoneNumber)")
                    
                    self.matchingItems.append(item as MKMapItem)
                    print("Matching items = \(self.matchingItems.count)")
                    
                    let annotation = MKPointAnnotation()
                    annotation.coordinate = item.placemark.coordinate
                    annotation.title = item.name
                    self.mapView.addAnnotation(annotation)
                    
                    
                }
            }
        })
    }
    
    
    
    @IBAction func InvitedFriends(_ sender: UIButton) {
        
        
        print("********************************************")
        
        
        
        
        
        let mystoryboard:UIStoryboard = UIStoryboard(name:"Menu", bundle: nil)
        
        let ViewController = mystoryboard.instantiateViewController(withIdentifier: "InviteFriendsController") as! InviteFriendsController
        
        self.navigationController?.pushViewController(ViewController, animated: true)
        
         //self.navigationController?.navigationBar.backItem?.title = "Les invités"
        
        //self.navigationController?.navigationBarHidden = true;

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
     */
    
    
    
    
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
}
