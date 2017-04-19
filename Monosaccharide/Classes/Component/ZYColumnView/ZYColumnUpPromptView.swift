//
//  ZYColumnUpPromptView.swift
//  掌上遂宁
//
//  Created by 张宇 on 2016/10/10.
//  Copyright © 2016年 张宇. All rights reserved.
//

import UIKit

typealias editBtnClickClosure = (_ isSelected : Bool) -> Void

class ZYColumnUpPromptView: UIView {
    
    var editBtn : UIButton?
    // 编辑按钮回调闭包
    var clickClosure : editBtnClickClosure?
    
    override init(frame: CGRect) {
        super.init(frame:frame)
        // 初始化子控件
        let label = UILabel(frame: CGRect(x: kColumnMarginW, y: 0, width: 100, height: kColumnViewH))
        label.text = "切换频道"
        label.textColor = UIColor.darkGray
        label.font = UIFont.systemFont(ofSize: 14)
        addSubview(label)
        
        // 切换状态按钮
        let editBtn = UIButton(frame: CGRect(x: kColumnViewW - kColumnViewH - kColumnEditBtnW - 10, y: kColumnViewH-kTitlesViewH, width: kColumnEditBtnW, height: kTitlesViewH))
//        editBtn.backgroundColor = UIColor.cyan
        self.editBtn = editBtn
        editBtn.setTitle(kColumnEditBtnNorTitle, for: .normal)
        editBtn.setTitle(kColumnEditBtnSelTitle, for: .selected)

        editBtn.titleLabel?.font = UIFont.systemFont(ofSize: kColumnEditBtnFont)
        editBtn.setTitleColor(kColumnItemColor, for: .normal)
//        editBtn.sizeToFit()
//        editBtn.layer.borderWidth = 1.0
//        editBtn.layer.borderColor = kColumnItemBorderColor
//        editBtn.layer.cornerRadius = kColumnEditBtnH * 0.5
        editBtn.addTarget(self, action: #selector(self.editButtonClick(editBtn:)), for: .touchUpInside)
        addSubview(editBtn)

        let vLine = UILabel()
        vLine.frame = CGRect(x: SCREENW - kTitlesViewH-1, y: 10, width: 1, height: 20)
        vLine.backgroundColor = DTLineGlobalColor()
        addSubview(vLine)

        let line = UILabel()
        line.frame = CGRect(x: 0, y: label.height+label.y, width: SCREENW, height: 1)
        line.backgroundColor = DTLineGlobalColor()
        addSubview(line)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - 点击事件监听
    @objc open func editButtonClick(editBtn: UIButton) {
        editBtn.isSelected = !editBtn.isSelected
        if self.clickClosure != nil {
            self.clickClosure!(editBtn.isSelected)
        }
    }
}
