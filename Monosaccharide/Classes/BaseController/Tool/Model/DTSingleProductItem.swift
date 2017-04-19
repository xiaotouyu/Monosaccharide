//
//  DTSingleProductItem.swift
//  Monosaccharide
//
//  Created by dashuios126 on 17/3/7.
//  Copyright © 2017年 dashuios126. All rights reserved.
//

import UIKit

import ObjectMapper

class DTSingleProductItem: Mappable {

    open var code: Int = 0
    open var message: String?
    open var data: DTSingleProductData?
    required init?(map: Map) {

    }

    func mapping(map: Map) {
        code <- map["code"]
        message <- map["message"]
        data <- map["data"]
    }
}

class DTSingleProductData: DTSingleProductItem {

    open var items: [DTSingleProductItemData]?
    open var paging: Dictionary<String, String> = ["next_url": ""]

    required init?(map: Map) {
        super.init(map: map)
    }
    override func mapping(map: Map) {
        super.mapping(map: map)
        items <- map["items"]
        paging <- map["paging"]
    }
}

class DTSingleProductItemData: DTSingleProductData {

    open var itemData: DTSingleProductDataItems?

    required init?(map: Map) {
        super.init(map: map)
    }
    override func mapping(map: Map) {
        super.mapping(map: map)
        itemData <- map["data"]
    }
}

class DTSingleProductDataItems: DTSingleProductItemData {

    open var brand_id: Int = 0
    open var brand_order: Int = 0
    open var category_id: Int = 0
    open var cover_image_url: String?
    open var description: String?
    open var image_urls: [String]?
    open var created_at: Int = 0
    open var editor_id: Int = 0
    open var favorites_count: Int = 0
    open var id: Int = 0
    open var is_favorite: Bool = false
    open var name: String?
    open var post_ids: [Any]?
    open var price: String?
    open var purchase_id: Int = 0
    open var purchase_status: Int = 0
    open var purchase_type: Int = 0
    open var purchase_url: String?
    open var subcategory_id: Int = 0
    open var updated_at: Int = 0
    open var url: String?

    required init?(map: Map) {
        super.init(map: map)
    }
    override func mapping(map: Map) {
        super.mapping(map: map)
        brand_id <- map["brand_id"]
        brand_order <- map["brand_order"]
        category_id <- map["category_id"]
        cover_image_url <- map["cover_image_url"]
        description <- map["description"]
        image_urls <- map["image_urls"]
        editor_id <- map["editor_id"]
        favorites_count <- map["favorites_count"]
        id <- map["id"]
        is_favorite <- map["is_favorite"]
        name <- map["name"]
        post_ids <- map["post_ids"]
        price <- map["price"]
        purchase_id <- map["purchase_id"]
        purchase_status <- map["purchase_status"]
        purchase_type <- map["purchase_type"]
        purchase_url <- map["purchase_url"]
        subcategory_id <- map["subcategory_id"]
        updated_at <- map["updated_at"]
        url <- map["url"]
    }
}



