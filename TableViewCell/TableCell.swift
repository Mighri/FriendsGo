//
//  TableCell.swift
//  FriendsGo
//
//  Created by Radhia Mighri on 23/03/2018.
//  Copyright © 2018 Radhia Mighri. All rights reserved.
//

import UIKit

class TableCell: UITableViewCell {
    
    
    @IBOutlet var imageUrl: UIImageView!
    @IBOutlet var Nom: UILabel!
   //  @IBOutlet var Prenom: UILabel!
    @IBOutlet var iconimage: UIImageView!
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
