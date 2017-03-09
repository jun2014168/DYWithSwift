//
//  RecommandViewModel.swift
//  DYTest
//
//  Created by 倪庆军 on 2017/3/2.
//  Copyright © 2017年 jun. All rights reserved.
//

import UIKit

class RecommandViewModel : BaseViewModel{
    
    // 轮播数据
    lazy var cycleModel : [CycleModel] = [CycleModel]()
    
    /// 0 1 2-12组数据
    var prettyData : AnchroGroup = AnchroGroup()
    var bigData : AnchroGroup = AnchroGroup()
    
}

extension RecommandViewModel {
    func requestData(finshCallBack : @escaping ()->()) {
        /// 请求参数
        let parameters = ["limit":"6","time":NSDate.getCurrentTime(),"offset":"0"]
        
        // 创建异步组  为了保证数据的正确排序
        let dgroup = DispatchGroup()
        
        
        dgroup.enter()
        // 请求第一部分数据
        NetworkTool.requestData(type: .GET, url: "https://capi.douyucdn.cn/api/v1/getbigDataRoom", parameters: ["time":NSDate.getCurrentTime()], finishedCallback: { (result) in
            
            // 将result 转成字典模型
            guard let resultDict = result as? [String : NSObject] else {return}
            
            // 根据data的key 获取数组
            guard let dataArr = resultDict["data"] as? [[String : NSObject]] else {return}
            
            self.bigData.tag_name = "热门"
            self.bigData.icon_name = "home_header_hot"
            // 遍历数组
            for dict in dataArr {
                let anchro = AnchroModel(dict: dict)
                self.bigData.anchros.append(anchro)
            }
            // 离开组
            dgroup.leave()
        })
        
        dgroup.enter()
        // 请求第二部分数据
        NetworkTool.requestData(type: .GET, url: "https://capi.douyucdn.cn/api/v1/getVerticalRoom", parameters: parameters, finishedCallback: { (result) in
        
            // 将result 转成字典模型
            guard let resultDict = result as? [String : NSObject] else {return}
            
            // 根据data的key 获取数组
            guard let dataArr = resultDict["data"] as? [[String : NSObject]] else {return}
            
            self.prettyData.tag_name = "颜值"
            self.prettyData.icon_name = "home_header_phone"
            
            // 遍历数组
            for dict in dataArr {
                let anchro = AnchroModel(dict: dict)
                self.prettyData.anchros.append(anchro)
            }
            // 离开组
            dgroup.leave()
        })
        
        dgroup.enter()
        // 第三部分数据
        requestAnchroData(url: "https://capi.douyucdn.cn/api/v1/getHotCate", parameters: parameters) {
            // 离开组
            dgroup.leave()
        }
        
        // 排序
        dgroup.notify(queue: .main) { 
            self.anchroGroup.insert(self.prettyData, at: 0)
            self.anchroGroup.insert(self.bigData, at: 0)
            
            finshCallBack()
        }
        
    }
    
    // 请求轮播数据
    func requestCycleData(finshCallBack : @escaping ()->()) {
        NetworkTool.requestData(type: .GET, url: "http://capi.douyucdn.cn/api/v1/slide/6", parameters: ["version":"2.4"], finishedCallback: {
            (result) in
            
            // 将result 转成字典模型
            guard let resultDict = result as? [String : NSObject] else {return}
            
            // 根据data的key 获取数组
            guard let dataArr = resultDict["data"] as? [[String : NSObject]] else {return}
            
            // 遍历数组
            for dict in dataArr {
                self.cycleModel.append(CycleModel(dict: dict))
            }
            
            finshCallBack()
        })

    }
    
}
