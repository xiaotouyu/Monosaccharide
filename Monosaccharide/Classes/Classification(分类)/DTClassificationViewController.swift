//
//  DTClassificationViewController.swift
//  Monosaccharide
//
//  Created by dashuios126 on 17/3/10.
//  Copyright © 2017年 dashuios126. All rights reserved.
//

import UIKit

let classificationProjectCelll = "projectCell" //专题合集
let classificationStyleCelll = "StyleCell"     //风格
let classificationCategoryCelll = "CategoryCell" // 品类
fileprivate let projectHeight: CGFloat = 135
fileprivate let styleHeight: CGFloat = 150
fileprivate let categoryHeight: CGFloat = 260

class DTClassificationViewController: DTBaseViewController {
    @IBOutlet weak var DTClassificationTableView: UITableView!

    fileprivate var projectItems = [DTClassicationProjectCollections]()
    fileprivate var styleItems = [DTClassificationStyleChannel_groups]()
    fileprivate var styleChannels = [DTClassificationStyleChannels]()
    fileprivate var categoryChannels = [DTClassificationStyleChannels]()
    fileprivate var styleName: String?
    fileprivate var categoryName: String?
    override func viewDidLoad() {
        super.viewDidLoad()
        DTClassificationTableView.delegate = self
        DTClassificationTableView.dataSource = self
        DTClassificationTableView.register(UITableViewCell.self, forCellReuseIdentifier: classificationProjectCelll)
        DTClassificationTableView.register(UITableViewCell.self, forCellReuseIdentifier: classificationStyleCelll)
        DTClassificationTableView.register(UITableViewCell.self, forCellReuseIdentifier: classificationCategoryCelll)


        // Do any additional setup after loading the view.
        loadData()
        loadStyleData()
    }

    func loadData() {
        DTNetworkTool.shareNetWorkTool.loadClassicationData { [weak self](item) in
            self?.projectItems.append(contentsOf: item)
            self?.DTClassificationTableView.reloadData()
        }
    }
    func loadStyleData() {
        DTNetworkTool.shareNetWorkTool.loadClassicationStyleData { [weak self](item) in

            self?.styleItems.append(contentsOf: item)
            self?.DTClassificationTableView.reloadData()
            }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension DTClassificationViewController: UITableViewDelegate,UITableViewDataSource{

    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: classificationProjectCelll, for: indexPath)
            let view = setupProjectView(classificationProjectCelll,height: projectHeight)
            cell.contentView.addSubview(view)
            view.projectItems = projectItems
            cell.selectionStyle = .none
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: classificationStyleCelll, for: indexPath)
            let view = setupProjectView(classificationStyleCelll,height: styleHeight)
            cell.contentView.addSubview(view)
            getChannels()
            view.styleItems = styleChannels
            print(styleItems)
            view.text = styleName ?? ""
            cell.selectionStyle = .none
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: classificationCategoryCelll, for: indexPath)
            let view = setupProjectView(classificationCategoryCelll,height: categoryHeight)
            cell.contentView.addSubview(view)
            getChannels()
            view.categoryItems = categoryChannels
            print(styleItems)
            view.text = categoryName ?? ""
            cell.selectionStyle = .none
            return cell

        default:

            return UITableViewCell()
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return projectHeight
        case 1:
            return styleHeight
        case 2:
            return categoryHeight
        default:
            return 44
        }
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 1
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10
    }

}
extension DTClassificationViewController {

    func setupProjectView(_ cell: String?, height: CGFloat) -> DTCollectionView{

        let view = DTCollectionView(frame: CGRect(x: 0, y: 0, width: SCREENW, height: height), style: cell)
        return view
    }

    func getChannels() {
        for channels in styleItems {
            if channels.name == "风格" {
                styleChannels = channels.channels
                styleName = channels.name
            } else if channels.name == "品类"{
                categoryChannels = channels.channels
                categoryName = channels.name
            }
        }
    }
}
