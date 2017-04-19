//
//  DTClassificationCollectionViewCell.swift
//  Monosaccharide
//
//  Created by dashuios126 on 17/3/10.
//  Copyright © 2017年 dashuios126. All rights reserved.
//

import UIKit

class DTClassificationCollectionViewCell: UICollectionViewCell {
    fileprivate var displayImageView: UIImageView!
    override init(frame: CGRect) {
        super.init(frame: frame)

        backgroundColor = UIColor.white

//        displayImageView = UIImageView(frame: frame)
        displayImageView = UIImageView()
        displayImageView.layer.cornerRadius = 5
        displayImageView.layer.masksToBounds = true
        displayImageView.contentMode = .scaleAspectFill
        addSubview(displayImageView)
        displayImageView.snp.makeConstraints { (make) in
            make.top.equalTo(0)
            make.left.equalTo(10)
            make.width.equalTo(frame.width)
            make.height.equalTo(frame.height)
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    open var imageUrl: String? {
        didSet{

            displayImageView.kf.setImage(with: URL(string: imageUrl!))
        }
    }
}
