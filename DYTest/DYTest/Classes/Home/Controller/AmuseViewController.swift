//
//  AmuseViewController.swift
//  DYTest
//
//  Created by 倪庆军 on 2017/3/9.
//  Copyright © 2017年 jun. All rights reserved.
//

import UIKit
private let kMenuViewH : CGFloat = 200

class AmuseViewController: BaseAnchroViewController {
    
    fileprivate lazy var amuseViewModel : AmuseViewModel = AmuseViewModel()
    
    fileprivate lazy var amuseMenuView : AmuseMenuView = {
        let menuView = AmuseMenuView.amuseMenuView()
        menuView.frame = CGRect(x: 0, y: -kMenuViewH, width: kScreenW, height: kMenuViewH)
        return menuView
        
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}

extension AmuseViewController {
    // 重写父类方法
    override func setupUI() {
        super.setupUI()
        
        collectionView.addSubview(amuseMenuView)
        
        collectionView.contentInset = UIEdgeInsets(top: kMenuViewH, left: 0, bottom: 0, right: 0)
    }
    
    
    override func loadData(){
        // 给父类baseVM赋值
        baseVM = amuseViewModel
        // 请求数据
        amuseViewModel.requestAmuseData {
            
            var tempGroup = self.amuseViewModel.anchroGroup
            tempGroup.removeFirst()
            self.amuseMenuView.anchroGroup = tempGroup
            
            self.collectionView.reloadData()
            
            // 数据加载完成
            self.loadDataFinish()
        }
    }
    
}


