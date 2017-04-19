//
//  DTChannel.swift
//  Monosaccharide
//
//  Created by dashuios126 on 17/2/20.
//  Copyright © 2017年 dashuios126. All rights reserved.
//

import UIKit

/// 标签栏数据
class DTChannel: NSObject {

    var editable: Bool?
    var id: Int?
    var name: String?

    init(dict:[String:AnyObject]) {
        id = dict["id"] as? Int
        name = dict["name"] as? String
        editable = dict["editable"] as? Bool
    }


}
