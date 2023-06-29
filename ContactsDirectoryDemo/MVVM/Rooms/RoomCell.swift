//
//  NZPhotoCell.swift
//  NZImageDemo
//
//  Created by Nilesh Zambre on 24/12/22.
//  Copyright © 2021 Nilesh Zambre. All rights reserved.
//

import UIKit
import Downloader

class RoomCell: UITableViewCell {
    @IBOutlet weak var roomIdLabel: UILabel!
    @IBOutlet weak var maxOccupancyLabel: UILabel!
    @IBOutlet weak var avaibilityLable: UILabel!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder:aDecoder)
        //You Code here
    }
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    func setRoom(room: RoomModel){
        roomIdLabel.text = room.id;
        maxOccupancyLabel.text = String(room.maxOccupancy)
        avaibilityLable.text = room.isOccupied ? "Un available" : "Available";
        
    }

}
