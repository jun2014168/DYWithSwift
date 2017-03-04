//
//  CollectionPrettyCell.swift
//  DYTest
//
//  Created by 倪庆军 on 2017/2/28.
//  Copyright © 2017年 jun. All rights reserved.
//

import UIKit
import Kingfisher

class CollectionPrettyCell: UICollectionViewCell {

    // 在线人数
    @IBOutlet weak var onlineL: UILabel!
    @IBOutlet weak var anchroImageView: UIImageView!
    @IBOutlet weak var titleL: UILabel!
    /// 城市
    @IBOutlet weak var cityL: UILabel!
    
    
    var anchro : AnchroModel? {
        didSet{
            guard let anchro = anchro else { return }
            onlineL.text = "\(anchro.online)在线"
            titleL.text = anchro.room_name
            cityL.text = anchro.anchor_city
            
            anchroImageView.kf.setImage(with: URL(string: anchro.vertical_src))
            
        }
        
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
