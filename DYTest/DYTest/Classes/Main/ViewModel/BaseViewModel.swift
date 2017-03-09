//
//  BaseViewModel.swift
//  DYTest
//
//  Created by 倪庆军 on 2017/3/9.
//  Copyright © 2017年 jun. All rights reserved.
//

import UIKit

class BaseViewModel {
    
    lazy var anchroGroup : [AnchroGroup] = [AnchroGroup]()
}
extension BaseViewModel {
    
    func requestAnchroData(url : String,  parameters : [String : Any]?=nil,finishCallBack : @escaping ()->()){
        
        NetworkTool.requestData(type: .GET, url: url ,parameters: parameters) { (result) in
            
            // 将result 转成字典模型
            guard let resultDict = result as? [String : NSObject] else {return}
            
            // 根据data的key 获取数组
            guard let dataArr = resultDict["data"] as? [[String : NSObject]] else {return}
            
            // 遍历数组
            for dict in dataArr {
                self.anchroGroup.append(AnchroGroup(dict: dict))
            }
            
            finishCallBack()
        }
        
    }
}
