//
//  DTClassificationStyleModel.swift
//  Monosaccharide
//
//  Created by dashuios126 on 17/3/10.
//  Copyright © 2017年 dashuios126. All rights reserved.
//

import UIKit

import ObjectMapper


class DTClassificationStyleChannels :DTClassificationStyleChannel_groups{
    var channels_status: Int = 0
    var group_id: Int = 0
    var channels_id: Int = 0
    var items_count: Int = 0
    var channels_order: Int = 0
    var icon_url: String!
    var channels_name: String!
    required init?(map: Map) {
        super.init(map: map)
    }
    override func mapping(map: Map) {
        super.mapping(map: map)
        channels_status <- map["status"]
        group_id <- map["group_id"]
        channels_id <- map["id"]
        items_count <- map["items_count"]
        channels_order <- map["order"]
        icon_url <- map["icon_url"]
        channels_name <- map["name"]
    }
}
class DTClassificationStyleChannel_groups :DTClassificationStyleData{
    var status: Int = 0
    var id: Int = 0
    var channels: [DTClassificationStyleChannels]!
    var order: Int = 0
    var name: String!
    required init?(map: Map) {
        super.init(map: map)
    }
    override func mapping(map: Map) {
        super.mapping(map: map)
        status <- map["status"]
        id <- map["id"]
        channels <- map["channels"]
        order <- map["order"]
        name <- map["name"]
    }
}
class DTClassificationStyleData :DTClassificationStyleModel{
    var channel_groups: [DTClassificationStyleChannel_groups]!
    required init?(map: Map) {
        super.init(map: map)
    }
    override func mapping(map: Map) {
        super.mapping(map: map)
        channel_groups <- map["channel_groups"]
    }
}
class DTClassificationStyleModel :Mappable{
    var message: String!
    var data: DTClassificationStyleData!
    var code: Int = 0

    required init?(map: Map) {

    }
    func mapping(map: Map) {
        message <- map["message"]
        data <- map["data"]
        code <- map["code"]
    }
}
