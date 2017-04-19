//
//  DTSingleProductDetailModel.swift
//  Monosaccharide
//
//  Created by dashuios126 on 17/3/9.
//  Copyright © 2017年 dashuios126. All rights reserved.
//

import UIKit

import ObjectMapper

class DTProductDetailBaseModel :Mappable{
    var message: String!
    var data: DTProductDetailData!
    var code: Int = 0

    required init?(map: Map) {

    }

    func mapping(map: Map) {

        message <- map["message"]
        data <- map["data"]
        code <- map["code"]

    }
}

class DTProductDetailDataSource :DTProductDetailData{
    var page_title: String!
    var button_title: String!
    var sourceName: String!
    var type: String!
    required init?(map: Map) {
        super.init(map: map)
    }

    override func mapping(map: Map) {
        super.mapping(map: map)
        page_title <- map["code"]
        button_title <- map["button_title"]
        sourceName <- map["sourceName"]
        type <- map["type"]

    }
}

class DTProductDetailData :DTProductDetailBaseModel{

    var description: String!
    var cover_image_url: String!
    var liked: Bool = false
    var source: DTProductDetailDataSource!
    var authentic: String!
    var editor_id: Int = 0
    var url: String!
    var purchase_url: String!
    var image_urls: [String]!
    var updated_at: Int = 0
    var comments_count: Int = 0
    var purchase_type: Int = 0
    var brand_id: String!
    var favorited: Bool = false
    var detail_html: String!
    var name: String!
    var post_ids: [Any] = []
    var favorites_count: Int = 0
    var id: Int = 0
    var purchase_status: Int = 0
    var shares_count: Int = 0
    var purchase_id: String!
    var brand_order: Int = 0
    var likes_count: Int = 0
    var subcategory_id: String!
    var created_at: Int = 0
    var price: String!
    var category_id: String!

    required init?(map: Map) {
        super.init(map: map)
    }

    override func mapping(map: Map) {
        super.mapping(map: map)
        description <- map["description"]
        cover_image_url <- map["cover_image_url"]
        liked <- map["liked"]
        source <- map["source"]
        authentic <- map["authentic"]
        editor_id <- map["editor_id"]
        url <- map["url"]
        purchase_url <- map["purchase_url"]
        image_urls <- map["image_urls"]
        updated_at <- map["updated_at"]
        comments_count <- map["comments_count"]
        purchase_type <- map["purchase_type"]
        brand_id <- map["brand_id"]
        favorited <- map["favorited"]
        detail_html <- map["detail_html"]
        name <- map["name"]
        post_ids <- map["post_ids"]
        favorites_count <- map["favorites_count"]
        id <- map["id"]
        purchase_status <- map["purchase_status"]
        shares_count <- map["shares_count"]
        purchase_id <- map["purchase_id"]
        brand_order <- map["brand_order"]
        likes_count <- map["likes_count"]
        subcategory_id <- map["subcategory_id"]
        created_at <- map["created_at"]
        price <- map["price"]
        category_id <- map["category_id"]

    }

}
