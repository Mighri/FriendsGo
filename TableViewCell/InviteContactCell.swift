//
//  InviteContactCell.swift
//  FriendsGo
//
//  Created by Radhia Mighri on 17/04/2018.
//  Copyright © 2018 Radhia Mighri. All rights reserved.
//

import UIKit

class InviteContactCell: UITableViewCell {
    
    @IBOutlet var imageContact: UIImageView!
    @IBOutlet var Nom: UILabel!
    @IBOutlet var prenom: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
