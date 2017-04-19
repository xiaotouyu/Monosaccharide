//
//  DTGuidePageViewController.swift
//  Monosaccharide
//
//  Created by dashuios126 on 17/2/17.
//  Copyright © 2017年 dashuios126. All rights reserved.
//

import UIKit

class DTGuidePageViewController: UIViewController,UIPageViewControllerDataSource,UIPageViewControllerDelegate{

    fileprivate var pageViewController: UIPageViewController?

    /// 页面数量改变时的回调
    var pageViewControllerUpdatePageCount:((DTGuidePageViewController,NSInteger)->Void)!

    /// 页面改变时的回调
    var pageViewControllerUpdatePageIndex:((DTGuidePageViewController,NSInteger)->Void)!

    fileprivate lazy var allViewControllers:[UIViewController]={

        return [DTGuideImageViewController(imgName: "walkthrough_1",frame: self.view.bounds, showBtn:false),
                DTGuideImageViewController(imgName: "walkthrough_2",frame: self.view.bounds, showBtn:false),
                DTGuideImageViewController(imgName: "walkthrough_3",frame: self.view.bounds,showBtn:false),
                DTGuideImageViewController(imgName: "walkthrough_4",frame: self.view.bounds,showBtn:true)]

    }()

    func setPageCount(pageCount:((DTGuidePageViewController,NSInteger)->Void)!, pageIndex:((DTGuidePageViewController,NSInteger)->Void)!){
        self.pageViewControllerUpdatePageCount = pageCount
        self.pageViewControllerUpdatePageIndex = pageIndex
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        pageViewController!.dataSource = self
        pageViewController!.delegate = self
        view.addSubview(pageViewController!.view)

        //设置首页
        if let firstViewController = allViewControllers.first {
            pageViewController!.setViewControllers([firstViewController], direction: .forward, animated: true, completion:nil)
        }

        //页面数量改变时
        if self.pageViewControllerUpdatePageCount != nil {
            self.pageViewControllerUpdatePageCount(self,allViewControllers.count)
        }
        // Do any additional setup after loading the view.
    }

    //mark:获取前一个页面
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController?{
        //guard 条件为false就执行else里的函数块
        guard let viewControllerIndex = allViewControllers.index(of: viewController) else {
            return nil
        }
        let previousIndex = viewControllerIndex - 1
        guard previousIndex >= 0 else {
            return nil
        }
        guard allViewControllers.count > previousIndex else {
            return nil
        }
        return allViewControllers[previousIndex]
    }
    //mark:获取后一个页面
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = allViewControllers.index(of: viewController) else {
            return nil
        }
        let nextIndex = viewControllerIndex + 1
        let orderedViewControllersCount = allViewControllers.count
        guard orderedViewControllersCount != nextIndex else {
            return nil
        }
        guard orderedViewControllersCount>nextIndex else {
            return nil
        }
        return allViewControllers[nextIndex]
    }

    //mark:页面切换完毕
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        
        if let firstViewController = pageViewController.viewControllers?.first,let index = allViewControllers.index(of: firstViewController) {
            if self.pageViewControllerUpdatePageIndex != nil {
                self.pageViewControllerUpdatePageIndex(self,index)
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

//extension DTGuidePageViewController: UIPageViewControllerDelegate,UIPageViewControllerDataSource{
//
//
//    //mark:获取前一个页面
//    func pageViewController(_ pageViewController: DTGuidePageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController?{
//        //guard 条件为false就执行else里的函数块
//        guard let viewControllerIndex = allViewControllers.index(of: viewController) else {
//            return nil
//        }
//        let previousIndex = viewControllerIndex - 1
//        guard previousIndex >= 0 else {
//            return nil
//        }
//        guard allViewControllers.count > previousIndex else {
//            return nil
//        }
//        return allViewControllers[previousIndex]
//    }
//    //mark:获取后一个页面
//    func pageViewController(pageViewController: DTGuidePageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
//        guard let viewControllerIndex = allViewControllers.index(of: viewController) else {
//            return nil
//        }
//        let nextIndex = viewControllerIndex + 1
//        let orderedViewControllersCount = allViewControllers.count
//        guard orderedViewControllersCount != nextIndex else {
//            return nil
//        }
//        guard orderedViewControllersCount>nextIndex else {
//            return nil
//        }
//        return allViewControllers[nextIndex]
//    }
//
//    //mark:页面切换完毕
//    func pageViewController(pageViewController: DTGuidePageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
//        if let firstViewController = viewControllers?.first,let index = allViewControllers.index(of: firstViewController) {
//            if self.pageViewControllerUpdatePageIndex != nil {
//                self.pageViewControllerUpdatePageIndex(self,index)
//            }
//        }
//    }
//}



