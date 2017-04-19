//
//  NavigationBarExtension.swift
//  ParallaxHeaderView
//
//  Created by wl on 15/11/5.
//  Copyright © 2015年 wl. All rights reserved.
//

import UIKit

var key: String = "coverView"

extension UINavigationBar {
    
    /// 定义的一个计算属性，如果可以我更希望直接顶一个存储属性。它用来返回和设置我们需要加到
    /// UINavigationBar上的View
    var coverView: UIView? {
        get {
            //这句的意思大概可以理解为利用key在self中取出对应的对象,如果没有key对应的对象就返回nil
            return objc_getAssociatedObject(self, &key) as? UIView
        }
        
        set {
            //与上面对应是重新设置这个对象，最后一个参数如果学过oc的话很好理解，就是代表这个newValue的属性
            //OBJC_ASSOCIATION_RETAIN_NONATOMIC意味着:strong,nonatomic
            objc_setAssociatedObject(self, &key, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    func setMyBackgroundColor(_ color: UIColor) {
        
        if self.coverView != nil {
            self.coverView!.backgroundColor = color
        }else {
            self.setBackgroundImage(UIImage(), for: .default)
            self.shadowImage = UIImage()
            let view = UIView(frame: CGRect(x: 0, y: -20, width: UIScreen.main.bounds.size.width, height: self.bounds.height + 20))
            view.isUserInteractionEnabled = false
            view.autoresizingMask = [.flexibleHeight, .flexibleWidth]
            self.insertSubview(view, at: 0)
            
            view.backgroundColor = color
            self.coverView = view
        }
    }
    
    func setMyBackgroundColorAlpha(_ alpha: CGFloat) {
        
        guard let coverView = self.coverView else {
            return
        }
        self.coverView!.backgroundColor = coverView.backgroundColor?.withAlphaComponent(alpha)
    }

    func setBackgroundImage() {
        // 设置导航栏半透明
        isTranslucent = true
        // 设置导航栏背景图片
        setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        // 设置导航栏阴影图片
        shadowImage = UIImage()
    }

    func setupBackgroundColor() {
        barTintColor = DTGlobalRedColor()
        tintColor = UIColor.white
        // 导航条默认设置为不透明
        isTranslucent = false
        setBackgroundImage(UIImage(named: "navi_bar_bg~iphone"), for: .default)
    }
}
