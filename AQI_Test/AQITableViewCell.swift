//
//  AQITableViewCell.swift
//  AQI_Test
//
//  Created by 葉育彰 on 2019/6/14.
//  Copyright © 2019 葉育彰. All rights reserved.
//

import UIKit

class AQITableViewCell: UITableViewCell {

    @IBOutlet var siteName: UILabel!
    @IBOutlet var county: UILabel!
    @IBOutlet var aqiValue: UILabel!
    @IBOutlet var pm25: UILabel!
    @IBOutlet var status: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
