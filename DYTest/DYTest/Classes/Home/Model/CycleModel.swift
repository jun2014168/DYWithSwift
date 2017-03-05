//
//  CycleModel.swift
//  DYTest
//
//  Created by 倪庆军 on 2017/3/5.
//  Copyright © 2017年 jun. All rights reserved.
//

import UIKit

class CycleModel: NSObject {

    var title : String = ""
    var pic_url : String = ""
    
    var room : [String:NSObject]?{
        didSet{
            guard let room = room else { return }
            anchro = AnchroModel(dict: room)
        }
    }
    
    var anchro : AnchroModel?
    
    
    
    init(dict : [String : NSObject]) {
        super.init()
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
    
}
