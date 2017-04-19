//
//  DTHomeTopView.swift
//  Monosaccharide
//
//  Created by dashuios126 on 17/2/21.
//  Copyright © 2017年 dashuios126. All rights reserved.
//

import UIKit

class DTHomeTopView: UIView {

    open var images = [String](){
        didSet{

            self.createCustomSliderView(images)
        }
    }


    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.clear
    }

    fileprivate func createCustomSliderView(_ imageArray: [String]){
        let customView = CustomSliderView.init(frame: CGRect(x: 0, y: 0, width: SCREENW, height: self.height), type: .sourceTypeUrlSource, imageArray: imageArray, sliderTime: 3.0)
        customView.delegate = self
        self.addSubview(customView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension DTHomeTopView: CustomSliderViewDelegate {
    func clickCurrentImage(_ currentIndxe: Int) {
//        print("222----%ld",currentIndxe)
    }
}







