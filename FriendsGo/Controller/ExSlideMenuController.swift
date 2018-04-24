//
//  ExSlideViewController.swift
//  FriendsGo
//
//  Created by Radhia Mighri on 03/03/2018.
//  Copyright © 2018 Radhia Mighri. All rights reserved.
//

import UIKit

class ExSlideMenuController : SlideMenuController {
    
    override func isTagetViewController() -> Bool {
        if let vc = UIApplication.topViewController() {
            if vc is ImportViewController ||
                vc is ContactViewController ||
                vc is EventViewController ||
                vc is MessageViewController ||
                vc is InvitationViewController ||
                vc is NotificationViewController ||
                vc is MapViewController {
                return true
            }
        }
        return false
    }
    
    override func track(_ trackAction: TrackAction) {
        switch trackAction {
        case .leftTapOpen:
            print("TrackAction: left tap open.")
        case .leftTapClose:
            print("TrackAction: left tap close.")
        case .leftFlickOpen:
            print("TrackAction: left flick open.")
        case .leftFlickClose:
            print("TrackAction: left flick close.")
            /*
        case .rightTapOpen:
            print("TrackAction: right tap open.")
        case .rightTapClose:
            print("TrackAction: right tap close.")
        case .rightFlickOpen:
            print("TrackAction: right flick open.")
        case .rightFlickClose:
            print("TrackAction: right flick close.")
 */
        }
    }
}

