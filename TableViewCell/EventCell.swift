//
//  EventCell.swift
//  FriendsGo
//
//  Created by Radhia Mighri on 04/04/2018.
//  Copyright © 2018 Radhia Mighri. All rights reserved.
//

import UIKit

class EventCell: UITableViewCell {
    
    @IBOutlet var imageAdresse: UIImageView!
    @IBOutlet var imageHeure: UIImageView!
    @IBOutlet var imageEvent: UIImageView!
    @IBOutlet var titre: UILabel!
    @IBOutlet var date: UILabel!
    @IBOutlet var heure : UILabel!
    @IBOutlet var adresse : UILabel!
   
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
    }
}
