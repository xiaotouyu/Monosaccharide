//
//  DTCollectionView.swift
//  Monosaccharide
//
//  Created by dashuios126 on 17/3/7.
//  Copyright © 2017年 dashuios126. All rights reserved.
//

import UIKit



class DTCollectionView: UIView {

    fileprivate weak var dt_collectionView: UICollectionView?
    fileprivate weak var titleLabel: UILabel!
    fileprivate var oneCreate: Bool = true {
        didSet{

        }
    }

    open var text: String? {
        didSet{
            titleLabel.text = text 
        }
    }
    var projectItems = [DTClassicationProjectCollections]() {
        didSet{
            let moreBtn = UIButton(frame: CGRect(x: frame.width-70,y: 10,width: 60, height: 30))
            moreBtn.setTitle("查看更多", for: .normal)
            moreBtn.setTitleColor(UIColor.lightGray, for: .normal)
            moreBtn.setImage(UIImage(named: "btn_forward_nightmode_8x12_"), for: .normal)
            moreBtn.titleLabel?.font = UIFont.systemFont(ofSize: 12)

            moreBtn.titleLabel?.backgroundColor = moreBtn.backgroundColor
            moreBtn.imageView?.backgroundColor = moreBtn.backgroundColor

            moreBtn.imageEdgeInsets = UIEdgeInsetsMake(0, (moreBtn.titleLabel?.frame.width)!, 0, -(moreBtn.titleLabel?.frame.width)!)
            moreBtn.titleEdgeInsets = UIEdgeInsetsMake(0, -(moreBtn.imageView?.frame.width)!, 0,(moreBtn.imageView?.frame.width)!)
            moreBtn.addTarget(self, action: #selector(clickMore), for: .touchUpInside)
            addSubview(moreBtn)
        }
    }
    var styleItems = [DTClassificationStyleChannels]()
    var categoryItems = [DTClassificationStyleChannels]()
    fileprivate var styleCell: String?

     init(frame: CGRect, style: String?) {
        super.init(frame: frame )
        print("DTCollectionView \(frame)")
        styleCell = style
        let title = UILabel(frame: CGRect(x: 10,y: 10,width: frame.width-80, height: 30))
        title.textColor = UIColor.lightGray
        title.text = text ?? "专题合集"
        title.font = UIFont.systemFont(ofSize: 14)
        addSubview(title)
        titleLabel = title


        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumLineSpacing = 10
        flowLayout.minimumInteritemSpacing = 10
        flowLayout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: CGRect(x: 0,y: 50,width: frame.width, height: frame.height-50), collectionViewLayout: flowLayout)//CGRect(x: 0,y: 0,width: SCREENW, height: SCREENH)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = DTWhiteColor()

        addSubview(collectionView)
        dt_collectionView = collectionView

        registerCell(collectionView)
    }

    func clickMore() {

    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension DTCollectionView: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{


    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return getItemNumber()
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return create(collectionView, indexPath: indexPath, style: styleCell!)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return getItemSize()
    }
    func create(_ collectionView: UICollectionView, indexPath: IndexPath, style: String) -> UICollectionViewCell {

        if style == "projectCell" {
           let cell = collectionView.dequeueReusableCell(withReuseIdentifier: style, for: indexPath) as! DTClassificationCollectionViewCell
            cell.imageUrl = projectItems[indexPath.item].banner_image_url
            
            return cell
        }else if style == "StyleCell" {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: style, for: indexPath) as! DTClassificationStyleViewCell
            cell.item = styleItems[indexPath.item]
            return cell
        }else if style == "CategoryCell" {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: style, for: indexPath) as! DTClassificationStyleViewCell
            cell.item = categoryItems[indexPath.item]
            
            return cell
        }

        return UICollectionViewCell()
    }

    func getItemSize() -> CGSize {
        if styleCell == "projectCell" {
            return CGSize(width: 150, height: 75)
        }else if styleCell == "StyleCell" {
            return CGSize(width: (SCREENW-50)/4, height: 100)
        }else if styleCell == "CategoryCell" {
            return CGSize(width: (SCREENW-50)/4, height: 100)
        }
        return CGSize(width: 0, height: 0)
    }

    func getItemNumber() -> Int {
        if styleCell == "projectCell" {
            return projectItems.count
        }else if styleCell == "StyleCell" {
            return styleItems.count
        }else if styleCell == "CategoryCell" {
            return categoryItems.count
        }
        return 0
    }

    func registerCell(_ collectionView: UICollectionView) {
        if styleCell == "projectCell" {
            collectionView.register(DTClassificationCollectionViewCell.self, forCellWithReuseIdentifier: styleCell!)
        }else if styleCell == "StyleCell" {

            collectionView.register(DTClassificationStyleViewCell.self, forCellWithReuseIdentifier: styleCell!)
        }else if styleCell == "CategoryCell" {

            collectionView.register(DTClassificationStyleViewCell.self, forCellWithReuseIdentifier: styleCell!)
        }
    }
}
