//
//  DTSingleProductViewController.swift
//  Monosaccharide
//
//  Created by dashuios126 on 17/3/7.
//  Copyright © 2017年 dashuios126. All rights reserved.
//

import UIKit


class DTSingleProductViewController: DTBaseViewController {

    @IBOutlet weak var dt_collectionView: UICollectionView!

    fileprivate var limit: Int = 0
    fileprivate var offset: Int = 0
    
    fileprivate weak var singleProductView: DTCollectionView!


    fileprivate var itemData = [DTSingleProductDataItems]()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "单品"
        dt_collectionView.backgroundColor = DTGlobalColor()
        
        dt_collectionView.es_addPullToRefresh {
            self.loadSingleData()
        }
        dt_collectionView.es_startPullToRefresh()


    }

    func loadSingleData(){
        limit = 20
        offset = 0
        let params: Dictionary<String,Int> = ["limit": self.limit,"offset": self.offset]
        DTNetworkTool.shareNetWorkTool.loadSingleProductData(params) { (items) in

            self.itemData.append(contentsOf: items)
            self.dt_collectionView.es_stopPullToRefresh()
            self.dt_collectionView.reloadData()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

extension DTSingleProductViewController: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{

    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "singleProductCell", for: indexPath) as! DTSingleProductCollectionViewCell

        cell.itemList = itemData[indexPath.item]
        cell.favouriteBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -5, 0, 0)
        return cell

    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //        print("count \(results?.count)")
        return itemData.count
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    //返回cell 上下左右的间距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets{
        //        return UIEdgeInsetsMake(5, 10, 5, 10)
        return UIEdgeInsetsMake(5, 5, 5, 5)
    }


    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        let vc = DTSingleProductDetailViewController()
        vc.title = "商品详情"
        vc.id = itemData[indexPath.item].id
        navigationController?.pushViewController(vc, animated: true)

    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (SCREENW-15)/2, height: 245)
    }
}
