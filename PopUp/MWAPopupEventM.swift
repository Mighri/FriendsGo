//
//  MWAPopupEventM.swift
//  FriendsGo
//
//  Created by Radhia Mighri on 14/04/2018.
//  Copyright © 2018 Radhia Mighri. All rights reserved.
//

import Foundation
import UIKit
import MapKit
// 
class MWAPopupEventM: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    @IBOutlet weak var eventName: UITextField!
    @IBOutlet weak var eventDescription: UITextField!
    @IBOutlet weak var eventPhoto: UITextField!
    @IBOutlet weak var dateField: UITextField!
    @IBOutlet weak var heureField: UITextField!
    @IBOutlet weak var searchField: UITextField!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var searchText: UITextField!
    var matchingItems: [MKMapItem] = [MKMapItem]()
    @IBOutlet weak  var firstButton: UIButton!
    @IBOutlet weak  var secondButton: UIButton!
    
    let urlAddEvent = MyClass.Constants.urlAddEvent
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        
        self.showAnimate()
        
        firstButton.layer.cornerRadius = 20
        firstButton.clipsToBounds = true
        
        
        secondButton.layer.cornerRadius = 20
        secondButton.clipsToBounds = true
        
        
        let datePicker = UIDatePicker()
        
        datePicker.datePickerMode = UIDatePickerMode.date
        
        datePicker.addTarget(self, action: #selector(MWAPopupAddEvent.datePickerValueChanged(sender:)), for: UIControlEvents.valueChanged)
        
        dateField.inputView = datePicker
        
        // timePicker
        
        let timePicker = UIDatePicker()
        
        timePicker.datePickerMode = UIDatePickerMode.countDownTimer
        //timePicker.minuteInterval = 5
        //timePicker.countDownDuration = 4500
        timePicker.addTarget(self, action: #selector(MWAPopupAddEvent.startTimeDiveChanged(sender:)), for: UIControlEvents.valueChanged)
        heureField.inputView = timePicker

        
        dateField.leftViewMode = .always
        
        let dateFieldContainer = UIView(frame: CGRect(x: dateField.frame.origin.x, y:  dateField.frame.origin.y, width: 40.0, height: 30.0))
        
        let dateFieldView = UIImageView(frame: CGRect(x: 0, y: 0, width: 25.0, height: 25.0))
        
        //dateFieldView.image = UIImage(named: "date")
        dateFieldView.center = dateFieldContainer.center
        dateFieldContainer.addSubview(dateFieldView)
        dateField.leftView = dateFieldContainer
        
        
        heureField.leftViewMode = .always
        
        let heureFieldContainer = UIView(frame: CGRect(x: heureField.frame.origin.x, y:  heureField.frame.origin.y, width: 40.0, height: 30.0))
        
        let heureFieldView = UIImageView(frame: CGRect(x: 0, y: 0, width: 25.0, height: 25.0))
        
        //heureFieldView.image = UIImage(named: "date")
        heureFieldView.center = heureFieldContainer.center
        heureFieldContainer.addSubview(heureFieldView)
        heureField.leftView = heureFieldContainer
        
        
        
        searchField.leftViewMode = .always
        
        let searchFieldContainer = UIView(frame: CGRect(x: searchField.frame.origin.x, y:  searchField.frame.origin.y, width: 40.0, height: 30.0))
        
        let searchFieldView = UIImageView(frame: CGRect(x: 0, y: 0, width: 25.0, height: 25.0))
        
        //searchFieldView.image = UIImage(named: "date")
        searchFieldView.center = searchFieldContainer.center
        searchFieldContainer.addSubview(searchFieldView)
        searchField.leftView = searchFieldContainer
        
        
        
        
        
        eventPhoto.leftViewMode = .always
        
        let eventPhotoContainer = UIView(frame: CGRect(x: eventPhoto.frame.origin.x, y:  eventPhoto.frame.origin.y, width: 40.0, height: 30.0))
        
        let eventPhotoView = UIImageView(frame: CGRect(x: 0, y: 0, width: 25.0, height: 25.0))
        
        //eventPhotoView.image = UIImage(named: "date")
        eventPhotoView.center = eventPhotoContainer.center
        eventPhotoContainer.addSubview(eventPhotoView)
        eventPhoto.leftView = eventPhotoContainer
        
        }
    
    //  
    @IBAction func closePopUp(_ sender: AnyObject) {
        self.removeAnimate()
        //self.view.removeFromSuperview()
    }
    
    // 
    
    @IBAction private func registerButtonTapped(_ sender: UIButton) {
        
        let userId = UserDefaults.standard.string(forKey: "Saveid")
        print(userId!)
        let imageEvent = UserDefaults.standard.string(forKey: "imageEvent")
        print(searchText.text!)
        let parameters = ["Titre": eventName.text!,
                          "Descriptif": eventDescription.text!,
                          "Date": dateField.text!,
                          "Heure": heureField.text!,
                          "Adresse": searchText.text!,
                          "Image": imageEvent!,
                          "idU": userId!
        ] as [String: String]
        
        
        Service.sharedInstance.postIt(parameters:parameters, url:self.urlAddEvent)
        
        
        //onFirstButtonTapped?()
        /*
         let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "Upload") as! Upload
         
         self.navigationController?.pushViewController(secondViewController, animated: true)
         */
         close()
    }
    
    
    
    @IBAction func textFieldReturn(_ sender: AnyObject) {
        _ = sender.resignFirstResponder()
        mapView.removeAnnotations(mapView.annotations)
        self.performSearch()
    }
    
    func performSearch() {
        
        matchingItems.removeAll()
        let request = MKLocalSearchRequest()
        request.naturalLanguageQuery = searchText.text
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
    // import photo from my photoLibrary
    
    @IBAction func importPhoto(_ sender: AnyObject) {
        _ = sender.resignFirstResponder()
        let image = UIImagePickerController()
        image.delegate = self
        
        image.sourceType = UIImagePickerControllerSourceType.photoLibrary
        
        image.allowsEditing = false
        
        self.present(image, animated: true)
        {
            //After it is complete
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any])
    {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage
        {
            //myImageView.image = image
            //var logo = UIImage(named: "image_logo")
            let imageData:Data =  UIImagePNGRepresentation(image)!
            let base64String = imageData.base64EncodedString()
            //  print(base64String)
            
            UserDefaults.standard.set(base64String, forKey: "imageEvent")
            
            /*
             let imagedecoded = Data(base64Encoded: base64String, options: Data.Base64DecodingOptions.ignoreUnknownCharacters)!
             myImageView.image = UIImage(data: imagedecoded)!
             */
        }
        else
        {
            //Error message
        }
        
        self.dismiss(animated: true, completion: nil)
    }
    // pick a date
    
    @objc func datePickerValueChanged(sender: UIDatePicker) {
        
        let formatter = DateFormatter()
        
        formatter.dateStyle = DateFormatter.Style.medium
        
        formatter.timeStyle = DateFormatter.Style.none
        formatter.dateFormat = "yyyy-MM-dd"
        dateField.text = formatter.string(from: sender.date)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        view.endEditing(true)
    }
    // Pick a time
    @objc func startTimeDiveChanged(sender: UIDatePicker) {
        let formatter = DateFormatter()
        formatter.timeStyle = DateFormatter.Style.medium
        formatter.timeStyle = DateFormatter.Style.none
        formatter.dateFormat = "HH:mm"
        heureField.text = formatter.string(from: sender.date)
        //timePicker.removeFromSuperview() // if you want to remove time picker
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
