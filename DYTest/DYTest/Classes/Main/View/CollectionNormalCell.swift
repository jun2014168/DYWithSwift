//
//  CollectionNormalCell.swift
//  DYTest
//
//  Created by 倪庆军 on 2017/2/28.
//  Copyright © 2017年 jun. All rights reserved.
//

import UIKit

class CollectionNormalCell: UICollectionViewCell {

    @IBOutlet weak var titleL: UILabel!
    @IBOutlet weak var bgImageV: UIImageView!
    @IBOutlet weak var nameL: UILabel!
    @IBOutlet weak var onlineBtn: UIButton!
    
    
    var anchro:AnchroModel? {
        didSet{
            guard let anchro = anchro else { return }
            titleL.text = anchro.room_name
            bgImageV.kf.setImage(with: URL(string: anchro.vertical_src))
            
            nameL.text = anchro.nickname
            onlineBtn.setTitle("\(anchro.online)", for: .normal)
            
        }
    }
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
