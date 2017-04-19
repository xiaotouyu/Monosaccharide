//
//  ZYColumnDownPromptView.swift
//  掌上遂宁
//
//  Created by 张宇 on 2016/10/10.
//  Copyright © 2016年 张宇. All rights reserved.
//

import UIKit

class ZYColumnDownPromptView: UIView {

    fileprivate var label: UILabel!
    override init(frame: CGRect) {
        super.init(frame: frame)
//        // 初始化提示label
        label = UILabel(frame:CGRect(x: kColumnMarginW, y: 0, width: 150, height: frame.height))
        label.text = "点击添加更多频道"
        label.textColor = UIColor.darkGray
        label.font = UIFont.systemFont(ofSize: 14)
//        label.backgroundColor = UIColor.init(red: 240.0/255, green: 241.0/255, blue: 246.0/255, alpha: 1.0)
        label.isHidden = isHidden
        addSubview(label)


    }


    open var isHiddenMore = true{
        didSet{
            if !isHiddenMore {
                label.isHidden = false
            }
        }
    }
//    init(frame: CGRect, isHidden: Bool) {
//        super.init(frame: frame)
//
//    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
