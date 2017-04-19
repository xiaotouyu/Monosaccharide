//
//  DTSettingsModel.swift
//  Monosaccharide
//
//  Created by dashuios126 on 17/3/13.
//  Copyright © 2017年 dashuios126. All rights reserved.
//

import UIKit

class DTSettingsModel: NSObject {
    var iconImage: String?
    var leftTitle: String?
    var rightTitle: String?
    var isHiddenSwitch: Bool?
    var isHiddenRightTip: Bool?

    init(dict: [String: AnyObject]) {
        super.init()
        iconImage = dict["iconImage"] as? String
        leftTitle = dict["leftTitle"] as? String
        rightTitle = dict["rightTitle"] as? String
        isHiddenSwitch = dict["isHiddenSwitch"] as? Bool
        isHiddenRightTip = dict["isHiddenRightTip"] as? Bool
    }
}
