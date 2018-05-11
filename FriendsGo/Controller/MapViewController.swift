//
//  MapViewController.swift
//  FriendsGo
//
//  Created by Radhia Mighri on 03/03/2018.
//  Copyright © 2018 Radhia Mighri. All rights reserved.

import UIKit
import GoogleMaps
import GooglePlaces
import MapKit
import CoreLocation

class MapViewController: UIViewController, GMSMapViewDelegate {
    
    var positions = [Position]()
    
    let urlAddPosition = MyClass.Constants.urlAddPosition
     let urlGetPosition = MyClass.Constants.urlGetPosition
    let urlUpdatePosition = MyClass.Constants.urlUpdatePosition
    let userId = UserDefaults.standard.string(forKey: "Saveid")
    
    let coords = [  CLLocation(latitude: 35.8200481161809, longitude: 10.5920922663161),
                    CLLocation(latitude: 36.8200481161809, longitude: 11.5920922663161),
                    CLLocation(latitude: 37.8200481161809, longitude:10.992098663161)
    ];
    
    
    var locationManager = CLLocationManager()
    var currentLocation: CLLocation?
    var mapView: GMSMapView!
    var placesClient: GMSPlacesClient!
    var zoomLevel: Float = 15.0
    
    var london: GMSMarker?
    var londonView: UIImageView?
    
    // An array to hold the list of likely places.
    var likelyPlaces: [GMSPlace] = []
    
    // The currently selected place.
    var selectedPlace: GMSPlace?
    
    // A default location to use when location permission is not granted.
    let defaultLocation = CLLocation(latitude: -33.869405, longitude: 151.199)
    
    // Update the map once the user has made their selection.

    override func loadView() {
        
        let camera = GMSCameraPosition.camera(withLatitude: 51.5,
                                              longitude: -0.127,
                                              zoom: 14)
        let mapView = GMSMapView.map(withFrame: .zero, camera: camera)
        view = mapView
        
        mapView.delegate = self
        
        let house = UIImage(named: "Horizz")!.withRenderingMode(.alwaysTemplate)
        let markerView = UIImageView(image: house)
        markerView.tintColor = .red
        londonView = markerView
        
        let position = CLLocationCoordinate2D(latitude: 35.8200243115759, longitude: 10.5919910129258)
        let marker = GMSMarker(position: position)
        marker.title = "London"
        marker.iconView = markerView
        marker.tracksViewChanges = true
        marker.map = mapView
        london = marker
    }
    
    func mapView(_ mapView: GMSMapView, idleAt position: GMSCameraPosition) {
        UIView.animate(withDuration: 5.0, animations: { () -> Void in
            self.londonView?.tintColor = .blue
        }, completion: {(finished) in
            // Stop tracking view changes to allow CPU to idle.
            self.london?.tracksViewChanges = false
        })
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setNavigationBarItem()
        self.title = "Map"
    }

    override func viewDidLoad() {
        super.viewDidLoad()
      

        // Initialize the location manager.
        locationManager = CLLocationManager()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        //locationManager.requestAlwaysAuthorization()
        //locationManager.distanceFilter = 50
        locationManager.startUpdatingLocation()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()

        // Create a map.
        let camera = GMSCameraPosition.camera(withLatitude: defaultLocation.coordinate.latitude,
                                              longitude: defaultLocation.coordinate.longitude,
                                              zoom: zoomLevel)
        mapView = GMSMapView.map(withFrame: view.bounds, camera: camera)
        mapView.settings.myLocationButton = true
        mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        mapView.isMyLocationEnabled = true
        
        // The myLocation attribute of the mapView may be null
        if let mylocation = mapView.myLocation {
            print("User's location: \(mylocation)")
        } else {
            print("User's location is unknown")
        }
        // Add the map to the view, hide it until we&#39;ve got a location update.
        view.addSubview(mapView)
        mapView.isHidden = true

         addAnnotations(coords: coords)
      
    
       mapView.settings.compassButton = true

    mapView.clear()
        
        // Add a marker to the map.
        if selectedPlace != nil {
            let marker = GMSMarker(position: (self.selectedPlace?.coordinate)!)
            marker.title = selectedPlace?.name
       
            marker.snippet = selectedPlace?.formattedAddress
            marker.icon = UIImage(named: "Horizz")
            marker.map = mapView

           // let marker = GMSMarker(position: position)
    }
    }
    func addAnnotations(coords: [CLLocation]){
        
        for coord in coords{
            let CLLCoordType = CLLocationCoordinate2D(latitude: coord.coordinate.latitude,
                                                      longitude: coord.coordinate.longitude);
            let anno = MKPointAnnotation();
            anno.coordinate = CLLCoordType;
           // mapView.addAnnotation(anno);
        }
        
    }
}
// Delegates to handle events for the location manager.
extension MapViewController: CLLocationManagerDelegate {
    
    // Handle incoming location events.
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location: CLLocation = locations[0]
        print(location)
        
        let camera = GMSCameraPosition.camera(withLatitude: location.coordinate.latitude,
                                              longitude: location.coordinate.longitude,
                                              zoom: zoomLevel)
        
        if mapView.isHidden {
            mapView.isHidden = false
            mapView.camera = camera
        } else {
            mapView.animate(to: camera)
        }
        
        //let span:MKCoordinateSpan = MKCoordinateSpanMake(0.5, 0.5)
       // let myLocation:CLLocationCoordinate2D = CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude)
       // let region:MKCoordinateRegion = MKCoordinateRegionMake(myLocation, span)
         //mapView.setRegion(region, animated: true)
        
        //print(location.altitude)
        print(location.speed)
        print(location.coordinate.latitude)
        print(location.coordinate.longitude)

        let p = ["idUP": userId!]
        
        Service.sharedInstance.loadPositions(parameters: p, url: urlGetPosition) { (state, Objets) in
            if state {
              //  self.FriendArray = Objets!
                //self.currentFriendArray = self.FriendArray
                //self.table.reloadData()

                let params = ["Longitude": String(describing:location.coordinate.longitude),
                                  "latitude": String(describing:location.coordinate.latitude),
                                  "idU": self.userId!
                    ]
                
                Service.sharedInstance.postIt(parameters:params , url:self.urlUpdatePosition)
                
                print("Update done")
              
            } else {
                
                let parameters = ["Longitude": String(describing:location.coordinate.longitude),
                                  "latitude": String(describing:location.coordinate.latitude),
                                  "idU": self.userId!
                    ] as [String: String]
                
            Service.sharedInstance.postIt(parameters:parameters, url:self.urlAddPosition)
                print("NewPosition")
            }
        }
    }
    
    // Handle authorization for the location manager.
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .restricted:
            print("Location access was restricted")
        case .denied:
            print("User denied access to location")
            // Display the map using the default location.
            mapView.isHidden = false
        case .notDetermined:
            print("Location status not determined")
        case .authorizedAlways: fallthrough
        case .authorizedWhenInUse:
            print("Location status is OK")
        }
    }
    
    // Handle location manager errors.
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        locationManager.stopUpdatingLocation()
      print(error)
    }
}
