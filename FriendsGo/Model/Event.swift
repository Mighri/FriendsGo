//
//  Event.swift
//  FriendsGo
//
//  Created by Radhia Mighri on 04/04/2018.
//  Copyright © 2018 Radhia Mighri. All rights reserved.
//

import Foundation
import ObjectMapper

class Event: NSObject, Mappable{
    
    var idE: String!
    var titre: String!
    var descriptif: String!
    var date: String!
    var heure: String!
    var adresse: String!
    var image: String!
    var IdU: String!
    
    required init?(map: Map) {
        
    }
    
    // Mappable
    func mapping(map: Map) {
        idE    <- map["IdE"]
        titre     <- map["Titre"]
        descriptif    <- map["Descriptif"]
        date   <- map["Date"]
        heure    <- map["Heure"]
        adresse   <- map["Adresse"]
        image   <- map["Image"]
        IdU    <- map["IdU"]
    }
    
}


