//
//  MWAPopupAddEvent.swift
//  FriendsGo
//
//  Created by Radhia Mighri on 05/04/2018.
//  Copyright © 2018 Radhia Mighri. All rights reserved.
//

import Foundation
import UIKit
import MapKit

enum PopupTypeK:String {
    case addEventView
    case SingleButton
    case TwoButtons
    case TextFieldTwoButtons
    case TwoButtonsHead
}

class MWAPopupAddEvent : UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    // Private IBOutlets
    
    @IBOutlet weak private var backgroundView: UIView!
    @IBOutlet weak private var backgroundImageView: UIImageView!
    
    
    @IBOutlet weak private var popupView: UIView!
    @IBOutlet weak private var popupBackground: UIImageView!
    
    @IBOutlet weak private var firstButton: UIButton!
    @IBOutlet weak private var secondButton: UIButton!
    
    @IBOutlet private var buttonsArray: [UIButton]!
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var eventName: UITextField!
    @IBOutlet weak var eventDescription: UITextField!
    @IBOutlet weak var eventPhoto: UITextField!
    @IBOutlet weak var dateField: UITextField!
    @IBOutlet weak var heureField: UITextField!
    @IBOutlet weak var searchField: UITextField!
    @IBOutlet weak var myImageView: UIImageView!
    // Private Properties
    
    private var currentPopupType:PopupTypeK?
    
    private var titleString = ""
    private var messageString = ""
    
    private var buttonTitles:[String]?
    
    
    private var popupImage:UIImage?
    private var buttonImages:[UIImage]?
    
    private var isCustomPopup = false
    
    // Background Properties
    
    var backgroundImage:UIImage?
    var backgroundColor:UIColor?
    
    // Popup Properties
    // It will set both heading and message label properties as same
    
    var popupFontName : String?
    var popupTextColor : UIColor?
    
    // Title Properties
    
    var titleTextFont:UIFont?
    var titleTextColor:UIColor?
    
    // Message Properties
    
    var messageTextFont:UIFont?
    var messageTextColor:UIColor?
    
    // TextField Properties
    var textFieldBorderStyle:Int?
    var textFieldBackgroundImage:UIImage?
    var textFieldBackgroundColor:UIColor?
    var textFieldText:String?
    var textFieldTextFont:UIFont?
    var textFieldTextColor:UIColor?
    var textFieldPlaceholder:String?
    var textFieldPlaceholderFont:UIFont?
    var textFieldPlaceholderColor:UIColor?
    
    // Button Events
    var onFirstButtonTapped: (()->())?
    var onSecondButtonTapped: (()->())?
    
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var searchText: UITextField!
    var matchingItems: [MKMapItem] = [MKMapItem]()
    

    let urlAddEvent = MyClass.Constants.urlAddEvent
    //
    /// Create Custom Popup
    ///
    /// - Parameters:
    ///   - aPopupType: .SingleButton OR .TwoButtons OR .TextFieldTwoButtons
    ///   - titleString: This string will be shown on heading of a Popup
    ///   - messageString: This string will be shown as message on a Popup
    ///   - buttonNames: Button Titles Array
    /// - Returns: Instance of MWAPopup
    
    
    static func createPopup(aPopupType: PopupTypeK,  titleString: String,
                            messageString: String, buttonNames:[String]) -> MWAPopupAddEvent? {
        
        if let newPopup = UIStoryboard(name: "MWAPopup", bundle: nil).instantiateViewController(withIdentifier: aPopupType.rawValue) as? MWAPopupAddEvent {
            newPopup.titleString = titleString
            newPopup.messageString = messageString
            newPopup.currentPopupType = aPopupType
            newPopup.buttonTitles = buttonNames
            newPopup.isCustomPopup = false
            return newPopup
        }
        return MWAPopupAddEvent()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if currentPopupType == .TextFieldTwoButtons {
            NotificationCenter.default.addObserver(self, selector: #selector(keyBoardWillShow), name: Notification.Name.UIKeyboardWillShow, object: nil)
            
            NotificationCenter.default.addObserver(self, selector: #selector(keyBoardWillHide), name: Notification.Name.UIKeyboardWillHide, object: nil)
        }
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if currentPopupType == .TextFieldTwoButtons {
            NotificationCenter.default.removeObserver(self, name: Notification.Name.UIKeyboardWillShow, object: nil)
            NotificationCenter.default.removeObserver(self, name: Notification.Name.UIKeyboardWillHide, object: nil)
        }
    }
    
    // chercher le lieu de l'événement avec Mapkit
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
            //let imageData:Data =  UIImagePNGRepresentation(image)!
            //let base64String = imageData.base64EncodedString()
            //  print(base64String)
            
            
            
            //UserDefaults.standard.set(base64String, forKey: "imageEvent")
            
            postRequest(image:image)
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
    
    
    
    func postRequest(image:UIImage) {
        
        let parameters = ["name": "MyTestFile123321",
                          "description": "My tutorial test file for MPFD uploads"]
        
        guard let mediaImage = Media(withImage: image, forKey: "image") else { return }
        
        guard let url = URL(string: "https://api.imgur.com/3/image") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        let boundary = generateBoundary()
        
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        request.addValue("Client-ID f65203f7020dddc", forHTTPHeaderField: "Authorization")
        
        let dataBody = createDataBody(withParameters: parameters, media: [mediaImage], boundary: boundary)
        request.httpBody = dataBody
        
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            if let response = response {
                print(response)
            }
            
            if let data = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    print(json)
                    let info = json as! [String : AnyObject]
                    let infoPicture = info["data"] as! [String : AnyObject]
                    //let Objet = (infoPicture as! [String : AnyObject])["data"]
                    let photo = infoPicture["link"] as! String
                    print(photo)
                    
                    UserDefaults.standard.set(photo, forKey: "imageEvent")
                    
                } catch {
                    print(error)
                }
            }
            }.resume()
    }
    
    func generateBoundary() -> String {
        return "Boundary-\(NSUUID().uuidString)"
    }
    
    func createDataBody(withParameters params: Parameters?, media: [Media]?, boundary: String) -> Data {
        
        let lineBreak = "\r\n"
        var body = Data()
        
        if let parameters = params {
            for (key, value) in parameters {
                body.append("--\(boundary + lineBreak)")
                body.append("Content-Disposition: form-data; name=\"\(key)\"\(lineBreak + lineBreak)")
                body.append("\(value + lineBreak)")
            }
        }
        
        if let media = media {
            for photo in media {
                body.append("--\(boundary + lineBreak)")
                body.append("Content-Disposition: form-data; name=\"\(photo.key)\"; filename=\"\(photo.filename)\"\(lineBreak)")
                body.append("Content-Type: \(photo.mimeType + lineBreak + lineBreak)")
                body.append(photo.data)
                body.append(lineBreak)
            }
        }
        
        body.append("--\(boundary)--\(lineBreak)")
        
        return body
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        
        
        firstButton.layer.cornerRadius = 20
        firstButton.clipsToBounds = true
        
        
        secondButton.layer.cornerRadius = 20
        secondButton.clipsToBounds = true
        
        
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
        
        
        backgroundView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        
        
        if let _ = backgroundColor {
            backgroundView.backgroundColor = backgroundColor
        }
        
        if let _ = backgroundImage {
            backgroundImageView.isHidden = false
            backgroundImageView.image = backgroundImage
        }
        
        if !isCustomPopup {
            popupBackground.isHidden = true
            if let bTitles = buttonTitles {
                setButtonTitles(buttonTitles: bTitles)
            }
        }
        else {
            popupBackground.image = popupImage
            if let bImages = buttonImages{
                setButtonImages(buttonImages: bImages)
            }
        }
        
        if currentPopupType == .TextFieldTwoButtons {
            textFieldText = textField.text
            let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: textField.frame.size.height))
            textField.leftView = paddingView
            textField.leftViewMode = .always
            
            
            let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(backgroundTapped(tapGestureRecognizer:)))
            backgroundView.isUserInteractionEnabled = true
            backgroundView.addGestureRecognizer(tapGestureRecognizer)
            
            
            setTextFieldParams()
        }
        
    }
    
    @objc func backgroundTapped(tapGestureRecognizer: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
    
    private func setTextFieldParams() {
        
        if let tfBorderStyle = textFieldBorderStyle,
            let tfStyle = UITextBorderStyle(rawValue: tfBorderStyle) {
            textField.borderStyle = tfStyle
        }
        
        if let tfBackgroundImage = textFieldBackgroundImage {
            textField.background = tfBackgroundImage
        }
        if let tfBackgroundColor = textFieldBackgroundColor {
            textField.backgroundColor = tfBackgroundColor
        }
        
        if let tfColor = textFieldTextColor {
            textField.textColor = tfColor
        }
        if let tfFont = textFieldTextFont {
            textField.font = tfFont
        }
        
        if let tfPlaceholder = textFieldPlaceholder {
            textField.placeholder = tfPlaceholder
            
            if let tfPlaceHolderFont = textFieldPlaceholderFont {
                textField.attributedPlaceholder =
                    NSAttributedString(string: tfPlaceholder,
                                       attributes: [NSAttributedStringKey.font : tfPlaceHolderFont])
            }
            
            if let tfPlaceholderColor = textFieldPlaceholderColor {
                textField.attributedPlaceholder =
                    NSAttributedString(string: tfPlaceholder, attributes: [NSAttributedStringKey.foregroundColor : tfPlaceholderColor])
            }
        }
    }
    
    func setTextFieldBorderStyle(style:UITextBorderStyle) {
        textFieldBorderStyle = style.rawValue
    }
    
    private func setButtonTitles(buttonTitles: [String]) {
        
        guard buttonTitles.count > 0 else {
            print("=== MWAPopup ERROR:: Provide Atleast One Button Name")
            return
        }
        if self.currentPopupType == .SingleButton {
            guard buttonTitles.count == 1 else {
                print("=== MWAPopup ERROR:: Button Count Mismatch With Popup Type")
                return
            }
            self.buttonsArray[0].setTitle(buttonTitles[0], for: .normal)
        }
        else {
            guard buttonTitles.count == 2 else {
                print("=== MWAPopup ERROR:: Only Two Buttons Allowed")
                return
            }
            for i in 0..<buttonTitles.count {
                self.buttonsArray[i].setTitle(buttonTitles[i], for: .normal)
            }
        }
    }
    
    private func setButtonImages(buttonImages: [UIImage]) {
        
        guard buttonImages.count > 0 else {
            print("=== MWAPopup ERROR:: Provide Atleast One Button Name")
            return
        }
        if self.currentPopupType == .SingleButton {
            guard buttonImages.count == 1 else {
                print("=== MWAPopup ERROR:: Button Count Mismatch With Popup Type")
                return
            }
            self.buttonsArray[0].backgroundColor = .clear
            self.buttonsArray[0].setTitle("", for: .normal)
            self.buttonsArray[0].setImage(buttonImages[0], for: .normal)
        }
        else {
            guard buttonImages.count == 2 else {
                print("=== MWAPopup ERROR:: Only Two Buttons Allowed")
                return
            }
            for i in 0..<buttonImages.count {
                self.buttonsArray[i].backgroundColor = .clear
                self.buttonsArray[i].setTitle("", for: .normal)
                self.buttonsArray[i].setImage(buttonImages[i], for: .normal)
            }
        }
    }
    
    @IBAction private func firstButtonTapped(_ sender: UIButton) {
        
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
        ]
        
        
        Service.sharedInstance.postIt(parameters:parameters, url:self.urlAddEvent)
        
        
        //onFirstButtonTapped?()
        /*
         let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "Upload") as! Upload
         
         self.navigationController?.pushViewController(secondViewController, animated: true)
         */
        close()
    }
    
    @IBAction private func secondButtonTapped(_ sender: UIButton) {
        onSecondButtonTapped?()
        close()
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

extension MWAPopupAddEvent {
    
    @objc func keyBoardWillShow() {
        if self.view.frame.origin.y >= 0 {
            setViewMovedUp(movedUp: true)
        }
        else if self.view.frame.origin.y < 0 {
            setViewMovedUp(movedUp: false)
        }
    }
    
    @objc func keyBoardWillHide() {
        if self.view.frame.origin.y >= 0 {
            setViewMovedUp(movedUp: true)
        }
        else if self.view.frame.origin.y < 0 {
            setViewMovedUp(movedUp: false)
        }
    }
    
    func setViewMovedUp(movedUp: Bool){
        
        let kOffset:CGFloat = 80.0
        
        UIView.beginAnimations(nil, context: nil)
        UIView.setAnimationDuration(0.3)
        
        var rect = self.view.frame
        
        if movedUp {
            rect.origin.y -= kOffset;
            rect.size.height += kOffset;
        }
        else
        {
            rect.origin.y += kOffset;
            rect.size.height -= kOffset;
        }
        self.view.frame = rect;
        UIView.commitAnimations()
    }
    
}

