    //
//  DTMineTableViewController.swift
//  Monosaccharide
//
//  Created by dashuios126 on 17/3/14.
//  Copyright © 2017年 dashuios126. All rights reserved.
//

import UIKit

class DTMineTableViewController: UITableViewController,ParallaxHeaderViewDelegate {
    fileprivate var statusBarShouldLight = true
    fileprivate var avatarBtn: UIButton!
    override var preferredStatusBarStyle: UIStatusBarStyle {
        if statusBarShouldLight {
            return .lightContent
        } else {
            return .default
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isTranslucent = true
        automaticallyAdjustsScrollViewInsets = false

        self.navBarBgAlpha = 0
        self.navBarTintColor = .white
        setupLoginImageView()
    }

    func clickSend() {
        print("clickSend")
        let sb = UIStoryboard.init(name: "Main", bundle: nil)
        let login = sb.instantiateViewController(withIdentifier: "loginController")
        present(login, animated: true, completion: nil)
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        navigationController?.navigationBar.setBackgroundImage()
    }

    @IBAction func clickMessage(_ sender: UIBarButtonItem) {
    }

    @IBAction func clickSettings(_ sender: UIBarButtonItem) {
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let heardView = tableView.tableHeaderView as! ParallaxHeaderView
        heardView.layoutHeaderViewWhenScroll(scrollView.contentOffset)
        let contentOffsetY = scrollView.contentOffset.y
        let showNavBarOffsetY = 200 - topLayoutGuide.length
        print(contentOffsetY, showNavBarOffsetY)

        //navigationBar alpha
        if contentOffsetY > showNavBarOffsetY  {
//            var navAlpha = (contentOffsetY - (showNavBarOffsetY)) / 40.0
//            print(navAlpha)
//            if navAlpha > 1 {
//                navAlpha = 1
//            }
//
//            navBarBgAlpha = navAlpha
//            if navAlpha > 0.8 {
//                navBarTintColor = UIColor.defaultNavBarTintColor
//                statusBarShouldLight = false
//                transitionAvatar(navAlpha)
//            }else{
//                navBarTintColor = UIColor.white
//                statusBarShouldLight = true
//            }
            scrollView.contentOffset.y = showNavBarOffsetY
        }else if (contentOffsetY <= 0) {
            navBarBgAlpha = 0
            navBarTintColor = UIColor.white
            statusBarShouldLight = true
            transitionAvatar(1.0)

        }
        else if (contentOffsetY > 0 && contentOffsetY < showNavBarOffsetY){
            navBarBgAlpha = 0
            navBarTintColor = UIColor.white
            statusBarShouldLight = true
            transitionAvatar(0.5)
            UIView.animate(withDuration: 0.1) {
                self.avatarBtn.frame = CGRect(x: SCREENW/2-75/4, y: 75/4, width: 75/2, height: 75/2)
            }
        }
        setNeedsStatusBarAppearanceUpdate()
    }

}

extension DTMineTableViewController {

    func setupLoginImageView() {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: tableView.bounds.width, height: 264))
        imageView.image = UIImage(named: "Me_ProfileBackground")
        imageView.contentMode = .scaleAspectFill

        let avatarBtn = UIButton(type: .custom)
        avatarBtn.setImage(UIImage(named: "Me_AvatarPlaceholder_75x75_"), for: .normal)
        avatarBtn.addTarget(self, action: #selector(clickSend), for: .touchUpInside)
        imageView.addSubview(avatarBtn)
        self.avatarBtn = avatarBtn
        avatarBtn.snp.makeConstraints { (make) in
            make.centerX.equalTo(imageView)
            make.centerY.equalTo(imageView).offset(-75/2)
            make.size.equalTo(CGSize(width: 75, height: 75))
        }

        let avatarName = UILabel()
        avatarName.text = "登录"
        avatarName.textColor = DTWhiteColor()
        avatarName.font = UIFont.systemFont(ofSize: 18)
        avatarName.textAlignment = .center
        imageView.addSubview(avatarName)
        avatarName.snp.makeConstraints { (make) in
            make.top.equalTo(avatarBtn.snp.bottom)
            make.left.equalTo(avatarBtn)
            make.width.equalTo(avatarBtn)
            make.height.equalTo(22)
        }
        let tap = UITapGestureRecognizer(target: self, action: #selector(clickSend))
        avatarName.addGestureRecognizer(tap)
        imageView.isUserInteractionEnabled = true
        avatarName.isUserInteractionEnabled = true

        let heardView = ParallaxHeaderView(style: .default, subView: imageView, headerViewSize: CGSize(width: tableView.bounds.width, height: 200), maxOffsetY: -150, delegate: self)
        tableView.tableHeaderView = heardView
        tableView.tableFooterView = UIView()

    }

    func transitionAvatar(_ offSetY: CGFloat) {

        UIView.animate(withDuration: 0.1) {
            self.avatarBtn.transform = CGAffineTransform(scaleX: offSetY, y: offSetY)
        }
    }


}



