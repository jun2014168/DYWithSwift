//
//  AnchroModel.swift
//  DYTest
//
//  Created by 倪庆军 on 2017/3/2.
//  Copyright © 2017年 jun. All rights reserved.
//

import UIKit

class AnchroModel: NSObject {

    /// 房间号
    var room_id : Int = 0
    /// 房间名
    var room_name : String = ""
    /// 房间图片对应的URL
    var vertical_src : String = ""
    /// 在线人数
    var online : Int = 0
    /// 判断是手机直播还是电脑直播 0是电脑直播 1是手机
    var isVertical : Int = 0
    /// 主播名
    var nickname :String = ""
    /// 主播所在城市
    var anchor_city : String = ""
    
    
    
    init(dict : [String : NSObject]) {
        super.init()
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
    
}
