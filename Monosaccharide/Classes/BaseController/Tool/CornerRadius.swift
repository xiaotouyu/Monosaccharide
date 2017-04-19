//
//  CornerRadius.swift
//  Monosaccharide
//
//  Created by dashuios126 on 17/3/15.
//  Copyright © 2017年 dashuios126. All rights reserved.
//

import UIKit

extension UIView {

    @IBInspectable var cornerRadius: CGFloat {
        set{
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
        get{
            return layer.cornerRadius
        }
    }
    @IBInspectable var borderWidth: CGFloat {
        set{
            layer.borderWidth = newValue
        }
        get{
            return layer.borderWidth
        }
    }
    @IBInspectable var borderColor: UIColor? {
        set{
            layer.borderColor = newValue?.cgColor
        }
        get{
            return layer.borderColor != nil ? UIColor(cgColor: layer.borderColor!) : nil
        }
    }
}
