//
//  DTHomeModel.swift
//  Monosaccharide
//
//  Created by dashuios126 on 17/2/24.
//  Copyright © 2017年 dashuios126. All rights reserved.
//

import UIKit

import ObjectMapper


class DTHomeBaseModel: Mappable {

    var code: Int = 0
    var message: String?
    var data: DTHomeModel?

    required init?(map: Map) {

    }

    func mapping(map: Map) {

        code <- map["code"]
        message <- map["message"]
        data <- map["data"]
    }
}

class DTHomeModel: DTHomeBaseModel {

    var items: [DTHomeItems]?

    required init?(map: Map) {
        super.init(map: map)
    }

    override func mapping(map: Map) {
        super.mapping(map: map)
        items <- map["items"]
    }
}

class DTHomeItems: DTHomeModel {


    var cover_image_url: String?
    var id: Int = 0
    var published_at: Int = 0
    var template: String?
    var editor_id: String?
    var created_at: Int = 0
    var content_url: String?
    var labels: Array<Any>?
    var url: String?
    var type: String?
    var share_msg: String?
    var title: String?
    var updated_at: Int = 0
    var short_title: String?
    var liked: Bool = false
    var likes_count: Int = 0
    var status: Int = 0

    required init?(map: Map) {
        super.init(map: map)
    }

    override func mapping(map: Map) {
        cover_image_url <- map["cover_image_url"]
        id <- map["id"]
        published_at <- map["published_at"]
        template <- map["template"]
        editor_id <- map["editor_id"]
        created_at <- map["created_at"]
        content_url <- map["content_url"]
        labels <- map["labels"]
        url <- map["url"]
        type <- map["type"]
        share_msg <- map["share_msg"]
        title <- map["title"]
        updated_at <- map["updated_at"]
        short_title <- map["short_title"]
        liked <- map["liked"]
        likes_count <- map["likes_count"]
        status <- map["status"]
    }

}
