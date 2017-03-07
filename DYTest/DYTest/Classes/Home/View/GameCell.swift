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
    
    var gameModel : GameModel? {
        didSet{
            
            guard let gameModel = gameModel else { return }
            titleL.text = gameModel.game_name
            guard let url = URL(string: gameModel.game_src) else { return  }
            iconView.kf.setImage(with: url)
            
        }
    }

    
    override func awakeFromNib() {
        super.awakeFromNib()
        iconView.layer.cornerRadius = iconView.bounds.size.height * 0.5
        iconView.layer.masksToBounds = true
        
    }

}
