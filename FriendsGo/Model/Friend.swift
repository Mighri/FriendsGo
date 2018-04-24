//
//  Friends.swift
//  FriendsGo
//
//  Created by Radhia Mighri on 21/02/2018.
//  Copyright © 2018 Radhia Mighri. All rights reserved.
//

import Foundation
import ObjectMapper

class Friend: NSObject, Mappable{
 
    var id: String!
    var Nom: String!
    var prenom: String!
    var telephone: String!
    var email: String!
    var photoURL: String!
    var password: String!
    var inscrivia: String!
    var idS: String!
    
    required init?(map: Map) {
        
    }
    
    // Mappable
    func mapping(map: Map) {
        id    <- map["IDU"]
        Nom     <- map["Nom"]
        prenom    <- map["prenom"]
        email   <- map["Mail"]
        password    <- map["MotDePasse"]
        telephone <- map["telephone"]
        photoURL    <- map["PhotoURL"]
       inscrivia    <- map["inscrivia"]
         idS    <- map["id"]
    }
    
}
