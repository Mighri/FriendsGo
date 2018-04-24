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
    @IBOutlet var lieuEvent: UILabel!
    var event: Event!
    var friend: Friend!
    let urlGetUsername = MyClass.Constants.urlGetUsername
    
    
    @IBOutlet weak var mapView: MKMapView!
    var matchingItems: [MKMapItem] = [MKMapItem]()
    
    
    override func viewDidLoad() {
        descEvent.text = event.descriptif
        dateEvent.text = event.date
        heureEvent.text = event.heure
         lieuEvent.text = event.adresse
        //proprietaireEvent.text = event.IdU
        // participationEvent.text =
        //imageEvent.image = event.image
        
        
        
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
        
    }
    
    
    @IBAction func newPopUp(_ sender: AnyObject) {
        let popOverVC = UIStoryboard(name: "MWAPopup", bundle: nil).instantiateViewController(withIdentifier: "ParticipationPopUp") as! ParticipationPopUp
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
        
    }
    
}

