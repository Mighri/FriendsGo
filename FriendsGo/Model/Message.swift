//
//  Message.swift
//  FriendsGo
//
//  Created by Design on 12/06/2018.
//  Copyright © 2018 Radhia Mighri. All rights reserved.
//

import Foundation
import ObjectMapper

class Message: NSObject, Mappable{
    
    var IDM: String!
    var messageText: String!
    var Date: String!
    var Hour: String!
    var senderID: String!
    var RecieverID: String!
    var ChannelName: String!
 
    required init?(map: Map) {
        
    }

    
    // Mappable
    func mapping(map: Map) {
        IDM    <- map["IDM"]
        messageText     <- map["messageText"]
        Date    <- map["Date"]
        Hour   <- map["Hour"]
        senderID   <- map["senderID"]
        RecieverID    <- map["RecieverID"]
        ChannelName <- map["ChannelName"]
       
    }
    
}
