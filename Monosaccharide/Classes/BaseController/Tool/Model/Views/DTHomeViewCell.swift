//
//  DTHomeViewCell.swift
//  Monosaccharide
//
//  Created by dashuios126 on 17/2/24.
//  Copyright © 2017年 dashuios126. All rights reserved.
//

import UIKit

protocol DTHomeViewCellDelegate: NSObjectProtocol{
    func homeCellDidClickedFavoriteButton(_ button: UIButton)
}

class DTHomeViewCell: UITableViewCell {

    weak var delegate: DTHomeViewCellDelegate?


    @IBOutlet weak var favour_btn: UIButton!

    @IBOutlet weak var title_Label: UILabel!

    @IBOutlet weak var content_imageView: UIImageView!
    open var item: DTHomeItems? {

        didSet{
           let title = String(item!.likes_count)
            favour_btn.setTitle(" "+title+" ", for: .normal)
            title_Label.text = item!.title
            let url = item!.cover_image_url
            content_imageView.kf.setImage(with: URL(string: url!), placeholder: nil, options: nil, progressBlock: nil, completionHandler: nil)
        }
    }


    @IBAction func click_favour(_ sender: UIButton) {
//        print("homeCell---click_favour---")
        delegate?.homeCellDidClickedFavoriteButton(sender)
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        content_imageView.layer.cornerRadius = kCornerRadius
        content_imageView.layer.masksToBounds = true
        content_imageView.layer.shouldRasterize = true
        content_imageView.layer.rasterizationScale = UIScreen.main.scale

        favour_btn.layer.cornerRadius = favour_btn.height*0.5
        favour_btn.layer.masksToBounds = true
        favour_btn.layer.shouldRasterize = true
        favour_btn.layer.rasterizationScale = UIScreen.main.scale
        // Configure the view for the selected state
    }

}
