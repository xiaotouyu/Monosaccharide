//
//  DTSettingsTableViewCell.swift
//  Monosaccharide
//
//  Created by dashuios126 on 17/3/13.
//  Copyright © 2017年 dashuios126. All rights reserved.
//

import UIKit

class DTSettingsTableViewCell: UITableViewCell {

    @IBOutlet weak var icon_image: UIImageView!

    @IBOutlet weak var aSwitch: UISwitch!
    @IBOutlet weak var rightTitle: UILabel!
    @IBOutlet weak var indicator: UIImageView!
    @IBOutlet weak var leftTitle: UILabel!
    open var setting: DTSettingsModel! {
        didSet{
            icon_image.image = UIImage(named: setting.iconImage!)
            leftTitle.text = setting.leftTitle
            rightTitle.text = setting.rightTitle
            indicator.isHidden = setting.isHiddenRightTip!
            aSwitch.isHidden = setting.isHiddenSwitch!
            aSwitch.isOn = false
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        leftTitle.adjustsFontSizeToFitWidth = true
        rightTitle.adjustsFontSizeToFitWidth = true
        // Configure the view for the selected state
    }
    
}
