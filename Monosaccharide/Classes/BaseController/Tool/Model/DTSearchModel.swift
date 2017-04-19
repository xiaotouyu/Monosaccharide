//
//  DTSearchModel.swift
//  Monosaccharide
//
//  Created by dashuios126 on 17/2/28.
//  Copyright © 2017年 dashuios126. All rights reserved.
//

import UIKit
import ObjectMapper

class DTSearchModel: Mappable {

    var code: Int = 0
    var message: String?
    var data: DTSearchData?

    required init?(map: Map) {

    }

    func mapping(map: Map) {

        code <- map["code"]
        message <- map["message"]
        data <- map["data"]
    }
}

class DTSearchData: DTSearchModel {

    var hot_words: [String]?
    var placeholder: AnyObject?

    required init?(map: Map) {
        super.init(map: map)
    }

    override func mapping(map: Map) {
        super.mapping(map: map)

        hot_words <- map["hot_words"]
        placeholder <- map["placeholder"]
    }
}



