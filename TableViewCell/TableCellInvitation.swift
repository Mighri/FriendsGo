//
//  TableCellInvitation.swift
//  FriendsGo
//
//  Created by Radhia Mighri on 26/03/2018.
//  Copyright © 2018 Radhia Mighri. All rights reserved.
//

import UIKit

class TableCellInvitation: UITableViewCell {

    @IBOutlet var imageUrl: UIImageView!
    @IBOutlet var Nom: UILabel!
    @IBOutlet var message: UILabel!
    @IBOutlet var buttonConfimer : UIButton!
    @IBOutlet var buttonAnnuler : UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}

