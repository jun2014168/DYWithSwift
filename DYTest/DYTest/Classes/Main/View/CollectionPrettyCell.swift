//
//  CollectionPrettyCell.swift
//  DYTest
//
//  Created by 倪庆军 on 2017/2/28.
//  Copyright © 2017年 jun. All rights reserved.
//

import UIKit
import Kingfisher

class CollectionPrettyCell: CollectionBaseCell {

    /// 城市
    @IBOutlet weak var cityL: UILabel!
    

    override var anchro : AnchroModel? {
        didSet{
            super.anchro = anchro
            guard let anchro = anchro else { return  }
            cityL.text = anchro.anchor_city
            onlineBtn.setTitle("  \(anchro.online)人在线  ", for: .normal)
        }
        
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
