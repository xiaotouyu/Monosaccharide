//
//  DTSearchViewController.swift
//  Monosaccharide
//
//  Created by dashuios126 on 17/2/28.
//  Copyright © 2017年 dashuios126. All rights reserved.
//

import UIKit

class DTSearchViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        setNav()
        view.addSubview(recordView)
        

    }

    fileprivate lazy var searchBar: UISearchBar = {

        let searchBar = UISearchBar()
        searchBar.placeholder = "搜索商品，专题"
        return searchBar
    }()

    fileprivate lazy var recordView: DTSearchRecordView = {

        let view = DTSearchRecordView(frame: CGRect(x: 0, y: 9, width: SCREENW, height: SCREENH))
        return view
    }()

    fileprivate func setNav(){
        navigationItem.titleView = searchBar
        searchBar.delegate = self
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: UIView())
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "取消", style: .plain, target: self, action: #selector(clickCancleBtn))
    }

    func clickCancleBtn(){

        navigationController?.popViewController(animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
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

extension DTSearchViewController: UISearchBarDelegate {
    /// mark  文字改变时调用

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {


    }
    /// mark  搜索按钮被点击

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {


    }

    /// mark  书签按钮被点击
    func searchBarBookmarkButtonClicked(_ searchBar: UISearchBar) {

    }
    /// mark  取消按钮被点击

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {

    }

}

