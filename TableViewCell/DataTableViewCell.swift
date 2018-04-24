//
//  DataTableViewCell.swift
//  FriendsGo
//
//  Created by Radhia Mighri on 03/03/2018.
//  Copyright © 2018 Radhia Mighri. All rights reserved.
//

import UIKit

struct DataTableViewCellData {
   
    init(imageUrl: String, text: String) {
        self.imageUrl = imageUrl
        self.text = text
    }
    var imageUrl: String
    var text: String
}

class DataTableViewCell : BaseTableViewCell {
    
    @IBOutlet weak var dataImage: UIImageView!
    @IBOutlet weak var dataText: UILabel!
      @IBOutlet weak var number: UILabel!
    
    override func awakeFromNib() {
        self.dataText?.font = UIFont.italicSystemFont(ofSize: 16)
        self.dataText?.textColor = UIColor(hex: "000000")
    }
    
    override class func height() -> CGFloat {
        return 80
    }
    
    override func setData(_ data: Any?) {
        if let data = data as? DataTableViewCellData {
          //  self.dataImage.setRandomDownloadImage(80, height: 80)
            self.dataText.text = data.text
        }
    }
}

