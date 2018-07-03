//
//  AnInvitationEventController.swift
//  FriendsGo
//
//  Created by Radhia Mighri on 18/04/2018.
//  Copyright © 2018 Radhia Mighri. All rights reserved.
//

import UIKit
import MapKit

class AnInvitationEventController: UIViewController {
 
    @IBOutlet var descEvent: UILabel!
 
    @IBOutlet var dateEvent: UILabel!
    @IBOutlet var heureEvent: UILabel!
    @IBOutlet var proprietaireEvent: UILabel!
    @IBOutlet var participationEvent: UILabel!
    @IBOutlet var imageEvent: UIImageView!
    @IBOutlet var participEvent: UIImageView!
    @IBOutlet var lieuEvent: UILabel!
    
    let userId = UserDefaults.standard.string(forKey: "Saveid")!
    var event: Event!
    var friend: Friend!
    var invitEvent: InvitationEventFG!

    let urlGetUsername = MyClass.Constants.urlGetUsername
    let urlInvEventFG = MyClass.Constants.urlInvEventFG
    
     //var invitEvent = InvitationEventFG!

    
    @IBOutlet weak var mapView: MKMapView!
    var matchingItems: [MKMapItem] = [MKMapItem]()
    
    
    override func viewDidLoad() {
        descEvent.text = event.descriptif
        dateEvent.text = event.date
        heureEvent.text = event.heure
        lieuEvent.text = event.adresse
        imageEvent.sd_setImage(with: URL(string: event.image), placeholderImage: nil)
        
        let pr = ["IdInvitedd" : self.userId,
                  "eventtt" : event.idE!]
        
        Service.sharedInstance.loadInvitationEvent(parameters: pr, url: urlInvEventFG) { (state, Objets) in
            if state {
                self.invitEvent = Objets![0]
  
                if ( self.invitEvent.Etat == "Intéressé")
                {
                    self.participEvent.image = #imageLiteral(resourceName: "starP")
                    self.participationEvent.text = "Intéressé(e)"
                }
                else if (self.invitEvent.Etat == "Participe")
                {
                    self.participEvent.image = #imageLiteral(resourceName: "Check")
                    self.participationEvent.text = "Participe"
                }
                else if (self.invitEvent.Etat == "Ne participe pas")
                {
                    self.participEvent.image = #imageLiteral(resourceName: "cross")
                    self.participationEvent.text = "Ne participe pas"
                }
                
                print("Invitation Event FG")
            } else {
                print("no Invitation Event FG")
            }
        }
        
        
        let p = ["IdU" : event.IdU!]
        
        Service.sharedInstance.loadInfoAny(parameters: p, url: urlGetUsername) { (state, Objets) in
            if state {
                self.friend = Objets![0]
                self.proprietaireEvent.text = self.friend.Nom + " "+self.friend.prenom
                print("Objets")
            } else {
                print("nooo")
            }
        }
        
        
        mapView.removeAnnotations(mapView.annotations)
        self.performSearch()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Hide the navigation bar on the this view controller
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // Show the navigation bar on other view controllers
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
 
    @IBAction func back(_ sender: UIButton) {
        
        let mystoryboard:UIStoryboard = UIStoryboard(name:"Menu", bundle: nil)
        
        let ViewController = mystoryboard.instantiateViewController(withIdentifier: "EventViewController") as! EventViewController
        
        self.navigationController?.pushViewController(ViewController, animated: true)
    }
    
    @IBAction func newPopUp(_ sender: AnyObject) {
        let popOverVC = UIStoryboard(name: "MWAPopup", bundle: nil).instantiateViewController(withIdentifier: "ParticipationPopUp") as! ParticipationPopUp
        popOverVC.event = event
        
        self.addChildViewController(popOverVC)
        //popOverVC.view.frame = self.view.frame
        self.view.addSubview(popOverVC.view)
        // popOverVC.didMove(toParentViewController: self)
        popOverVC.show(vc: self.navigationController!)
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

    @IBAction func googleMaps(_ sender: UIButton) {
        
        let mystoryboard:UIStoryboard = UIStoryboard(name:"Menu", bundle: nil)
        
        let ViewController = mystoryboard.instantiateViewController(withIdentifier: "WebviewViewController") as! WebviewViewController
        self.navigationController?.pushViewController(ViewController, animated: true)
    }
    
}

