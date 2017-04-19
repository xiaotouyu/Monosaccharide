//
//  DTSearchRecordCollectionViewCell.swift
//  Monosaccharide
//
//  Created by dashuios126 on 17/3/1.
//  Copyright © 2017年 dashuios126. All rights reserved.
//

import UIKit

class DTSearchRecordCollectionViewCell: UICollectionViewCell {
    open var label: UILabel!
    open var title: String? = ""{
        didSet{

            label.text = title
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)

        label = UILabel(frame: CGRect(x: 0.0, y: 0.0, width: frame.width, height: frame.height))
//        label = UILabel()
//        label.sizeToFit()
        label.textColor = UIColor.lightGray
        label.font = UIFont.systemFont(ofSize: 12)
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .center
        label.layer.borderWidth = 1
        label.layer.borderColor = UIColor.lightGray.cgColor
        label.layer.cornerRadius = 5
        contentView.addSubview(label)
    }

//    open func setTitle(_ title: String){
//        label.text = title
//    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
