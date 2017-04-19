//
//  DTSearchRecordView.swift
//  Monosaccharide
//
//  Created by dashuios126 on 17/2/28.
//  Copyright © 2017年 dashuios126. All rights reserved.
//

import UIKit

class DTSearchRecordView: UIView {

    fileprivate let cellIdentifier = "searchCell"
    fileprivate weak var collectionView: UICollectionView?
    fileprivate var footerView: DTFooterView!

    open var results: [String]? {
        didSet{
            self.collectionView?.reloadData()
        }
    }
    fileprivate var historyList: [String]? = [String](){
        didSet{
//            print(historyList ?? 0)
            footerView.isHidden = false
            footerView.reloadData(data: historyList!)
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        DTNetworkTool.shareNetWorkTool.loadSearchData { [weak self](item) in

//            print("item------- \(item.hot_words)")
            self?.results = item.hot_words
            self?.setCollectionView()
            self?.setFooterView()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    fileprivate func setCollectionView(){

        let headLabel = UILabel(frame: CGRect(x: 10, y: 0, width: SCREENW, height: 30))
        headLabel.textColor = UIColor.black
        headLabel.font = UIFont.systemFont(ofSize: 12)
        headLabel.text = "大家都在搜"
        addSubview(headLabel)

        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: (SCREENW-50)/4, height: 30)
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 5
        let height = 25+((results?.count)!/4*30 + 5)
        let collectionView = UICollectionView(frame:  CGRect(x: 0, y: 30, width: Int(SCREENW), height: height), collectionViewLayout: layout)
        collectionView.showsVerticalScrollIndicator = false
//        collectionView.showsHorizontalScrollIndicator = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor.white
        addSubview(collectionView)
        collectionView.register(DTSearchRecordCollectionViewCell.self, forCellWithReuseIdentifier: cellIdentifier)

        self.collectionView = collectionView

    }

    func setFooterView(){

        let height = 55+((results?.count)!/4*30 + 5)
        footerView = DTFooterView(frame: CGRect(x: 0.0, y: (collectionView?.y)!+(collectionView?.height)!+5, width: SCREENW, height: CGFloat(height)))
//        footerView.backgroundColor = randomColor()
        addSubview(footerView)

//        footerView.snp.makeConstraints { (make) in
//            make.top.equalTo((history.snp.bottom))
//            make.left.equalTo(collectionView!)
//            make.height.equalTo(height)
//        }
        footerView.historyList = historyList!
    }
}

extension DTSearchRecordView: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{

    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! DTSearchRecordCollectionViewCell

        cell.title = results?[indexPath.item]
        return cell

    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        print("count \(results?.count)")
        return results?.count ?? 0
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    //返回cell 上下左右的间距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets{
//        return UIEdgeInsetsMake(5, 10, 5, 10)
        return UIEdgeInsetsMake(0, 10, 0, 10)
    }


    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        print("didSelectItemAt")
        let itemString = results?[indexPath.item]
        if !((historyList?.contains(itemString!))!) {
            historyList?.append(itemString!)
        }
    }

    //分组头部、尾部
//    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
//        switch kind{
//
//        case UICollectionElementKindSectionFooter:
//
//            let footView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionFooter, withReuseIdentifier: "footerView", for: indexPath) as! DTFooterView
//            footView.historyList = historyList
//            
//            return footView
//
//        default:
//            return UICollectionReusableView()
//
//        }
//    }
//
//        //返回分组脚部视图的尺寸，在这里控制分组脚部视图的高度
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
////        guard (historyList?.count)! > 0 else {
////            return CGSize(width: 0, height: 0)
////        }
////        let height = (historyList?.count)! / 5 * 30
////        return CGSize(width: SCREENW, height: CGFloat(height))
//        return CGSize(width: SCREENW, height: 100)
//    }

}

















