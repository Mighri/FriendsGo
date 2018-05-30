//
//  TableCellChat.swift
//  FriendsGo
//
//  Created by Radhia Mighri on 28/05/2018.
//  Copyright © 2018 Radhia Mighri. All rights reserved.
//

import UIKit

class TableCellChat: UITableViewCell {
    
    
    @IBOutlet var imageUrl: UIImageView!
    @IBOutlet var message: UILabel!
    @IBOutlet var time: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        imageUrl.layer.cornerRadius = 25
        imageUrl.clipsToBounds = true
        
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}

