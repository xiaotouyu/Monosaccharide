//
//  DTLoginViewController.swift
//  Monosaccharide
//
//  Created by dashuios126 on 17/3/14.
//  Copyright © 2017年 dashuios126. All rights reserved.
//

import UIKit

class DTLoginViewController: UIViewController {

    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

//        loginBtn.layer.cornerRadius = 5
        let tap = UITapGestureRecognizer(target: self, action: #selector(clickTap))
        view.addGestureRecognizer(tap)
    }
    func clickTap() {
        view.endEditing(true)
    }
    @IBAction func clickCancel(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    ///注册
    @IBAction func clickRegister(_ sender: UIButton) {
//        let shareView = DTShareView(frame: view.bounds)
//        view.addSubview(shareView)

    }
    ///登录
    @IBAction func clickLogin(_ sender: UIButton) {
    }
    ///找回密码
    @IBAction func clickForgetButton(_ sender: UIButton) {
    }
    ///新浪登录
    @IBAction func clickSina(_ sender: UIButton) {
    }
    ///微信登录
    @IBAction func clickWechat(_ sender: UIButton) {
    }
    ///QQ登录
    @IBAction func clickQQ(_ sender: UIButton) {
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
