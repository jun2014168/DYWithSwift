//
//  GameModel.swift
//  DYTest
//
//  Created by 倪庆军 on 2017/3/8.
//  Copyright © 2017年 jun. All rights reserved.
//

import UIKit

class GameModel: NSObject {

    var tag_name : String = ""
    var pic_url : String = ""
    
    
    
    
    init(dict : [String : NSObject]) {
        super.init()
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) { }
    
    
}
