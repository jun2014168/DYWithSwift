//
//  PageContentView.swift
//  DYTest
//
//  Created by 倪庆军 on 2017/2/26.
//  Copyright © 2017年 jun. All rights reserved.
//

import UIKit

private let ContentCellID = "contentCell"

class PageContentView: UIView,UICollectionViewDataSource {
    
    // MARK: -懒加载属性
    private lazy var collectionView:UICollectionView = {
        // 设置流水布局
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = self.bounds.size
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        layout.scrollDirection = .horizontal
        
        // 创建collectionView
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.bounces = false
        collectionView.dataSource = self
        // 注册cell
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: ContentCellID)
        return collectionView
    
    }()
    
    
    // MARK: -定义属性
    private var childVC : [UIViewController]
    private var parentVC : UIViewController
    
    // MARK: -自定义构造函数
    init(frame: CGRect, childVC: [UIViewController], parentVC: UIViewController) {
        self.childVC = childVC
        self.parentVC = parentVC
        
        super.init(frame: frame)
        
        // 设置UI
        setupUI()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    private func setupUI() {
        // 将所有子控制器设置到父控制器中
        for childVC in childVC {
            parentVC.addChildViewController(childVC)
        }
        // 添加collectionView
        addSubview(collectionView)
        collectionView.frame = bounds
        
        
    }
    
    // MARK: -UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return childVC.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ContentCellID, for: indexPath)
        
        // 为了安全起见
        for view in cell.contentView.subviews {
            view.removeFromSuperview()
        }
        
        let childVC = self.childVC[indexPath.item]
        childVC.view.frame = cell.contentView.bounds
        
        cell.contentView.addSubview(childVC.view)
        
        return cell
        
    }
    
}
