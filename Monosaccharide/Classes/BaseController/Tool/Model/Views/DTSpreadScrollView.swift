//
//  DTSpreadScrollView.swift
//  Monosaccharide
//
//  Created by dashuios126 on 17/2/20.
//  Copyright © 2017年 dashuios126. All rights reserved.
//

import UIKit

class DTSpreadScrollView: UIScrollView {

    override init(frame: CGRect) {

        super.init(frame: frame)
        let topView = UIView()
        topView.frame = CGRect(x: SCREENW - kTitlesViewH, y: 0, width: kTitlesViewH, height: kTitlesViewH)
        topView.backgroundColor = DTWhiteColor()
        addSubview(topView)
        // 选择按钮
        let arrowButton = UIButton()
        arrowButton.frame = CGRect(x: SCREENW - kTitlesViewH, y: 0, width: kTitlesViewH, height: kTitlesViewH)
        arrowButton.setImage(UIImage(named: "arrow_index_up_8x4_"), for: .normal)
        arrowButton.addTarget(self, action: #selector(arrowButtonClick(_:)), for: .touchUpInside)
        arrowButton.backgroundColor = DTWhiteColor()
        topView.addSubview(arrowButton)
    }

    /// 箭头按钮点击
    func arrowButtonClick(_ button: UIButton) {
        UIView.animate(withDuration: kAnimationDuration, animations: {
            button.imageView?.transform = button.imageView!.transform.rotated(by: CGFloat(M_PI))
        }) { (complete) in

//            self.view.addSubview(self.spreadView)

        }
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    open var arrayTitles = [String](){
        didSet {
            // 数据校验
            guard arrayTitles.count > 0 else {
                fatalError("if you want to use it, arrayTitles can not be nil ")
            }
            for _ in self.subviews {     // 已经初始化过了，直接return 避免赋值后重复执行下面的代码
                return
            }
            // 默认选中第0个栏目名称
//            selTitle = arrayTitles[0]
            // 初始化横向滚动scrollView
//            view.addSubview(hScrollView)
            // 初始化"展开"按钮
//            setupSpreadButton()
        }
    }
    // 备选 string 数组
    open var arraySpareTitles = [String]()
    // 固定不变的item 个数
    open var fixedCount = 1
    // 右边的展开按钮
    fileprivate var spreadBtn: UIButton = UIButton()
    // 是否 展开 标识
    fileprivate var toSpread:Bool = false
    // 用户当前选中的栏目名称
    fileprivate var selTitle = String()

    // MARK: - 懒加载
    /// 垂直展开的scrollView
    fileprivate lazy var spreadView:ZYColumnSpreadView = {
        let spreadView = ZYColumnSpreadView(frame: CGRect(x: 0, y: 0, width: SCREENW, height: 0.1))
        spreadView.arrayUpTitles = self.arrayTitles
        spreadView.arrayDownTitles = self.arraySpareTitles
        spreadView.backgroundColor = UIColor.init(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.9)
        spreadView.fixedCount = self.fixedCount
//        self.insertSubview(spreadView, belowSubview: self.hScrollView)
        self.addSubview(spreadView)

        spreadView.tapClosure = {
            [weak self](item : ZYColumnItem) -> Void in
            // 回调处理
            // 收起spreadView
            self!.spreadOrFlod()
            if self!.selTitle != item.title {       // 点击的不是当前选中的才设置，并且回传值
                // 这里可以拿到用户点击的具体title 如果用户已经删除之前选中的title 则认为用户选择了第0个
                self!.selTitle = (self!.arrayTitles.contains(item.title)) ? item.title : self!.arrayTitles[0]
//                self!.hScrollView.changeItemToSelected(title: self!.selTitle)
                // 代理传值
//                self!.delegate?.columnViewControllerSelectedTitle!(selectedTitle : self!.selTitle, index:
//                    self!.arrayTitles.index(of: self!.selTitle)!)
            }
        }
        spreadView.longPressClosure = {
            [weak self]() -> Void in
            // 模拟用户点击了一下edit按钮
            self!.upPromptView.editButtonClick(editBtn: self!.upPromptView.editBtn!)
        }
        spreadView.flodClosure = {
            [weak self](upArrayTitles : [String], downArrayTitles : [String]) -> Void in
            guard upArrayTitles != self!.arrayTitles else {     // 两个数组相等，说明没有变化，下面代码不用执行
                return
            }
            self!.arrayTitles = upArrayTitles
            self!.arraySpareTitles = downArrayTitles
//            self!.hScrollView.arrayTitles = upArrayTitles
            // 如果用户已经删除之前选中的title 则认为用户选择了第0个
            self!.selTitle = (upArrayTitles.contains(self!.selTitle)) ? self!.selTitle : self!.arrayTitles[0]
//            self!.hScrollView.changeItemToSelected(title: self!.selTitle)
            // 代理传值
//            self!.delegate?.columnViewControllerSelectedTitle!(selectedTitle: self!.selTitle, index:
//                self!.arrayTitles.index(of: self!.selTitle)!)
//            self!.delegate?.columnViewControllerTitlesDidChanged!(arrayTitles: self!.arrayTitles, spareTitles: self!.arraySpareTitles)

        }
        return spreadView
    }()


    /// 透明的cover,当展开状态，导航条覆盖一个cover,点击cover会收起
    lazy fileprivate var cover : UIButton = {
        let btn = UIButton(frame: CGRect(x: 0, y: 0, width: SCREENW , height: 64))
        btn.backgroundColor = UIColor(white: 1.0, alpha: 0.001)
        UIApplication.shared.keyWindow?.addSubview(btn)
        btn.addTarget(self, action: #selector(self.spreadBtnClick(spreadBtn:)), for: .touchUpInside)       //等价于点了展开按钮
        return btn
    }()
    /// 上提示view
    lazy var upPromptView : ZYColumnUpPromptView = {
        let upView = ZYColumnUpPromptView(frame: CGRect(x: 0, y: 0, width: kColumnViewW - kColumnViewH, height: kColumnViewH))
        upView.backgroundColor = UIColor.white
        // 闭包回调处理
        upView.clickClosure = {
            [weak self](isSelected : Bool) -> Void in
            // 编辑按钮 点击回调事件
            self!.spreadView.hideDownItemsAndPromptView(toHide: isSelected)
            self!.spreadView.openDelStatus(showDel: isSelected)
            self!.spreadView.isSortStatus = isSelected
            self!.spreadView.scrollToTop()
        }
//        self.insertSubview(upView, aboveSubview: self.hScrollView)
        self.addSubview(upView)
        return upView
    }()
}


// MARK: - 初始化展开收拢按钮
extension DTSpreadScrollView {
    fileprivate func setupSpreadButton() {
        spreadBtn = UIButton(type: UIButtonType.custom)
        // 包一层UIView 作为背景
        let bgView = UIView(frame: CGRect(x: SCREENW - kColumnViewH, y: 0.0, width: kColumnViewH, height: kColumnViewH))
        // 右边展开按钮(按钮为正方形，边长为控制器view的高度)
        spreadBtn.frame = CGRect(x: 0 , y: 0 , width: bgView.frame.width, height: bgView.frame.height)
        bgView.backgroundColor = UIColor.white
        bgView.addSubview(spreadBtn)
        spreadBtn.backgroundColor = UIColor.clear
        spreadBtn.adjustsImageWhenHighlighted = false
        spreadBtn.setImage(UIImage(named: "column_spread.png"), for: UIControlState.normal)
        spreadBtn.addTarget(self, action: #selector(self.spreadBtnClick(spreadBtn:)), for: UIControlEvents.touchUpInside)       // 按钮点击事件监听
        self.addSubview(bgView)
    }
}

// MARK: - 控制方法
extension DTSpreadScrollView {
    // MARK: - 展开收拢控制
    fileprivate func spreadOrFlod() {
        toSpread = !toSpread
        // cover 和 upPromptView通过参数交给内部scrollView控制显示隐藏
        spreadView.doSpreadOrFold(toSpread: toSpread, cover: cover, upPromptView: upPromptView)
        // 与子控件scrollView同步高度，保证子控件能够响应事件
        self.frame = CGRect(x: self.frame.origin.x, y: self.frame.origin.y, width: self.frame.width, height: toSpread ? kSpreadMaxH : kColumnViewH)
        // 旋转按钮layer图层
        transitionSpreadBtn(toSpread: toSpread)
        // 当编辑按钮在编辑状态时，收起时要复原
        if !toSpread && (upPromptView.editBtn?.isSelected)! {
            // 模拟用户点击了一下edit按钮
            upPromptView.editButtonClick(editBtn: upPromptView.editBtn!)
        }
        spreadView.isSortStatus = !toSpread
//        self.tabBarController?.tabBar.isHidden = toSpread           //控制tabBar的隐藏或显示
    }
}

// MARK: - 点击事件处理
extension DTSpreadScrollView {
    /// 展开收拢按钮点击事件
    @objc fileprivate func spreadBtnClick(spreadBtn : UIButton) {
        spreadOrFlod()
    }
    /// 旋转展开按钮
    fileprivate func transitionSpreadBtn(toSpread : Bool) {
        UIView.animate(withDuration: 0.2) { () -> Void in
            let angle = toSpread ? M_PI * 0.25 : -M_PI * 0.25
            self.spreadBtn.transform = self.spreadBtn.transform.rotated(by: CGFloat(angle))
        }
    }
}

