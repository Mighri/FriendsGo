//
//  InvitationEventFG.swift
//  FriendsGo
//
//  Created by Radhia Mighri on 26/04/2018.
//  Copyright © 2018 Radhia Mighri. All rights reserved.
//

import Foundation
import ObjectMapper

class InvitationEventFG: NSObject, Mappable{
    
    var IDIE: String!
    var Etat: String!
    var IdInviteur: String!
    var IdInvited: String!
    var IdEvent: String!
    
    required init?(map: Map) {
        
    }
    
    // Mappable
    func mapping(map: Map) {
        IDIE    <- map["IDIE"]
        Etat     <- map["Etat"]
        IdInviteur    <- map["IdInviteur"]
        IdInvited   <- map["IdInvited"]
        IdEvent    <- map["IdEvent"]
    }
    
}


