//
//  DTGuideImageViewController.swift
//  Monosaccharide
//
//  Created by dashuios126 on 17/2/17.
//  Copyright © 2017年 dashuios126. All rights reserved.
//

import UIKit
import SnapKit

class DTGuideImageViewController: UIViewController {

    fileprivate lazy var imageView:UIImageView = {

        let imageView = UIImageView(frame: self.view.bounds)
        return imageView
    }()

    fileprivate lazy var beginButton:UIButton = {

        let button = UIButton(type: .custom)
        return button
    }()

    init(imgName:String, frame:CGRect, showBtn:Bool){
        super.init(nibName: nil, bundle: nil)
        self.view.frame = frame
        self.view.addSubview(self.imageView)
        self.imageView.image = UIImage(named: imgName)

        self.beginButton.frame = CGRect(x:(self.view.bounds.width-174)/2, y:self.view.bounds.height-40-42, width:174, height:42)

        self.beginButton.setImage(UIImage(named:"btn_begin"), for: .normal)
        self.beginButton.addTarget(self, action:#selector(beginBtnClicked), for: .touchUpInside)
        self.view.addSubview(self.beginButton)
        self.beginButton.isHidden = !showBtn
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func beginBtnClicked(){

        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "beginExperience"), object: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
