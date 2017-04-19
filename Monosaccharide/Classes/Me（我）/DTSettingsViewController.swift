//
//  DTSettingsViewController.swift
//  Monosaccharide
//
//  Created by dashuios126 on 17/3/13.
//  Copyright © 2017年 dashuios126. All rights reserved.
//

import UIKit

class DTSettingsViewController: UITableViewController {

    fileprivate var settings = [AnyObject]()

    override func viewDidLoad() {
        super.viewDidLoad()


        let path = Bundle.main.path(forResource: "MineSettings", ofType: ".plist")
        let settingsList = NSArray(contentsOfFile: path!)
        for item in settingsList! {
            let array = item as! NSArray
            var sections = [AnyObject]()
            for dic in array {
                let setting = DTSettingsModel(dict: dic as! [String : AnyObject])
                sections.append(setting)
            }
            settings.append(sections as AnyObject)
        }


        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
//        navigationController?.navigationBar.setupBackgroundColor()
        let backBtn = UIButton()
        backBtn.setTitle("返回", for: .normal)
        backBtn.setTitleColor(UIColor.white, for: .normal)
        backBtn.setImage(UIImage(named: "checkUserType_backward_9x15_"), for: .normal)
        backBtn.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        backBtn.sizeToFit()
        backBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -10)
        backBtn.addTarget(self, action: #selector(clickBack), for: .touchUpInside)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backBtn)




    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return settings.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return settings[section].count
    }

    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 15
    }
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "settingCell", for: indexPath) as! DTSettingsTableViewCell
        let item = settings[indexPath.section]
        let setting = (item as! NSArray)[indexPath.row] as! DTSettingsModel
        cell.setting = setting
        return cell
    }





    func clickBack() {
       _ = navigationController?.popViewController(animated: true)
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
