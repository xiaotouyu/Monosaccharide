//
//  DTNavigationViewController.swift
//  Monosaccharide
//
//  Created by dashuios126 on 17/2/17.
//  Copyright © 2017年 dashuios126. All rights reserved.
//

import UIKit
import SVProgressHUD

class DTNavigationViewController: UINavigationController {

    override class func initialize(){
        super.initialize()
        /// 设置导航栏标题
        let navBar = UINavigationBar.appearance()
        navBar.barTintColor = DTGlobalRedColor()
        navBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white, NSFontAttributeName: UIFont.systemFont(ofSize: 20)]

        let navItem = UIBarButtonItem.appearance()  // 获取全局的BarButtonItem
        navItem.setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.white, NSFontAttributeName: UIFont.systemFont(ofSize: 20)], for: .normal)

        navBar.tintColor = UIColor.white
        // 导航条默认设置为不透明
        navBar.isTranslucent = false
        navBar.setBackgroundImage(UIImage(named: "navi_bar_bg~iphone"), for: .default)

    }
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    /// 统一修改导航栏左上角返回按钮

    override func pushViewController(_ viewController: UIViewController, animated: Bool) {

        if viewControllers.count > 0 {

            viewController.hidesBottomBarWhenPushed = true

//            print("title: \(viewController.title) viewController---\(viewController)")

//            let backBtn = UIButton()
//            backBtn.setTitle(viewController.title, for: .normal)
//            backBtn.setImage(UIImage(named:"checkUserType_backward_9x15_"), for: .normal)
//            backBtn.sizeToFit()
//            backBtn.contentEdgeInsets = UIEdgeInsets(top: 0, left: -10, bottom: 0, right: 0)
//            backBtn.addTarget(self, action: #selector(navigationBackClick), for: .touchUpInside)
//            viewController.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backBtn)
        }
        super.pushViewController(viewController, animated: true)
    }

    func navigationBackClick(){

        if SVProgressHUD.isVisible() {
            SVProgressHUD.dismiss()
        }
        if UIApplication.shared.isNetworkActivityIndicatorVisible {
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
        }
        popViewController(animated: true)
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
