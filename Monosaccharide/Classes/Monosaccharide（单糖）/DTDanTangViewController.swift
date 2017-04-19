//
//  DTDanTangViewController.swift
//  Monosaccharide
//
//  Created by dashuios126 on 17/2/17.
//  Copyright © 2017年 dashuios126. All rights reserved.
//

import UIKit

class DTDanTangViewController: DTBaseViewController {

    /// 标签的数组
    var arrayTitles: [String] = []

    var titles: [String] = []

    fileprivate var channel: [DTChannel] = []
    /// 标签看扩展栏目的数组
    var arraySpareTitles:[String] = []

    var columnVC:ZYColumnViewController!

    var pageContentView: PageContentView!

    override func viewDidLoad() {

//        view.backgroundColor = UIColor.red
        self.title = "单糖"
        DTNetworkTool.shareNetWorkTool.loadHomeTopData { [weak self](ym_channels) in

            for channel in ym_channels {
                self!.arrayTitles.append(channel.name!)
                print("id : \(channel.id)")
                self!.channel.append(channel)
            }
            self?.titles = (self?.arrayTitles)!
//            print("self!.channel:  \(self!.channel)")
            self?.setupUI()
            self?.initColumnVC((self?.titles)!, (self?.arraySpareTitles)!, 1)
        }

        setSearch()
    }

    private func initColumnVC(_ titles : [String], _ spareTitles : [String] , _ fixCount : Int){
        // 初始化columnVC
        columnVC = ZYColumnViewController()
        columnVC.view.frame = CGRect(x: 0, y: 0, width: SCREENW , height: 40)
        columnVC.arrayTitles = titles
        if spareTitles.count > 0 {
            columnVC.arraySpareTitles = spareTitles
        }
        columnVC.fixedCount = fixCount
        columnVC.delegate = self
        columnVC.tabbar = self.tabBarController?.tabBar
        view.addSubview(columnVC.view)
        //        addChildViewController(columnVC)
    }

    func addChildViewControllers(_ titles: [String]) -> [UIViewController]{
        let sb = UIStoryboard.init(name: "Main", bundle: nil)
        
        var childVcs = [UIViewController]()
        let homeVC = sb.instantiateViewController(withIdentifier: "homeTableView") as! DTHomeViewController
        homeVC.title = self.title
//        print("(self.channel?[0].id)! \((self.channel[0].id)!)")
            homeVC.id = (self.channel[0].id)!
            childVcs.append(homeVC)
            let count = titles.count
            var vc: UIViewController!
            for _ in 0..<(count-1) {
                vc = UIViewController()
                vc.view.backgroundColor = randomColor()
                childVcs.append(vc)
        }
        UserDefaults.standard.set(childVcs.count, forKey: HOME_CHILDVCS)
//        print("DTDanTangViewController---childvcs-",childVcs.count)

        //            UserDefaults.standard.set(childVcs.count, forKey: DEFAULT_CHILDVCS)
        UserDefaults.standard.set(0, forKey: DEFAULT_CHILDVCS)
        return childVcs
    }

}

extension DTDanTangViewController: ZYColumnViewControllerDelegate {

    func columnViewControllerSetTitle(setTitle: String, index: Int) {

    }

    func columnViewControllerSelectedTitle(selectedTitle: String, index: Int) {
        pageContentView.setCurrentIndex(currentIndex: index)
    }

    func columnViewControllerTitlesDidChanged(arrayTitles: [String]!, spareTitles: [String]?) {
//        print("arrayTitles: \(arrayTitles) \n spareTitles: \(spareTitles)")
        self.titles = arrayTitles
        self.arraySpareTitles = spareTitles!

        let newVCS = self.addChildViewControllers(self.titles)
        self.pageContentView.reloadChildVcs(newChildVcs: newVCS)
    }
}

// MARK:- setupUI
extension DTDanTangViewController {
    fileprivate func setupUI() {
        //不需要调整scrollview的内边距
        automaticallyAdjustsScrollViewInsets = false
//        view.addSubview(pageTitleView)
        let contentFrame = CGRect(x: 0, y:  kTitlesViewH+0.5, width: SCREENW, height: SCREENH - kTitlesViewH - kTabBarH-64)
        let childVcs = self.addChildViewControllers(self.titles)
        pageContentView = PageContentView(frame: contentFrame, childVcs: childVcs, parentVc: self)
        //MARK:- 控制器作为PageContentViewDelegate代理
        pageContentView.delegate = self
        view.addSubview(pageContentView)
    }

    fileprivate func setSearch(){

        let search = UIButton()
//        search.size = CGSize(width: 25, height: 25)
        search.sizeToFit()
        search.setImage(UIImage(named:"Feed_SearchBtn_18x18_"), for: .normal)
        search.addTarget(self, action: #selector(clcikSearch), for: .touchUpInside)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: search)

    }

    func clcikSearch() {

//        print("search.....")

        let vc = DTSearchViewController()
        navigationController?.pushViewController(vc, animated: true)
    }

}


//MARK:- EntertainmentContentViewDelegate代理实现
extension DTDanTangViewController : PageContentViewDelegate{
    func pageContentView(_ contentView: PageContentView, progress: CGFloat, sourceIndex: Int, targetIndex: Int) {
//        pageTitleView.setTitleWithProgress(progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
//        print("titles \(titles) targetIndex : \(targetIndex) sourceIndex:\(sourceIndex) titles.count: \(titles.count)")

        if targetIndex == titles.count {
            return
        }
        let title = titles[targetIndex]
        columnVC.hScrollViewChangeItemToSelected(title: title)
    }
}

