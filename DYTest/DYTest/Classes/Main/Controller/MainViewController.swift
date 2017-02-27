//
//  MainViewController.swift
//  DYTest
//
//  Created by 倪庆军 on 2017/2/26.
//  Copyright © 2017年 jun. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        addChildViewController(storyBoardName: "Home")
        addChildViewController(storyBoardName: "Live")
        addChildViewController(storyBoardName: "Profile")
        addChildViewController(storyBoardName: "Mine")
        
    }
    
    // MARK: -通过storyBoard添加子自控制器
    private func addChildViewController(storyBoardName:String){
        
        let vc = UIStoryboard.init(name: storyBoardName, bundle: nil).instantiateInitialViewController()!
        
        addChildViewController(vc)
    }
}
