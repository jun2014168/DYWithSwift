//
//  AmuseViewModel.swift
//  DYTest
//
//  Created by 倪庆军 on 2017/3/9.
//  Copyright © 2017年 jun. All rights reserved.
//

import UIKit

class AmuseViewModel : BaseViewModel{
    
    
}

extension AmuseViewModel {
    
    func requestAmuseData(finishCallBack : @escaping ()->()){
        
        requestAnchroData(url: "https://capi.douyucdn.cn/api/v1/getHotRoom/2", finishCallBack: finishCallBack)
    }
}
