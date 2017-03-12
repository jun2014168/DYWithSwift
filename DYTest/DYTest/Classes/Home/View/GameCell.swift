//
//  GameCell.swift
//  DYTest
//
//  Created by 倪庆军 on 2017/3/7.
//  Copyright © 2017年 jun. All rights reserved.
//

import UIKit

class GameCell: UICollectionViewCell {

    @IBOutlet weak var iconView: UIImageView!
    @IBOutlet weak var titleL: UILabel!
    
    var gameModel : BaseGameModel? {
        didSet{
            guard let gameModel = gameModel else { return }
            titleL.text = gameModel.tag_name
            guard let url = URL(string: gameModel.icon_url) else {
                iconView.image = UIImage(named: "home_more_btn")
                return
            }
            iconView.kf.setImage(with: url)
            
        }
    }

    
    override func awakeFromNib() {
        super.awakeFromNib()
        iconView.layer.cornerRadius = iconView.bounds.size.height * 0.5
        iconView.layer.masksToBounds = true
        
    }

}
