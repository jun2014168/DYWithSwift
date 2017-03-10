//
//  FunnyViewModel.swift
//  DYTest
//
//  Created by 倪庆军 on 2017/3/10.
//  Copyright © 2017年 jun. All rights reserved.
//

import UIKit

class FunnyViewModel: BaseViewModel {

}

extension FunnyViewModel {
    func requestFunnyData(finishCallBack : @escaping ()->()){
        
        requestAnchroData(isGroup: false,url: "https://capi.douyucdn.cn/api/v1/getColumnRoom/3", parameters: ["limit" : "20","offset":"0"],finishCallBack: finishCallBack)
    }
}
