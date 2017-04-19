//
//  CustomSliderView.swift
//  ZJGenWoYou
//
//  Created by 李国良 on 2016/9/29.
//  Copyright © 2016年 李国良. All rights reserved.
//

import UIKit
// FIXME: comparison operators with optionals were removed from the Swift Standard Libary.
// Consider refactoring the code to use the non-optional operators.
fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l < r
  case (nil, _?):
    return true
  default:
    return false
  }
}

// FIXME: comparison operators with optionals were removed from the Swift Standard Libary.
// Consider refactoring the code to use the non-optional operators.
fileprivate func >= <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l >= r
  default:
    return !(lhs < rhs)
  }
}


// =====  代理方法 ===========
protocol CustomSliderViewDelegate {
   func clickCurrentImage(_ currentIndxe: Int)
}

public enum SliderViewSourceType {
    case sourceTypeLocalSource
    case sourceTypeUrlSource
}

class CustomSliderView: UIView {
    
    fileprivate var imagView : UIImageView!
    fileprivate var imageData : [String]!;
    fileprivate var  myTimer : Timer?
    fileprivate var currentPage : Int!
    fileprivate var totalNumber : Int!

    var isAnimation: Bool = true
    var pageControl : UIPageControl!
    var sourceType : SliderViewSourceType!
    var timeInterval : Double!
    var delegate : CustomSliderViewDelegate?
    
//========================================--- 开始--- ==================================================================================
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    convenience init(frame:CGRect, type:SliderViewSourceType, imageArray:[String]!, sliderTime:Double!) {
        self.init(frame: frame)
        self.imageData = imageArray
        self.sourceType = type
        self.currentPage = 0
        totalNumber = imageArray?.count
        self.timeInterval = sliderTime
        
        self.imagView = UIImageView.init(frame: CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height))
        self.imagView.contentMode = UIViewContentMode.scaleAspectFill
        self.imagView.clipsToBounds = true
        self.addSubview(self.imagView)
        self.imagView.isUserInteractionEnabled = true;
        
        self.pageControl = UIPageControl.init()
        self.pageControl.numberOfPages = totalNumber
        let pageSize: CGSize! = self.pageControl.size(forNumberOfPages: totalNumber)
        self.pageControl.frame = (CGRect(x: 0, y: 0, width: pageSize.width, height: pageSize.height))
        self.pageControl.center = CGPoint(x: self.center.x, y: frame.height - 8);
        self.pageControl.currentPageIndicatorTintColor = UIColor.white;
        self.pageControl.pageIndicatorTintColor = UIColor.gray;
        self.addSubview(self.pageControl)
        
        if type == SliderViewSourceType.sourceTypeLocalSource {
            self.imagView.image = UIImage.init(named: self.imageData![currentPage])
        } else {
            //网络请求
            self.imagView.kf.setImage(with: URL(string: self.imageData![currentPage]), placeholder: nil, options: nil, progressBlock: nil, completionHandler: nil)

        }
        
        //添加滑动手势
        let fromLeftRecongnizer = UISwipeGestureRecognizer(target: self, action:#selector(CustomSliderView.handleSwipeFromLeft))
        fromLeftRecongnizer.direction = .left
        self.imagView.addGestureRecognizer(fromLeftRecongnizer)
        let fromRightRecongnizer = UISwipeGestureRecognizer(target: self, action:#selector(CustomSliderView.handleSwipeFromRight))
        fromRightRecongnizer.direction = .right
        self.imagView.addGestureRecognizer(fromLeftRecongnizer)
        
        
        let tapRecongnizer = UITapGestureRecognizer(target: self, action:#selector(CustomSliderView.tapImgView))
        self.imagView.addGestureRecognizer(tapRecongnizer)
        
        
        setUpTimer(self.timeInterval)
        
    }
    
    func handleSwipeFromLeft() {
        currentPage = currentPage - 1
        if currentPage < 0 {
            currentPage = (self.imageData?.count)! - 1
        }
        self.pageControl.currentPage = currentPage
        if sourceType == SliderViewSourceType.sourceTypeLocalSource {
            self.imagView.image = UIImage.init(named: self.imageData![currentPage])
        } else if (sourceType == SliderViewSourceType.sourceTypeUrlSource) {
            self.imagView.kf.setImage(with: URL(string: self.imageData![currentPage]), placeholder: nil, options: nil, progressBlock: nil, completionHandler: nil)
        }
        if isAnimation {
            transTionWithsubtype(kCATransitionFromLeft)
        }
    }
    
    func transTionWithsubtype(_ subtype: String) {
        let transition = CATransition.init();
        transition.type = "cube";
        transition.subtype = subtype;
        transition.duration = 1.5;
        transition.delegate = self;
        self.imagView.layer.add(transition, forKey: nil)
    }
    
    func handleSwipeFromRight() {
        currentPage = currentPage + 1
        if currentPage >= self.imageData?.count {
            currentPage = 0
        }
        self.pageControl.currentPage = currentPage
        if sourceType == SliderViewSourceType.sourceTypeLocalSource {
            self.imagView.image = UIImage.init(named: self.imageData![currentPage])
        } else if (sourceType == SliderViewSourceType.sourceTypeUrlSource) {
            self.imagView.kf.setImage(with: URL(string: self.imageData![currentPage]), placeholder: nil, options: nil, progressBlock: nil, completionHandler: nil)
        }
        if isAnimation {
            transTionWithsubtype(kCATransitionFromRight)
        }
    }
    
    fileprivate func setUpTimer(_ timeIntterval:Double) {
        self.myTimer = Timer.init(timeInterval: timeIntterval, target: self, selector: #selector(CustomSliderView.handleSwipeFromRight), userInfo: nil, repeats: true)
        RunLoop.current.add(self.myTimer!, forMode: RunLoopMode.defaultRunLoopMode)
    }
    

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
// =====================================  点击图片 =======================================
    func tapImgView() {
        self.delegate?.clickCurrentImage(currentPage)
        print("tapImgView")
    }
    
}

extension CustomSliderView: CAAnimationDelegate {

     func animationDidStart(_ anim: CAAnimation) {
        if (self.myTimer != nil) {
            self.myTimer?.invalidate()
        }
        self.imagView.isUserInteractionEnabled = false
    }

     func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        if self.timeInterval > 0 {
            setUpTimer(self.timeInterval)
        } else {
            setUpTimer(self.timeInterval)
        }
        self.imagView.isUserInteractionEnabled = true
    }
}

