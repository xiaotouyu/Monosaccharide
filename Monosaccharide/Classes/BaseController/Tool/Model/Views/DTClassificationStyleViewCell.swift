//
//  DTClassificationStyleViewCell.swift
//  Monosaccharide
//
//  Created by dashuios126 on 17/3/10.
//  Copyright © 2017年 dashuios126. All rights reserved.
//

import UIKit

class DTClassificationStyleViewCell: UICollectionViewCell {

    fileprivate var displayImageView: UIImageView!
    fileprivate var contentLabel: UILabel!

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor.white

        displayImageView = UIImageView()
//        displayImageView.layer.cornerRadius = frame.width/2
//        displayImageView.layer.masksToBounds = true
        displayImageView.contentMode = .scaleAspectFill
        addSubview(displayImageView)
        displayImageView.snp.makeConstraints { (make) in
            make.top.equalTo(0)
            make.left.equalTo(10)
            make.width.equalTo(77)
            make.height.equalTo(77)
        }

        contentLabel = UILabel()
        contentLabel.textColor = DTLineGlobalColor()
        contentLabel.font = UIFont.systemFont(ofSize: 12)
        contentLabel.textAlignment = .center
        addSubview(contentLabel)
        contentLabel.snp.makeConstraints { (make) in
            make.top.equalTo(displayImageView.snp.bottom)
            make.left.equalTo(displayImageView)
            make.width.equalTo(displayImageView)
            make.height.equalTo(20)
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    open var item: DTClassificationStyleChannels? {
        didSet{

            displayImageView.kf.setImage(with: URL(string: (item?.icon_url!)!))
            contentLabel.text = item?.channels_name
        }
    }
}
