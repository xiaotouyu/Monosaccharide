//
//  DTClassicationProjectModel.swift
//  Monosaccharide
//
//  Created by dashuios126 on 17/3/10.
//  Copyright © 2017年 dashuios126. All rights reserved.
//

import UIKit
import ObjectMapper

class DTClassicationProjectCollections :DTClassicationProjectData{
    var status: Int = 0
    var banner_image_url: String!
    var subtitle: String!
    var id: Int = 0
    var created_at: Int = 0
    var title: String!
    var cover_image_url: String!
    var updated_at: Int = 0
    var posts_count: Int = 0
    required init?(map: Map) {
        super.init(map: map)
    }

    override func mapping(map: Map) {
        super.mapping(map: map)
        status <- map["status"]
        banner_image_url <- map["banner_image_url"]
        subtitle <- map["subtitle"]
        id <- map["id"]
        created_at <- map["created_at"]
        title <- map["title"]
        cover_image_url <- map["cover_image_url"]
        updated_at <- map["updated_at"]
        posts_count <- map["posts_count"]
    }
}

class DTClassicationProjectPaging :DTClassicationProjectData{
    var next_url: String!
    required init?(map: Map) {
        super.init(map: map)
    }

    override func mapping(map: Map) {
        super.mapping(map: map)
        paging <- map["paging"]
    }
}

class DTClassicationProjectData :DTClassicationProjectModel{
    var collections: [DTClassicationProjectCollections]!
    var paging: DTClassicationProjectPaging!

    required init?(map: Map) {
        super.init(map: map)
    }

    override func mapping(map: Map) {
        super.mapping(map: map)
        collections <- map["collections"]
        paging <- map["paging"]
    }

}

class DTClassicationProjectModel :Mappable{

    var message: String!
    var data: DTClassicationProjectData!
    var code: Int = 0

    required init?(map: Map) {

    }

    func mapping(map: Map) {
        message <- map["message"]
        data <- map["data"]
        code <- map["code"]
    }

}
