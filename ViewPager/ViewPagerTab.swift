//
//  ViewPagerTab.swift
//  FriendsGo
//
//  Created by Radhia Mighri on 21/03/2018.
//  Copyright © 2018 Radhia Mighri. All rights reserved.
//

import Foundation
import UIKit

public enum ViewPagerTabType {
    /// Tab contains text only.
    case basic
   }

public struct ViewPagerTab {
    
    public var title:String!
    
    public init(title:String) {
        self.title = title
    }
}
