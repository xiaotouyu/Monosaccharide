//
//  DTAdvertising.swift
//  Monosaccharide
//
//  Created by dashuios126 on 17/2/21.
//  Copyright © 2017年 dashuios126. All rights reserved.
//

import UIKit

import ObjectMapper

class Target :DTAdvertising{
    var targets_tatus: Int = 0
    var banner_image_url: String?
    var subtitle: String?
    var targetid: Int = 0
    var created_at: Int = 0
    var title: String?
    var cover_image_url: String?
    var updated_at: Int = 0
    var posts_count: Int = 0


    required init?(map: Map) {
        super.init(map: map)
    }

    override func mapping(map: Map) {

        targets_tatus <- map["status"]
        banner_image_url <- map["banner_image_url"]
        subtitle <- map["subtitle"]
        targetid <- map["id"]
        created_at <- map["created_at"]
        title <- map["title"]
        cover_image_url <- map["cover_image_url"]
        updated_at <- map["updated_at"]
        posts_count <- map["posts_count"]
    }
}


class DTAdvertising :Banners{
    var status: Int = 0
    var channel: String?
    var target: Target?
    var id: Int = 0
    var image_url: String?
    var order: Int = 0
    var target_url: String?
    var type: String!
    var target_id: Int = 0

    required init?(map: Map) {

        super.init(map: map)
    }

    override func mapping(map: Map) {
        super.mapping(map: map)
        status <- map["status"]
        channel <- map["channel"]
        id <- map["id"]
        image_url <- map["image_url"]
        order <- map["order"]
        target_url <- map["target_url"]
        type <- map["type"]
        target_id <- map["target_id"]
        target <- map["target"]

    }

}

class Banners: BaseModel {

    var banners: [DTAdvertising]?

    required init?(map: Map) {
        super.init(map: map)
    }

    override func mapping(map: Map) {
        super.mapping(map: map)
        banners <- map["banners"]
    }
}

class BaseModel: Mappable {

    var code: Int = 0
    var message: String?
    var data: Banners?

    required init?(map: Map) {

    }

    func mapping(map: Map) {

        code <- map["code"]
        message <- map["message"]
        data <- map["data"]
    }
}




//"channel": "all",
//"id": 4,
//"image_url": "http://7fvaoh.com3.z0.glb.qiniucdn.com/image/150806/kzp5acor6.jpg-w720",
//"order": 1,
//"status": 0,
//"target": {
//    "banner_image_url": "http://7fvaoh.com3.z0.glb.qiniucdn.com/image/150806/cb3ee6gg8.jpg-w300",
//    "cover_image_url": "http://7fvaoh.com3.z0.glb.qiniucdn.com/image/150806/8jrebu9ol.jpg-w720",
//    "created_at": 1438826204,
//    "id": 3,
//    "posts_count": 3,
//    "status": 0,
//    "subtitle": "\u96f6\u98df\u63a7\u7684\u6700\u7231",
//    "title": "\u4f60\u4e0d\u80fd\u9519\u8fc7\u7684\u9ad8\u989c\u503c\u96f6\u98df",
//    "updated_at": 1438826204
//},
//"target_id": 3,
//"target_url": "",
//"type": "collection"
