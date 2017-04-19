//
//  DTHomeViewController.swift
//  Monosaccharide
//
//  Created by dashuios126 on 17/2/21.
//  Copyright © 2017年 dashuios126. All rights reserved.
//

import UIKit


let cellIdentifier = "homeCell"

class DTHomeViewController: UIViewController {



    @IBOutlet weak var homeTableView: UITableView!

    open var id: Int = 0
    fileprivate var page = 0
    fileprivate var offset = 0
    fileprivate var limit = 20


    fileprivate var items = [DTHomeItems]()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.white
        // Do any additional setup after loading the view.

        //顶部轮播图数据请求
        DTNetworkTool.shareNetWorkTool.loadHomeAdvertisingData { [weak self](advertising) in
            var urls = [String]()
            for adver in advertising{
                urls.append(adver.image_url!)
            }
            self?.createTopView(urls: urls)
        }
        setupRefresh()

    }
    func createTopView(urls: [String]){
        let topView = DTHomeTopView(frame: CGRect(x: 0,y:0,width: SCREENW, height: 150))
        topView.images = urls
        self.homeTableView.tableHeaderView = topView
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        homeTableView.es_startPullToRefresh()
    }
    private func setupRefresh(){
//        var header: ESRefreshProtocol & ESRefreshAnimatorProtocol
//        var footer: ESRefreshProtocol & ESRefreshAnimatorProtocol
        let header = ESRefreshHeaderAnimator.init(frame: CGRect.zero)
        let footer = ESRefreshFooterAnimator.init(frame: CGRect.zero)
        header.pullToRefreshDescription = "下拉刷新"
        header.releaseToRefreshDescription = "松开刷新"
        homeTableView.es_addPullToRefresh(animator: header) {
            [weak self] in
            self?.refresh()
        }
        homeTableView.es_addInfiniteScrolling(animator: footer) {
            [weak self] in
            self?.loadMore()
        }

    }
    private func refresh() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            self.page = 1
            self.offset = 0
            self.items.removeAll()
            // 表格数据
            let params: Dictionary<String,Int> = ["limit": self.limit,"offset": self.offset,"id": self.id]
//            self.loadDatta(params)
            DTNetworkTool.shareNetWorkTool.loadHomeInfo(params) { [weak self](items) in
//                self?.items = items
                self?.items.append(contentsOf: items)
                self?.homeTableView.reloadData()
                self?.homeTableView.es_stopPullToRefresh()
            }
        }
    }
    private func loadMore() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            self.page += 1
            self.offset += 20
            // 表格数据
            let params: Dictionary<String,Int> = ["limit": self.limit,"offset": self.offset,"id": self.id]
            DTNetworkTool.shareNetWorkTool.loadHomeInfo(params) { [weak self](items) in
                self?.items.append(contentsOf: items)
                self?.homeTableView.reloadData()
                self?.homeTableView.es_stopLoadingMore()
            }
//                self.homeTableView.es_stopLoadingMore()
//
//                self.homeTableView.es_noticeNoMoreData()
        }
    }

    private func loadDatta(_ params: Dictionary<String, Int>){
        // 表格数据
        DTNetworkTool.shareNetWorkTool.loadHomeInfo(params) { [weak self](items) in
            self?.items = items
            self?.homeTableView.reloadData()
            self?.homeTableView.es_stopLoadingMore()
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension DTHomeViewController: UITableViewDelegate,UITableViewDataSource {
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {


        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! DTHomeViewCell
        cell.selectionStyle = .none
        cell.item = items[indexPath.row]

        return cell
    }

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return items.count 
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        let detailVC = DTDetailViewController()
        detailVC.title = title
        detailVC.item = items[indexPath.row]
        self.navigationController?.pushViewController(detailVC, animated: true)

    }

}









