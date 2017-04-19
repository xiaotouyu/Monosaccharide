//
//  DTGuideViewController.swift
//  Monosaccharide
//
//  Created by dashuios126 on 17/2/17.
//  Copyright © 2017年 dashuios126. All rights reserved.
//

import UIKit

class DTGuideViewController: UIViewController {

    private(set) lazy var pageControl:UIPageControl = {

        return UIPageControl(frame:CGRect(x:(self.view.bounds.width-200)/2,y:self.view.bounds.height-20-10,width:200,height:20))
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        NotificationCenter.default.addObserver(self, selector: #selector(removeGuidePageView), name: NSNotification.Name(rawValue: "beginExperience"), object: nil)

        self.view.backgroundColor = UIColor.white
        self.view.addSubview(pageControl)
        pageControl.backgroundColor = UIColor.clear
        pageControl.pageIndicatorTintColor = UIColor.init(red: 115/255.0, green: 107/255.0, blue: 121/255.0, alpha: 0.6)
        pageControl.currentPageIndicatorTintColor = UIColor.init(red: 115/255.0, green: 107/255.0, blue: 121/255.0, alpha: 1)
        loadGuidePageView()
    }

    func loadGuidePageView() {


        let guideview = DTGuidePageViewController()

        guideview.setPageCount(pageCount: { (guide:DTGuidePageViewController, count:NSInteger) in
            self.pageControl.numberOfPages = count
//            print("count \(count)")
        }) { (guide:DTGuidePageViewController, index:NSInteger) in
//            print("index \(index)")
//            if index == self.pageControl.numberOfPages-1{
//                self.pageControl.isHidden = true
//            }
            self.pageControl.currentPage = index
        }
        guideview.view.frame = self.view.bounds
        self.view.addSubview(guideview.view)
        self.addChildViewController(guideview)
        self.view.bringSubview(toFront: pageControl)
    }


    /**
     移除引导页,同时记录引导页已经显示完成
     */
    func removeGuidePageView() {

        self.view.removeFromSuperview()
        self.removeFromParentViewController()
        //Todo:存储第一次已经显示引导页
        UserDefaults.standard.set(true, forKey: "firstLaunch")
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            appDelegate.showMainStoryboard()
        }
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
