//
//  MWAPopupC.swift
//  FriendsGo
//
//  Created by Radhia Mighri on 02/04/2018.
//  Copyright © 2018 Radhia Mighri. All rights reserved.
//

import Foundation
import UIKit

enum PopupTypeC:String {
    case SingleButton
    case TwoButtons
}

class MWAPopupC : UIViewController {
    
    // Private IBOutlets
    
    @IBOutlet weak private var backgroundView: UIView!
    @IBOutlet weak private var backgroundImageView: UIImageView!
    
    @IBOutlet weak private var popupView: UIView!
    @IBOutlet weak private var popupBackground: UIImageView!
    
    
    @IBOutlet weak private var firstButton: UIButton!
    @IBOutlet weak private var secondButton: UIButton!
    
    @IBOutlet private var buttonsArray: [UIButton]!
    
    // Private Properties
    
    private var currentPopupType:PopupTypeC?
    
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
    
    // Button Events
    var onFirstButtonTapped: (()->())?
    var onSecondButtonTapped: (()->())?
    
    static func createPopupWithout(aPopupType: PopupTypeC, buttonNames:[String]) -> MWAPopupC? {
        
        if let newPopup = UIStoryboard(name: "MWAPopup", bundle: nil).instantiateViewController(withIdentifier: aPopupType.rawValue) as? MWAPopupC {
            
            newPopup.currentPopupType = aPopupType
            newPopup.buttonTitles = buttonNames
            newPopup.isCustomPopup = false
            return newPopup
        }
        return MWAPopupC()
    } 
    override func viewDidLoad() {
        super.viewDidLoad()
        
       // headingLabel.text = titleString
        //messageLabel.text = messageString
        
        //  secondButton.titleLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping;
        
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
        
    }
    
    @objc func backgroundTapped(tapGestureRecognizer: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
    
    private func setButtonTitles(buttonTitles: [String]) {
        
        guard buttonTitles.count > 0 else {
            print("=== MWAPopup ERROR:: Provide Atleast One Button Name")
            return
        }
        if self.currentPopupType == .SingleButton {
           
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
        onFirstButtonTapped?()
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



extension MWAPopupC {
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

