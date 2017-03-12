//
//  AnchroGroup.swift
//  DYTest
//
//  Created by 倪庆军 on 2017/3/2.
//  Copyright © 2017年 jun. All rights reserved.
//

import UIKit

class AnchroGroup: BaseGameModel {

    /// 房间信息
    var room_list : [[String : NSObject]]?{
        didSet{
            guard let room_list = room_list else { return }
            for dict in room_list {
                anchros.append(AnchroModel(dict: dict))
            }
        }
    }
    /// 组图标
    var icon_name : String = "home_header_normal"
    
    // 主播模型数组
    lazy var anchros : [AnchroModel] = [AnchroModel]()
    
    
    
}
