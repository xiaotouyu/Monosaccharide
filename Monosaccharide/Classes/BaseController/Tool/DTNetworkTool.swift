//
//  DTNetworkTool.swift
//  Monosaccharide
//
//  Created by dashuios126 on 17/2/20.
//  Copyright © 2017年 dashuios126. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SVProgressHUD
import ObjectMapper


class DTNetworkTool: NSObject {

    /// 单例
    static let shareNetWorkTool = DTNetworkTool()

    /// 获取首页轮播图数据
    ///
    func loadHomeAdvertisingData(_ finish:@escaping (_ advertising: [DTAdvertising])-> ()){
        let url = BASE_URL + "v1/banners?channel=iOS"

        Alamofire.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: [:]).responseJSON { (response) in

            guard response.result.isSuccess else {
                SVProgressHUD.showError(withStatus: "加载失败...")
                return
            }
            if let advertising = Mapper<BaseModel>().map(JSON: response.result.value as! [String : Any] ) {

                guard advertising.code == RETURN_OK else {
                    SVProgressHUD.showInfo(withStatus: advertising.message)
                    return
                }
                SVProgressHUD.dismiss()

                if let bannerss = advertising.data?.banners {
                    var dt_banners = [DTAdvertising]()
                    for ban in bannerss {
                        print("ban == \(ban.image_url)")
                        dt_banners.append(ban)
                    }
                    finish(dt_banners)
                }
            }
        }
    }

    /// 顶部导航栏数据
    ///
    /// - Parameter finished:
    func loadHomeTopData(_ finished:@escaping (_ ym_channels: [DTChannel]) -> ()) {
//        let url = BASE_URL + "v2/channels/preset?gender=1&generation=1"
        let url = BASE_URL + "v2/channels/preset?gender=1&generation=0"
//        let params = ["gender":1,"generation":1]

        Alamofire.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: [:]).responseJSON { (response) in
//            print(response)
            guard response.result.isSuccess else {
                SVProgressHUD.showError(withStatus: "加载失败...")
                return
            }

            if let value = response.result.value {
                let dict = JSON(value)
                let code = dict["code"].intValue
                let message = dict["message"].stringValue

                guard code == RETURN_OK else {
                    SVProgressHUD.showInfo(withStatus: message)
                    return
                }
                SVProgressHUD.dismiss()
                let data = dict["data"].dictionary
                if let channels = data?["channels"]?.arrayObject{
                    var ym_channels = [DTChannel]()
                    for channel in channels {
                        let ym_channel = DTChannel(dict: channel as! [String : AnyObject])
                        ym_channels.append(ym_channel)
                    }
//                    print(ym_channels)
                    finished(ym_channels)
                }
            }
        }
    }

    ///首页数据
    func loadHomeInfo(_ params: Dictionary<String, Int>, finished:@escaping (_ homeItem: [DTHomeItems])->()){

        let id = params["id"]!
        let limit = params["limit"]!
        let offset = params["offset"]!
        let url = BASE_URL + "v1/channels/\(id)/items?gender=1&generation=1&limit=\(limit)&offset=\(offset)"
//        ?gender=1&generation=1&limit=20&offset=0
        SVProgressHUD.show(withStatus: "正在加载中...")
        Alamofire.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: [:]).responseJSON { (response) in

            guard response.result.isSuccess else {
                SVProgressHUD.showError(withStatus: "加载失败...")
                return
            }

            if let homeModel = Mapper<DTHomeBaseModel>().map(JSON: response.result.value as! [String : Any]) {
                guard homeModel.code == RETURN_OK else{
                    SVProgressHUD.showInfo(withStatus: homeModel.message)
                    return
                }
                SVProgressHUD.dismiss()
                if let items = homeModel.data?.items {
                    var itemsArray = [DTHomeItems]()
                    for item in items {
                        itemsArray.append(item)
                    }
                    finished(itemsArray)
                }
            }
        }
    }

    func loadSearchData(_ finished:@escaping (_ searchItem: DTSearchData)->()){
        let url = BASE_URL + "v1/search/hot_words?"
        SVProgressHUD.show(withStatus: "正在加载中...")
        Alamofire.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: [:]).responseJSON{ (response) in

            guard response.result.isSuccess else{
                SVProgressHUD.showError(withStatus: "加载失败...")
                return
            }
            let searchModel = Mapper<DTSearchModel>().map(JSON: response.result.value as! [String : Any])
            guard searchModel?.code == RETURN_OK else{
                SVProgressHUD.showInfo(withStatus: searchModel?.message)
                return
            }

            SVProgressHUD.dismiss()
            let data = searchModel?.data

            finished(data!)
        }
    }
    ///单品栏数据
    func loadSingleProductData(_ params: Dictionary<String, Int>, finished:@escaping (_ singleProductItem: [DTSingleProductDataItems])-> ()){

        let limit = params["limit"]!
        let offset = params["offset"]!
        let url = BASE_URL + "v2/items?gender=1&generation=0&limit=\(limit)&offset=\(offset)"
//        http://api.dantangapp.com/v2/items?gender=1&generation=0&limit=20&offset=0
        Alamofire.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: [:]).responseJSON { (response) in
            guard response.result.isSuccess else{
                SVProgressHUD.showError(withStatus: "加载失败...")
                return
            }

            if let singleProductModel = Mapper<DTSingleProductItem>().map(JSON: response.result.value as! [String : Any]){

                guard singleProductModel.code == RETURN_OK else{
                    SVProgressHUD.showInfo(withStatus: singleProductModel.message)
                    return
                }
                SVProgressHUD.dismiss()
                if let items = singleProductModel.data?.items {
                    var itemArray = [DTSingleProductDataItems]()

                    for itemsData in items {
                        if let item = itemsData.itemData {
                            itemArray.append(item)

                        }
                    }
                    finished(itemArray)
                }
            }

        }
    }
    ///单品数据详情
    func loadProductDetailData(_ id: Int, finished:@escaping(_ productItem: DTProductDetailData)->()){
        let url = BASE_URL + "v2/items/\(id)"
        Alamofire.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: [:]).responseJSON { (response) in

            guard response.result.isSuccess else{
                SVProgressHUD.showError(withStatus: "加载失败...")
                return
            }

            if let model = Mapper<DTProductDetailBaseModel>().map(JSON: response.result.value as! [String : Any] ){
                guard model.code == RETURN_OK else{
                    SVProgressHUD.showInfo(withStatus: model.message)
                    return
                }
                SVProgressHUD.dismiss()
                if let data = model.data {
                    finished(data)
                }
            }
        }
    }
    //分类下的专题合集
    func loadClassicationData(finished:@escaping (_ classicationItem: [DTClassicationProjectCollections])->()){
        //http://api.dantangapp.com/v1/collections?limit=6&offset=0
        let url = BASE_URL + "v1/collections?limit=6&offset=0"
        Alamofire.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: [:]).responseJSON{ (response) in
            guard response.result.isSuccess else{
                SVProgressHUD.showError(withStatus: "加载失败...")
                return
            }
            if let model = Mapper<DTClassicationProjectModel>().map(JSON: response.value as! [String : Any]){
                guard model.code == RETURN_OK else{
                    SVProgressHUD.showInfo(withStatus: model.message)
                    return
                }
                SVProgressHUD.dismiss()
                if let collections = model.data.collections {
                    var dataArray = [DTClassicationProjectCollections]()
                    for item in collections {
                        dataArray.append(item)
                    }
                    finished(dataArray)
                }
            }

        }

    }
    //分类下的风格
    func loadClassicationStyleData(finished:@escaping (_ groupsItem: [DTClassificationStyleChannel_groups])-> ()){
        let url = BASE_URL + "v1/channel_groups/all?"
        Alamofire.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: [:]).responseJSON { (response) in
            guard response.result.isSuccess else{
                SVProgressHUD.showError(withStatus: "加载失败...")
                return
            }
            if let model = Mapper<DTClassificationStyleChannels>().map(JSON: response.result.value as! [String : Any]){
                guard model.code == RETURN_OK else{
                    SVProgressHUD.showInfo(withStatus: model.message)
                    return
                }
                SVProgressHUD.dismiss()
                if let channel_groups = model.data.channel_groups {
                    var itemArray = [DTClassificationStyleChannel_groups]()
                    for channels in channel_groups {
                        itemArray.append(channels)
//                        var finished = [[DTClassificationStyleChannels]]()
//                        for channel_item in channels.channels {
//                            finished.append([channel_item])
//                        }
//                        finished(finished)
                    }
                    finished(itemArray)
                }
            }
        }
    }


}
