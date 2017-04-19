//
//  DTSingleProductCollectionViewCell.swift
//  Monosaccharide
//
//  Created by dashuios126 on 17/3/7.
//  Copyright © 2017年 dashuios126. All rights reserved.
//

import UIKit

class DTSingleProductCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var titleLabel: UILabel!

    @IBOutlet weak var favouriteBtn: UIButton!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var displayImageView: UIImageView!
    
    open var itemList: DTSingleProductDataItems? {
        didSet{

            displayImageView.kf.setImage(with: URL(string: (itemList?.cover_image_url)!))
            titleLabel.text = itemList?.name
            priceLabel.text = "¥ " + (itemList?.price)!
            favouriteBtn.setTitle(String(describing: itemList!.favorites_count), for: .normal)
        }
    }



}
