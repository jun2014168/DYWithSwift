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
            
            imageV.kf.setImage(with: URL(string: cycleModel.pic_url))
            
            titleL.text = "  "+cycleModel.title
            
        }
    }
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
