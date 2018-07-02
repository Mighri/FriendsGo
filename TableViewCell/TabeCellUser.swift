//
//  TabeCellUser.swift
//  FriendsGo
//
//  Created by Design on 02/07/2018.
//  Copyright © 2018 Radhia Mighri. All rights reserved.
//

import UIKit

class TableCellUser: UITableViewCell {
    
    
    @IBOutlet var imageUrl: UIImageView!
    @IBOutlet var Nom: UILabel!
    //  @IBOutlet var Prenom: UILabel!
    @IBOutlet var iconimage: UIImageView!
    @IBOutlet var iconimage2: UIImageView!
    @IBOutlet var button : UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        imageUrl.layer.cornerRadius = 25
        imageUrl.clipsToBounds = true
    }
    
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
