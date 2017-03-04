//
//  NetworkTool.swift
//  DYTest
//
//  Created by 倪庆军 on 2017/3/1.
//  Copyright © 2017年 jun. All rights reserved.
//

import UIKit
import Alamofire

enum MethodType {
    case GET
    case POST
}

class NetworkTool {

    class func requestData(type: MethodType, url: String, parameters: [String : String]?=nil,finishedCallback: @escaping (_ result: AnyObject)->()) {
        // 获取类型
        let method = (type == .GET) ? HTTPMethod.get : HTTPMethod.post
        
        // 发送请求
        Alamofire.request(url, method: method, parameters: parameters).responseJSON {
            response in
            
            guard let result = response.result.value else {
                
                print(response.result.error ?? "请求失败！")
                return
            }
            finishedCallback(result as AnyObject)
        }
        
        
    }
}
