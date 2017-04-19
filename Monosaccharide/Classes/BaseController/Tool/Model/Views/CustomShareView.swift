//
//  CustomShareView.swift
//  CustomShareView
//
//  Created by dashuios126 on 17/3/15.
//  Copyright © 2017年 dashuios126. All rights reserved.
//

import UIKit

protocol CustomShareViewDelegate {
    func shareToPlatWithIndex(_ index: Int, title: String)
}

class CustomShareView: UIView {
    open var title: String?  {
        didSet{
            titleLabel.text = title ?? "分享"
        }
    }
    open var delegate: CustomShareViewDelegate?
    fileprivate var bgView: UIView!
    fileprivate var iconView: UIView!
    fileprivate var titleLabel: UILabel!
    init(frame: CGRect, sourceArray: [String], iconArray: [String]){
        super.init(frame: frame)

        createShareAcitonView(frame: frame, sourceArray: sourceArray, iconArray: iconArray)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
extension CustomShareView {
    fileprivate func createShareAcitonView(frame: CGRect,sourceArray: [String], iconArray: [String]){

        titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: bounds.width, height: 30))
        titleLabel.textAlignment = .center
        titleLabel.text = "分享"
        titleLabel.font = UIFont.systemFont(ofSize: 18)
        titleLabel.backgroundColor = UIColor(red: 242, green: 245, blue: 247, alpha: 1.0)
        addSubview(titleLabel)

        let count = sourceArray.count

        let horizeSpace: CGFloat = (frame.width - 60.0*4.0) / 5.0
        let verticalSpace: CGFloat = 10.0
        iconView = UIView()
        iconView.backgroundColor = UIColor(red: 242, green: 245, blue: 247, alpha: 1.0)
        addSubview(iconView)


        for index in 0..<count {
            let column = index%4
            let row = index/4
            let bX = Int(horizeSpace) + (Int(horizeSpace) + 60)*column
            let bY = 5 + (Int(verticalSpace) + 70)*row
            iconView.frame = CGRect(x: 0, y: 30, width: Int(frame.width), height: bY+100)

            let buttonView = ShareActionButtonView(frame: CGRect(x: bX, y: bY, width: 60, height:70), iconName: iconArray[index], title: sourceArray[index])
            buttonView.tag = index
            buttonView.backgroundColor = iconView.backgroundColor
            buttonView.addTarget(self, action: #selector(shareToMultPlat(sender:)), for: .touchUpInside)
            iconView.addSubview(buttonView)
        }
    }

    func shareToMultPlat(sender: ShareActionButtonView) {

        if delegate != nil {
            actionViewDissmiss()
            delegate?.shareToPlatWithIndex(sender.tag, title: sender.title!)
        }
    }
}

extension CustomShareView {


    func actionViewDissmiss() {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        appDelegate?.window?.backgroundColor = UIColor.white

        UIView.animate(withDuration: 0.35, animations: {
            self.frame = CGRect(x: 0, y: UIScreen.main.bounds.size.height, width: self.frame.width, height: self.frame.height)

        }) { (finished) in
            self.bgView.removeFromSuperview()
        }
    }
    func actionViewShow() {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate

        bgView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        bgView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3)
        appDelegate?.window?.addSubview(bgView)
        let tapRecongnizer = UITapGestureRecognizer(target: self, action:#selector(tapBgviewClick))
        tapRecongnizer.numberOfTapsRequired = 1
        bgView.addGestureRecognizer(tapRecongnizer)
        bgView.isUserInteractionEnabled = true

        appDelegate?.window?.addSubview(self)
        UIView.animate(withDuration: 0.35) { 
            self.frame = CGRect(x: 0, y: UIScreen.main.bounds.height - self.iconView.frame.height, width: self.frame.width, height: self.iconView.frame.height)
        }
    }
    func tapBgviewClick() {
        actionViewDissmiss()
    }
}

class ShareActionButtonView: UIButton {

    open var title: String?
    init(frame: CGRect, iconName: String, title: String) {
        super.init(frame: frame)
        self.title = title
        let iconImageview = UIImageView(frame: CGRect(x: 10, y: 5, width: 40, height: 40))
        iconImageview.image = UIImage(named: iconName);
        addSubview(iconImageview)

        let label = UILabel(frame: CGRect(x: 0, y: iconImageview.frame.maxY+5, width: frame.width, height: 15))
        label.text = title;
        label.textAlignment = .center;
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = UIColor.lightGray
        addSubview(label)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}





