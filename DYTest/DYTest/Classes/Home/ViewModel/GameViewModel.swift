//
//  GameViewModel.swift
//  DYTest
//
//  Created by 倪庆军 on 2017/3/8.
//  Copyright © 2017年 jun. All rights reserved.
//

import UIKit

class GameViewModel {
    
    lazy var gameModel : [GameModel] = [GameModel]()
}

extension GameViewModel {
    
    func requestGamesData(finishCallBack : @escaping ()->()){
        NetworkTool.requestData(type: .GET, url: "https://capi.douyucdn.cn/api/v1/getColumnDetail", parameters: ["shortName":"game"]) { (result) in
            // 将result 转成字典模型
            guard let resultDict = result as? [String : NSObject] else {return}
            
            // 根据data的key 获取数组
            guard let dataArr = resultDict["data"] as? [[String : NSObject]] else {return}
            
            // 遍历数组
            for dict in dataArr {
                let group = GameModel(dict: dict)
                self.gameModel.append(group)
            }
            
            finishCallBack()
        }

    }
}
