//
//  AnchroGroup.swift
//  DYTest
//
//  Created by 倪庆军 on 2017/3/2.
//  Copyright © 2017年 jun. All rights reserved.
//

import UIKit

class AnchroGroup: NSObject {

    /// 房间信息
    var room_list : [[String : NSObject]]?{
        didSet{
            guard let room_list = room_list else { return }
            for dict in room_list {
                anchros.append(AnchroModel(dict: dict))
            }
        }
    }
    /// 组标题
    var tag_name : String = ""
    /// 组图标
    var icon_name : String = "home_header_normal"
    var icon_url : String = ""
    
    // 主播模型数组
    lazy var anchros : [AnchroModel] = [AnchroModel]()
    
    
    override init() {
        
    }
    
    // 利用kvc字典转模型
    init(dict:[String : NSObject]) {
        super.init()
        setValuesForKeys(dict)
    }
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
}
