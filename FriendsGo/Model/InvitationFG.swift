//
//  InvitationFG.swift
//  FriendsGo
//
//  Created by Radhia Mighri on 29/03/2018.
//  Copyright © 2018 Radhia Mighri. All rights reserved.
//

import Foundation
import ObjectMapper

class InvitationFG: NSObject, Mappable{
    
    var idFG: String!
    var EtatInvitation: String!
    var Moyen: String!
    var IdInvite: String!
    var IdU: String!
    
    required init?(map: Map) {
        
    }
    
    // Mappable
    func mapping(map: Map) {
        idFG    <- map["IDIF"]
        EtatInvitation     <- map["EtatInvitation"]
        Moyen    <- map["Moyen"]
        IdInvite   <- map["IdInvite"]
        IdU    <- map["IdU"]
    }
    
}

