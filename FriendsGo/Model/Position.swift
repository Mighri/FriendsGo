//
//  Position.swift
//  FriendsGo
//
//  Created by Radhia Mighri on 11/05/2018.
//  Copyright © 2018 Radhia Mighri. All rights reserved.
//

import Foundation
import ObjectMapper

class Position: NSObject, Mappable{
    
    var idP: String!
    var longitude: String!
    var latitude: String!
    var idUser: String!
    
    
    required init?(map: Map) {
        
    }
    
    // Mappable
    func mapping(map: Map) {
        idP    <- map["IdP"]
        longitude     <- map["Longitude"]
        latitude    <- map["latitude"]
        idUser   <- map["idUP"]
    }
    
}



