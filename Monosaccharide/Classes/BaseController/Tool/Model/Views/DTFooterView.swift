//
//  DTFooterView.swift
//  Monosaccharide
//
//  Created by dashuios126 on 17/3/2.
//  Copyright © 2017年 dashuios126. All rights reserved.
//

import UIKit

class DTFooterView: UIView {

    fileprivate weak var collectionView: UICollectionView?
    fileprivate weak var historyLabel: UILabel?

    open var historyList: [String]? = [String]()
//    {
//        didSet{
//
////            guard (historyList?.count)! == 1 else {
////                collectionView?.reloadData()
////                return
////            }
////            setCollectionView()
////            collectionView?.reloadData()
//            print("historyList")
//        }
//    }


    fileprivate func setCollectionView(){

        let history = UILabel(frame: CGRect(x: 10.0, y: 5, width: SCREENW, height: 20.0))
        history.text = "搜索历史"
        history.textColor = DTLineGlobalColor()
        history.font = UIFont.systemFont(ofSize: 12)
        history.isHidden = true
        addSubview(history)
        historyLabel = history

        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: (SCREENW-50)/4, height: 30)
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 5

        let collectionView = UICollectionView(frame:  CGRect(x: 0, y: 30, width: Int(SCREENW), height: Int(frame.height)), collectionViewLayout: layout)
        collectionView.showsVerticalScrollIndicator = false
        //        collectionView.showsHorizontalScrollIndicator = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor.white
        addSubview(collectionView)
        collectionView.register(DTSearchRecordCollectionViewCell.self, forCellWithReuseIdentifier: cellIdentifier)
        self.collectionView = collectionView

    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setCollectionView()
//        print("init \(frame)")
    }

    public func reloadData(data: [String]){
        historyList = data
        historyLabel?.isHidden = false
        collectionView?.reloadData()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setView(){

        let width = (SCREENW-50)/4
        let height: CGFloat = 30.0
        let margin: CGFloat = 10.0

        guard (historyList != nil) else {
            return
        }
        for (index, item) in (historyList?.enumerated())! {

            let row = index / 4
            let col = index % 4
            let x = margin + (CGFloat(col)*(width+margin))
            let y = margin+(CGFloat(row)*(height + margin))
            let btn = UIButton(frame: CGRect(x: x, y: y, width: width, height: height))
            btn.setTitle(item, for: .normal)
            btn.setTitleColor(DTLineGlobalColor(), for: .normal)
            btn.titleLabel?.font = UIFont.systemFont(ofSize: 12)
            btn.titleLabel?.adjustsFontSizeToFitWidth = true
            btn.layer.borderWidth = 1
            btn.layer.borderColor = DTLineGlobalColor().cgColor
            btn.layer.cornerRadius = 5
            btn.addTarget(self, action: #selector(clickFooter), for: .touchUpInside)
            addSubview(btn)
        }
    }
    func clickFooter(){

//        print("clickFooter")
    }

}


extension DTFooterView: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{

    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! DTSearchRecordCollectionViewCell

        cell.title = historyList?[indexPath.item]
        return cell

    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        print("count \(historyList?.count)")
        return historyList?.count ?? 0
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
