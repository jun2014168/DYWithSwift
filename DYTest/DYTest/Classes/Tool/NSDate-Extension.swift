
//
//  NSDate-Extension.swift
//  DYTest
//
//  Created by 倪庆军 on 2017/3/2.
//  Copyright © 2017年 jun. All rights reserved.
//

import Foundation

extension NSDate {
    class func getCurrentTime() -> String {
        let time = NSDate()
        
        let currentTime = Int(time.timeIntervalSince1970)
        
        return "\(currentTime)"
    }
}
