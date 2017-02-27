//
//  UIBarButtonItem-Extension.swift
//  DYTest
//
//  Created by 倪庆军 on 2017/2/26.
//  Copyright © 2017年 jun. All rights reserved.
//

import UIKit

extension UIBarButtonItem {
    
    // 根据苹果设计，使用便利构造函数
    convenience init(normalImgName:String, highImgName:String = "",size : CGSize = CGSize.zero) {
        let btn = UIButton()
        
        btn.setImage(UIImage(named: normalImgName), for: .normal)
        if highImgName != "" {
            btn.setImage(UIImage(named: highImgName), for: .highlighted)
        }
        
        if size == CGSize.zero {
            btn.sizeToFit()
        }else {
            btn.frame = CGRect(origin: CGPoint.zero, size: size)
            
        }
        
        self.init(customView : btn)
        
    }
    
}
