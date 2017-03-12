//
//  CustomNavigationController.swift
//  DYTest
//
//  Created by 倪庆军 on 2017/3/11.
//  Copyright © 2017年 jun. All rights reserved.
//

import UIKit

class CustomNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 1、获取系统的pop手势
        guard let systemPop = interactivePopGestureRecognizer else { return }
        // 2、获取手势添加到view中
        guard let gesView = systemPop.view else {return}
        
        // 3、获取target action
        /* 利用运行时机制查看所有的属性名称
        var count : UInt32 = 0
        let ivars = class_copyIvarList(UIGestureRecognizer.self, &count)!
        for i in 0..<count {
            let ivar = ivars[Int(i)]
            let name = ivar_getName(ivar)
            print(String(cString: name!))
        }
        */
        
        let targets = systemPop.value(forKey: "_targets") as? [NSObject]
        guard let targetObjc = targets?.first else { return  }
        
        // 取出target  action
        guard let target = targetObjc.value(forKey: "target") else { return }
        let action = Selector(("handleNavigationTransition:"))
        
        // 创建自己的手势
        let panGes = UIPanGestureRecognizer()
        gesView.addGestureRecognizer(panGes)
        panGes.addTarget(target, action: action)
        

    }
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        navigationController?.hidesBottomBarWhenPushed = true
        
        super.pushViewController(viewController, animated: animated)
    }
}

