//
//  CycleCell.swift
//  DYTest
//
//  Created by 倪庆军 on 2017/3/5.
//  Copyright © 2017年 jun. All rights reserved.
//

import UIKit

class CycleCell: UICollectionViewCell {

    
    @IBOutlet weak var imageV: UIImageView!
    
    @IBOutlet weak var titleL: UILabel!
    
    
    var cycleModel : CycleModel? {
        didSet{
        
            guard let cycleModel = cycleModel else { return }
            titleL.text = "  "+cycleModel.title
            guard let url = URL(string: cycleModel.pic_url) else { return  }
            imageV.kf.setImage(with: url)
        }
    }
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
