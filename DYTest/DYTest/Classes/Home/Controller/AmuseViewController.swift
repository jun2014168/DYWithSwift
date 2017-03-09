//
//  AmuseViewController.swift
//  DYTest
//
//  Created by 倪庆军 on 2017/3/9.
//  Copyright © 2017年 jun. All rights reserved.
//

import UIKit

class AmuseViewController: BaseAnchroViewController {
    
    fileprivate lazy var amuseViewModel : AmuseViewModel = AmuseViewModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}

extension AmuseViewController {
    // 重写父类方法
    override func loadData(){
        // 给父类baseVM赋值
        baseVM = amuseViewModel
        // 请求数据
        amuseViewModel.requestAmuseData {
            self.collectionView.reloadData()
        }
    }
    
}


