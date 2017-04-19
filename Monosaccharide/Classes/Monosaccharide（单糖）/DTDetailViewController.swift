//
//  DTDetailViewController.swift
//  Monosaccharide
//
//  Created by dashuios126 on 17/2/24.
//  Copyright © 2017年 dashuios126. All rights reserved.
//

import UIKit

import WebKit
import SVProgressHUD

class DTDetailViewController: UIViewController {

    open var item: DTHomeItems?
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "攻略详情"
        let webView = WKWebView()
        webView.frame = view.bounds

        webView.uiDelegate = self
        webView.navigationDelegate = self
        let request = URLRequest(url: URL(string: (item?.content_url)!)!)
        webView.load(request)
        view.addSubview(webView)

    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
extension DTDetailViewController: WKNavigationDelegate,WKUIDelegate {


    /// 加载结束
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {

//        webView .evaluateJavaScript("document.body.offsetHeight;") { (height, error) in
//            print(height)
//        }
        print("navigationController----\(webView.scrollView.contentSize.height)")
        SVProgressHUD.dismiss()
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }


    /// 开始加载
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {

//        SVProgressHUD .setStatus("正在加载中...")
        SVProgressHUD.show(withStatus: "正在加载中...")
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }

    func webView(_ webView: WKWebView, runJavaScriptConfirmPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping (Bool) -> Void) {
//        print("message-------: \(message)")


    }

    func webView(_ webView: WKWebView, runJavaScriptAlertPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping () -> Void) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (_) -> Void in
            completionHandler()
        }))
        self.present(alert, animated: true, completion: nil)
    }

}



