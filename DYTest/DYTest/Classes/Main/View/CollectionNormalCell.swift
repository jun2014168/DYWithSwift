//
//  CollectionNormalCell.swift
//  DYTest
//
//  Created by 倪庆军 on 2017/2/28.
//  Copyright © 2017年 jun. All rights reserved.
//

import UIKit

class CollectionNormalCell: CollectionBaseCell {

    @IBOutlet weak var nameL: UILabel!
    
    
    override var anchro:AnchroModel? {
        didSet{
            
            super.anchro = anchro
            nameL.text = anchro?.nickname
            
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
