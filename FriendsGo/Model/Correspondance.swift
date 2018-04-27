//
//  Correspondance.swift
//  FriendsGo
//
//  Created by Radhia Mighri on 27/04/2018.
//  Copyright © 2018 Radhia Mighri. All rights reserved.
//

import Foundation
import ObjectMapper

class Correspondance: NSObject, Mappable{
    
    var idUser: String!
    var idContact: String!
    
    required init?(map: Map) {
        
    }
    // Mappable
    func mapping(map: Map) {
        idUser    <- map["IdU"]
        idContact     <- map["IdC"]
    }
    
}

