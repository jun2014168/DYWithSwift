//
//  CollectionBaseCell.swift
//  DYTest
//
//  Created by 倪庆军 on 2017/3/5.
//  Copyright © 2017年 jun. All rights reserved.
//

import UIKit

class CollectionBaseCell: UICollectionViewCell {
    
    // 在线人数
    @IBOutlet weak var anchroImageView: UIImageView!
    @IBOutlet weak var titleL: UILabel!
    @IBOutlet weak var onlineBtn: UIButton!
    
    var anchro : AnchroModel? {
        didSet{
            guard let anchro = anchro else { return }
            
            titleL.text = anchro.room_name
            
            anchroImageView.kf.setImage(with: URL(string: anchro.vertical_src))
            
            onlineBtn.setTitle("\(anchro.online)", for: .normal)
        }
        
    }

}
