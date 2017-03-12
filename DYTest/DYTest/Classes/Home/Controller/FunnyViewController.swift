//
//  FunnyViewController.swift
//  DYTest
//
//  Created by 倪庆军 on 2017/3/10.
//  Copyright © 2017年 jun. All rights reserved.
//

import UIKit

private let kTopMargin : CGFloat = 10

class FunnyViewController: BaseAnchroViewController {

    fileprivate lazy var funnyVM = FunnyViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }


}

extension FunnyViewController {
    override func setupUI() {
        super.setupUI()
        
        let layer = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layer.headerReferenceSize = CGSize.zero
        
        collectionView.contentInset = UIEdgeInsets(top: kTopMargin, left: 0, bottom: 0, right: 0)
    }
    
    override func loadData() {
        baseVM = funnyVM
        
        funnyVM.requestFunnyData {
            self.collectionView.reloadData()
            
            // 数据加载完成
            self.loadDataFinish()
        }
    }
}
