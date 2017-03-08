//
//  CollectionHeaderView.swift
//  DYTest
//
//  Created by 倪庆军 on 2017/2/27.
//  Copyright © 2017年 jun. All rights reserved.
//

import UIKit

class CollectionHeaderView: UICollectionReusableView {

    @IBOutlet weak var groupIcon: UIImageView!
    
    @IBOutlet weak var groupName: UILabel!
    
    @IBOutlet weak var moreBtn: UIButton!
    
    var group : AnchroGroup? {
        didSet{
            groupIcon.image = UIImage(named: group?.icon_name ?? "home_header_normal")
            
            groupName.text = group?.tag_name
        
        }
    
    }
    
    
    
    /// 更多
    @IBAction func moreBtnClick() {
        
        
        
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
}

// MARK: - 从xib 快速加载
extension CollectionHeaderView {
    class func headerView() -> CollectionHeaderView {
        return Bundle.main.loadNibNamed("CollectionHeaderView", owner: nil, options: nil)?.first as! CollectionHeaderView
    }
}
