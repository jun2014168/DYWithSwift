//
//  BaseGameModel.swift
//  DYTest
//
//  Created by 倪庆军 on 2017/3/9.
//  Copyright © 2017年 jun. All rights reserved.
//

import UIKit

class BaseGameModel: NSObject {
    
    /// 组标题
    var tag_name : String = ""
    var icon_url : String = ""
    
    override init() {
        
    }
    
    // 利用kvc字典转模型
    init(dict:[String : Any]) {
        super.init()
        setValuesForKeys(dict)
    }
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
}
