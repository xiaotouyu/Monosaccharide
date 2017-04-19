//
//  DTSingleProductDetailViewController.swift
//  Monosaccharide
//
//  Created by dashuios126 on 17/3/8.
//  Copyright © 2017年 dashuios126. All rights reserved.
//

import UIKit
import WebKit
import SVProgressHUD

class DTSingleProductDetailViewController: DTBaseViewController {

    open var item: DTProductDetailData?
    open var id: Int = 0
    fileprivate var circleView: LLCycleScrollView!
    fileprivate var bgScrollView: UIScrollView!
    fileprivate weak var webView: WKWebView!
    fileprivate weak var commentTableView: UITableView!
    fileprivate weak var bgView: UIView!
    fileprivate weak var bottomBgView: UIView!
    fileprivate weak var picLine: UILabel!
    fileprivate weak var comLine: UILabel!
    fileprivate weak var pickBtn: UIButton!
    fileprivate weak var comButton: UIButton!

    fileprivate var isHiddenRedLine: Bool = false {
        didSet{
            picLine.isHidden = isHiddenRedLine
            comLine.isHidden = !isHiddenRedLine
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        bgScrollView = UIScrollView(frame: view.bounds)
        bgScrollView.delegate = self
        bgScrollView.bounces = false
        view.addSubview(bgScrollView)
        bgScrollView.contentSize = CGSize(width: SCREENW, height: 2*SCREENH-69-88)
        loadDetailData()
        setShareButton()
    }

    func loadDetailData(){
        DTNetworkTool.shareNetWorkTool.loadProductDetailData(id) { [weak self](item) in
            
            self?.item = item
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5, execute: {
                self?.setupBottomView()
                self?.setupCircleView()
                self?.setupContentView()
                self?.setupPic(sender: (self?.pickBtn)!)
            })
        }
    }

    fileprivate func setupCircleView() {
        circleView = LLCycleScrollView.llCycleScrollViewWithFrame(CGRect(x: 0,y: 0,width: SCREENW,height: 375))
        circleView.autoScrollTimeInterval = 3.0
        circleView.placeHolderImage = UIImage(named: "PlaceHolderImage_small_31x26_")
        circleView.customPageControlStyle = .system
        circleView.imagePaths = (item?.image_urls)!
        bgScrollView.addSubview(circleView)
//        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .seconds(2)) { 
//
//            self.circleView.imagePaths = self.imagerArray!
//        }
    }
    fileprivate func setupContentView() {
        let bgView = UIView()
        bgView.backgroundColor = UIColor.white
        bgScrollView.addSubview(bgView)
        bgView.snp.makeConstraints { (make) in
            make.top.equalTo(circleView.snp.bottom)
            make.left.equalTo(0)
            make.width.equalTo(SCREENW)
            make.height.equalTo(125)
        }

        let titleLabel = UILabel()
        titleLabel.textColor = DTColor(51, g: 51, b: 51, a: 1.0)
        titleLabel.font = UIFont.systemFont(ofSize: 18)
        titleLabel.adjustsFontSizeToFitWidth =  true
//        titleLabel.backgroundColor = randomColor()
        titleLabel.text = item?.name
        bgView.addSubview(titleLabel)

        let priceLabel = UILabel()
        priceLabel.textColor = DTGlobalRedColor()
        priceLabel.font = UIFont.systemFont(ofSize: 16)
        priceLabel.adjustsFontSizeToFitWidth =  true
//        priceLabel.backgroundColor = randomColor()
        priceLabel.text = "¥ "+(item?.price)!
        bgView.addSubview(priceLabel)

        let contentLabel = UILabel()
        contentLabel.textColor = DTLineGlobalColor()
        contentLabel.font = UIFont.systemFont(ofSize: 14)
        contentLabel.adjustsFontSizeToFitWidth =  true
        contentLabel.numberOfLines = 0
//        contentLabel.backgroundColor = randomColor()
        contentLabel.text = item?.description
        bgView.addSubview(contentLabel)

        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(0)
            make.left.equalTo(10)
            make.width.equalTo(SCREENW)
            make.height.equalTo(40)
        }

        priceLabel.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom)
            make.left.equalTo(10)
            make.width.equalTo(SCREENW)
            make.height.equalTo(20)
        }
        contentLabel.snp.makeConstraints { (make) in
            make.top.equalTo(priceLabel.snp.bottom)
            make.left.equalTo(10)
            make.width.equalTo(SCREENW-20)
            make.bottom.equalTo(0)
        }

//        let line = UILabel()
//        line.backgroundColor = DTLineGlobalColor()
////        line.backgroundColor = randomColor()
//        bgView.addSubview(line)
//        line.snp.makeConstraints { (make) in
//            make.top.equalTo(contentLabel.snp.bottom).offset(10)
//            make.left.equalTo(0)
//            make.width.equalTo(SCREENW)
//            make.height.equalTo(1)
//        }

        let btnBgView = UIView()
        btnBgView.backgroundColor = UIColor.clear
        bgScrollView.addSubview(btnBgView)
        btnBgView.snp.makeConstraints { (make) in
            make.top.equalTo(contentLabel.snp.bottom).offset(10)
            make.left.equalTo(0)
            make.width.equalTo(SCREENW)
            make.height.equalTo(44)
        }
        self.bgView = btnBgView
        let picBtn = UIButton()
        picBtn.setTitle("图文介绍", for: .normal)
        picBtn.setTitleColor(DTColor(51, g: 51, b: 51, a: 1.0), for: .normal)
        picBtn.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        picBtn.backgroundColor = UIColor.white
        picBtn.addTarget(self, action: #selector(clickPicBtn(sender:)), for: .touchUpInside)
        btnBgView.addSubview(picBtn)
        pickBtn = picBtn
        let comBtn = UIButton()
        comBtn.setTitle("评论(\(item!.comments_count))", for: .normal)
        comBtn.setTitleColor(DTColor(51, g: 51, b: 51, a: 1.0), for: .normal)
        comBtn.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        comBtn.backgroundColor = UIColor.white
        comBtn.addTarget(self, action: #selector(clickComBtn(sender:)), for: .touchUpInside)
        btnBgView.addSubview(comBtn)
        comButton = comBtn
        picBtn.snp.makeConstraints { (make) in
            make.top.equalTo(0)
            make.left.equalTo(0)
            make.width.equalTo(SCREENW/2)
            make.height.equalTo(44)
        }

        comBtn.snp.makeConstraints { (make) in
            make.top.equalTo(0)
            make.left.equalTo(picBtn.snp.right).offset(1)
            make.width.equalTo(SCREENW/2)
            make.height.equalTo(44)
        }

        let redLine = UILabel()
        redLine.backgroundColor = DTGlobalRedColor()
        btnBgView.insertSubview(redLine, aboveSubview: picBtn)
        picLine = redLine
        redLine.snp.makeConstraints { (make) in
            make.bottom.equalTo(picBtn.snp.bottom)
            make.left.equalTo(0)
            make.width.equalTo(SCREENW/2)
            make.height.equalTo(2)
        }

        let redLine2 = UILabel()
        redLine2.backgroundColor = DTGlobalRedColor()
        btnBgView.insertSubview(redLine2, aboveSubview: comBtn)
        redLine2.isHidden = true
        comLine = redLine2
        redLine2.snp.makeConstraints { (make) in
            make.bottom.equalTo(comBtn.snp.bottom)
            make.left.equalTo(redLine.snp.right).offset(1)
            make.width.equalTo(SCREENW/2)
            make.height.equalTo(2)
        }
    }

    func clickPicBtn(sender: UIButton) {
        sender.isSelected = !sender.isSelected
        isHiddenRedLine = false
        removeCommentTableView()
        setupPic(sender: sender)
    }
    func clickComBtn(sender: UIButton) {
        sender.isSelected = !sender.isSelected
        isHiddenRedLine = true
        removeWebView()
        setupCommentTableView()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}

extension DTSingleProductDetailViewController {

    func setupPic(sender: UIButton){
        let picView = WKWebView()
        picView.navigationDelegate = self
        picView.scrollView.isScrollEnabled = false
        picView.scrollView.bounces = false
//        picView.scrollView.delegate = self
//        picView.scrollView.showsVerticalScrollIndicator = false
        let html = item?.detail_html
        picView.loadHTMLString(html!, baseURL: nil)
//        bgScrollView.addSubview(picView)
        bgScrollView.insertSubview(picView, belowSubview: bottomBgView)
        webView = picView
        picView.snp.makeConstraints { (make) in
            make.top.equalTo(sender.snp.bottom).offset(3)
            make.left.equalTo(0)
            make.width.equalTo(SCREENW)
            make.height.equalTo(SCREENH-44-44-69)
        }

    }

    func setShareButton() {

        navigationItem.rightBarButtonItem = UIBarButtonItem.init(image: UIImage(named: "PostItem_Share_18x22_"), style: .plain, target: self, action: #selector(clickShareButton))
    }

    func clickShareButton() {

        print("clickShareButton")
    }

    func setupBottomView() {

        let bgView = UIView()
        bgView.backgroundColor = DTGlobalColor()
        bgScrollView.addSubview(bgView)
        bgView.snp.makeConstraints { (make) in
            make.left.equalTo(0)
            make.bottom.equalTo(view)
            make.width.equalTo(SCREENW)
            make.height.equalTo(44)
        }
        bottomBgView = bgView
        let likeBtn = UIButton()
        likeBtn.setImage(UIImage(named: "content-details_like_16x16_"), for: .normal)
        likeBtn.setTitle("喜欢", for: .normal)
        likeBtn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        likeBtn.setTitleColor(DTGlobalRedColor(), for: .normal)
        likeBtn.layer.cornerRadius = 16
        likeBtn.layer.borderColor = DTGlobalRedColor().cgColor
        likeBtn.layer.borderWidth = 1
        likeBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0)
        bgView.addSubview(likeBtn)

        let goBtn = UIButton()
        goBtn.setTitle("去淘宝买", for: .normal)
        goBtn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        goBtn.layer.cornerRadius = 16
        goBtn.backgroundColor = DTGlobalRedColor()
        bgView.addSubview(goBtn)

        goBtn.snp.makeConstraints { (make) in
            make.right.equalTo(-15)
            make.top.equalTo(6)
            make.width.equalTo(2*(SCREENW-45)/3)
            make.height.equalTo(32)
        }

        likeBtn.snp.makeConstraints { (make) in
            make.left.equalTo(15)
            make.top.equalTo(6)
            make.right.equalTo(goBtn.snp.left).offset(-15)
            make.height.equalTo(32)
        }


    }

    func setupCommentTableView() {

        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        bgScrollView.insertSubview(tableView, belowSubview: bottomBgView)
        commentTableView = tableView

        tableView.snp.makeConstraints { (make) in
            make.top.equalTo(comButton.snp.bottom).offset(3)
            make.left.equalTo(0)
            make.width.equalTo(SCREENW)
            make.height.equalTo(SCREENH-69-44)
        }
    }

    func removeWebView(){
        webView.removeFromSuperview()
    }
    func removeCommentTableView(){
        commentTableView.removeFromSuperview()
    }
}

extension DTSingleProductDetailViewController: UITableViewDelegate,UITableViewDataSource {

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = UITableViewCell(style: .default, reuseIdentifier: "commentCell")

        cell.textLabel?.text = "张三"
        cell.detailTextLabel?.text = "哈哈哈哈"

        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 100
    }
}

extension DTSingleProductDetailViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offSetY = scrollView.contentOffset.y
//        print(offSetY)
        if scrollView == bgScrollView {
            if offSetY >= (SCREENH - 88 - 69) {
                if webView != nil{
                    webView.scrollView.isScrollEnabled = true
                }
                if commentTableView != nil {
                    commentTableView.isScrollEnabled = true
                }
            }else{
                if webView != nil{
                    webView.scrollView.isScrollEnabled = false
                }
                if commentTableView != nil {
                    commentTableView.isScrollEnabled = false
                }
            }
        }else {
            if commentTableView != nil {
                if offSetY > 0{
                    commentTableView.isScrollEnabled = true
                }else{
                    commentTableView.isScrollEnabled = false
                }
            }
        }
    }
}

extension DTSingleProductDetailViewController: WKNavigationDelegate {


    /// 加载结束
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {

        print("DTSingleProductDetailViewController----\(navigationController)")
        SVProgressHUD.dismiss()
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
        //document.body.scrollHeight  document.body.offsetHeight
//        webView .evaluateJavaScript("document.body.offsetHeight") { (height, error) in
//            self.webViewHeight = height as! CGFloat
//        }

    }


    /// 开始加载
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {

        //        SVProgressHUD .setStatus("正在加载中...")
        SVProgressHUD.show(withStatus: "正在加载中...")
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }

    
}
