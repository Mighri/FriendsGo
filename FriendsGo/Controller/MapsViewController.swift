//
//  MapsViewController.swift
//  FriendsGo
//
//  Created by Radhia Mighri on 16/05/2018.
//  Copyright © 2018 Radhia Mighri. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces

struct MyPlace {
    var name: String
    var lat: Double
    var long: Double
}

class MapsViewController: UIViewController, CLLocationManagerDelegate, GMSMapViewDelegate, GMSAutocompleteViewControllerDelegate, UITextFieldDelegate {
    
    var positions = [Position]()
    var friends = [Friend]()
    
    let urlGetFriendsOnMap = MyClass.Constants.urlGetFriendsOnMap
    let urlGetUsername = MyClass.Constants.urlGetUsername
    let urlGetLocations = MyClass.Constants.urlGetLocations
    let urlAddPosition = MyClass.Constants.urlAddPosition
    let urlGetPosition = MyClass.Constants.urlGetPosition
    let urlUpdatePosition = MyClass.Constants.urlUpdatePosition
    let userId = UserDefaults.standard.string(forKey: "Saveid")
        var friend : Friend!

    let currentLocationMarker = GMSMarker()
    var locationManager = CLLocationManager()
    var chosenPlace: MyPlace?
    
    let customMarkerWidth: Int = 50
    let customMarkerHeight: Int = 100
    
    let previewDemoData = [(title: "The Polar Junction", img: #imageLiteral(resourceName: "restaurant1"), price: 10), (title: "The Nifty Lounge", img: #imageLiteral(resourceName: "restaurant2"), price: 8), (title: "The Lunar Petal", img: #imageLiteral(resourceName: "restaurant3"), price: 12)]
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setNavigationBarItem()
        self.title = "Map"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        myMapView.delegate=self
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        locationManager.startMonitoringSignificantLocationChanges()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        //locationManager.requestAlwaysAuthorization()
        //locationManager.distanceFilter = 50
        
        //let mapInsets = UIEdgeInsets(top: 80.0, left: 0.0, bottom: 45.0, right: 0.0)
       // myMapView.padding = mapInsets
        
        setupViews()
        initGoogleMaps()
        
        txtFieldSearch.delegate=self

        let p = ["inscrivia" : "FriendsGo"]
        
        Service.sharedInstance.loadPositions(parameters: p, url: urlGetLocations) { (state, Objets) in
            if state {
                self.positions = Objets!
                
                print("Objets")
            } else {
                print("nooo")
            }
        }

        Service.sharedInstance.loadInfoAny(parameters: p, url: urlGetFriendsOnMap) { (state, Objets) in
            if state {
                self.friends = Objets!
                
                print("Objets")
            } else {
                print("nooo")
            }
        }
    }
    //MARK: textfield
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        let autoCompleteController = GMSAutocompleteViewController()
        autoCompleteController.delegate = self
        
        let filter = GMSAutocompleteFilter()
        autoCompleteController.autocompleteFilter = filter
        
        self.locationManager.startUpdatingLocation()
        
        self.present(autoCompleteController, animated: true, completion: nil)
        return false
    }
    
    // MARK: GOOGLE AUTO COMPLETE DELEGATE
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        let lat = place.coordinate.latitude
        let long = place.coordinate.longitude
        
        let camera = GMSCameraPosition.camera(withLatitude: lat, longitude: long, zoom: 17.0)
        myMapView.camera = camera
        txtFieldSearch.text=place.formattedAddress
        chosenPlace = MyPlace(name: place.formattedAddress!, lat: lat, long: long)
        let marker=GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: lat, longitude: long)
        marker.title = "\(place.name)"
        marker.snippet = "\(place.formattedAddress!)"
        marker.map = myMapView
        print(place.coordinate.latitude)
        print(place.coordinate.longitude)
        
        self.dismiss(animated: true, completion: nil) // dismiss after place selected
    }
    
    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        print("ERROR AUTO COMPLETE \(error)")
    }
    
    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func initGoogleMaps() {
        let camera = GMSCameraPosition.camera(withLatitude: 35.824711, longitude: 10.634190, zoom: 17.0)
        self.myMapView.camera = camera
        self.myMapView.delegate = self
        self.myMapView.isMyLocationEnabled = true
    }
    // MARK: CLLocation Manager Delegate
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error while getting location \(error)")
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        //locationManager.delegate = nil
        // locationManager.stopUpdatingLocation()
        let location = locations[0]
        let lat = (location.coordinate.latitude)
        let long = (location.coordinate.longitude)
        print(lat)
        print(long)
        
        
        
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
 
        showPartyMarkers(lat: lat, long: long)
    }
    
    // MARK: GOOGLE MAP DELEGATE
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        guard let customMarkerView = marker.iconView as? CustomMarkerView else { return false }
        let img = customMarkerView.img!
        let customMarker = CustomMarkerView(frame: CGRect(x: 0, y: 0, width: customMarkerWidth, height: customMarkerHeight), image: img, borderColor: UIColor.white, tag: customMarkerView.tag)
        
        marker.iconView = customMarker
        
        return false
    }
    /*
    func mapView(_ mapView: GMSMapView, markerInfoContents marker: GMSMarker) -> UIView? {
        guard let customMarkerView = marker.iconView as? CustomMarkerView else { return nil }
        
        
         /*
        for i in 0..<self.friends.count {
            
            let data = friends[i]
            
            restaurantPreviewView.setData(title: data.Nom+" "+data.prenom, img: previewDemoData[0].img, price: Int(data.id)!)
     }
         */
       
        let data = previewDemoData[customMarkerView.tag]
        restaurantPreviewView.setData(title: data.title, img: data.img, price: data.price)

        return restaurantPreviewView
    }
 */
    
    func mapView(_ mapView: GMSMapView, didTapInfoWindowOf marker: GMSMarker) {
        guard let customMarkerView = marker.iconView as? CustomMarkerView else { return }
        let tag = customMarkerView.tag
        restaurantTapped(tag: tag)
    }
    
    func mapView(_ mapView: GMSMapView, didCloseInfoWindowOf marker: GMSMarker) {
        guard let customMarkerView = marker.iconView as? CustomMarkerView else { return }
        let img = customMarkerView.img!
        let customMarker = CustomMarkerView(frame: CGRect(x: 0, y: 0, width: customMarkerWidth, height: customMarkerHeight), image: img, borderColor: UIColor.darkGray, tag: customMarkerView.tag)
        marker.iconView = customMarker
    }
    
    func showPartyMarkers(lat: Double, long: Double) {
        myMapView.clear()
        // for i in 0..<3 {
        for coord in self.positions {
            
            let pss = ["IdU" : coord.idUser] as [String : Any]
            Service.sharedInstance.loadInfoAny(parameters: pss, url: urlGetUsername) { (state, Objets) in
                if state {
                    self.friend = Objets![0]
                    //self.proprietaireEvent.text = self.friend.Nom + " "+self.friend.prenom
                    print("Objets")
                     let marker=GMSMarker()
                
                    if (self.friend.photoURL != "NULL")
                    {
                    let url = URL(string: self.friend.photoURL)
                    let data = try? Data(contentsOf: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
                  
                        let customMarker = CustomMarkerView(frame: CGRect(x: 0, y: 0, width: self.customMarkerWidth, height: self.customMarkerHeight), image: UIImage(data: data!)!, borderColor: UIColor(hex: "E21D60"), tag: 0)
                   
            marker.iconView=customMarker
            let position = CLLocationCoordinate2D(latitude: Double(coord.latitude)!, longitude: Double(coord.longitude)!)
            
            marker.position = position
            marker.title = self.friend.Nom
            marker.snippet = self.friend.prenom
            marker.map = self.myMapView

                    }
                    else
                    {
                        let customMarker = CustomMarkerView(frame: CGRect(x: 0, y: 0, width: self.customMarkerWidth, height: self.customMarkerHeight), image: UIImage(named: "profile")!, borderColor: UIColor(hex: "E21D60"), tag: 0)
                        
                        marker.iconView=customMarker
                        let position = CLLocationCoordinate2D(latitude: Double(coord.latitude)!, longitude: Double(coord.longitude)!)
                        
                        marker.position = position
                        marker.title = self.friend.Nom
                        marker.snippet = self.friend.prenom
                        marker.map = self.myMapView
                    }
                
                
                } else {
                    print("nooo")
                }
            }
        }
    }
    
    @objc func btnMyLocationAction() {
        let location: CLLocation? = myMapView.myLocation
        if location != nil {
            myMapView.animate(toLocation: (location?.coordinate)!)
        }
    }
    
    @objc func restaurantTapped(tag: Int) {
        let v=DetailsVC()
        v.passedData = previewDemoData[tag]
        self.navigationController?.pushViewController(v, animated: true)
    }
    
    func setupTextField(textField: UITextField, img: UIImage){
        textField.leftViewMode = UITextFieldViewMode.always
        let imageView = UIImageView(frame: CGRect(x: 5, y: 5, width: 20, height: 20))
        imageView.image = img
        let paddingView = UIView(frame:CGRect(x: 0, y: 0, width: 30, height: 30))
        paddingView.addSubview(imageView)
        textField.leftView = paddingView
    }
    
    func setupViews() {
        view.addSubview(myMapView)
        myMapView.topAnchor.constraint(equalTo: view.topAnchor).isActive=true
        myMapView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive=true
        myMapView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive=true
        myMapView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 60).isActive=true
        
        self.view.addSubview(txtFieldSearch)
        txtFieldSearch.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive=true
        txtFieldSearch.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10).isActive=true
        txtFieldSearch.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10).isActive=true
        txtFieldSearch.heightAnchor.constraint(equalToConstant: 35).isActive=true
        setupTextField(textField: txtFieldSearch, img: UIImage(named: "map-pin")!)
        
        restaurantPreviewView=RestaurantPreviewView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 190))
        
        self.view.addSubview(btnMyLocation)
        btnMyLocation.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -30).isActive=true
        btnMyLocation.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive=true
        btnMyLocation.widthAnchor.constraint(equalToConstant: 50).isActive=true
        btnMyLocation.heightAnchor.constraint(equalTo: btnMyLocation.widthAnchor).isActive=true
    }
    
    let myMapView: GMSMapView = {
        let v=GMSMapView()
        v.translatesAutoresizingMaskIntoConstraints=false
        return v
    }()
    
    let txtFieldSearch: UITextField = {
        let tf=UITextField()
        tf.borderStyle = .roundedRect
        tf.backgroundColor = .white
        tf.layer.borderColor = UIColor.darkGray.cgColor
        tf.placeholder="chercher un endroit"
        tf.translatesAutoresizingMaskIntoConstraints=false
        return tf
    }()
    
    let btnMyLocation: UIButton = {
        let btn=UIButton()
        btn.backgroundColor = UIColor.white
        btn.setImage(UIImage(named: "gps-fixed"), for: .normal)
        btn.layer.cornerRadius = 25
        btn.clipsToBounds=true
        btn.tintColor = UIColor.gray
        btn.imageView?.tintColor=UIColor.gray
        btn.addTarget(self, action: #selector(btnMyLocationAction), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints=false
        return btn
    }()
    
    var restaurantPreviewView: RestaurantPreviewView = {
        let v=RestaurantPreviewView()
        return v
    }()
}
extension UIImage {
    
    convenience init?(withContentsOfUrl url: URL) throws {
        let imageData = try Data(contentsOf: url)
        
        self.init(data: imageData)
    }
    
}



