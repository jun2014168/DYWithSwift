//
//  PageContentView.swift
//  DYTest
//
//  Created by 倪庆军 on 2017/2/26.
//  Copyright © 2017年 jun. All rights reserved.
//

import UIKit

protocol PageContentViewDelegate : class {
    func pageContentView(contentView: PageContentView,progress: CGFloat,sourceIndex: Int,targetIndex: Int)
}

private let ContentCellID = "contentCell"

class PageContentView: UIView,UICollectionViewDataSource,UICollectionViewDelegate {
    
    // MARK: -定义属性
    private var childVC : [UIViewController]
    private weak var parentVC : UIViewController?
    weak var delegate : PageContentViewDelegate?
    
    private var startOffsetX : CGFloat = 0
    private var isForbidScrollDelegate : Bool = false
    
    // MARK: -懒加载属性
    private lazy var collectionView:UICollectionView = {  [weak self] in
        // 设置流水布局
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = (self?.bounds.size)!
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        layout.scrollDirection = .horizontal
        
        // 创建collectionView
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.bounces = false
        collectionView.dataSource = self
        collectionView.delegate = self
        // 注册cell
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: ContentCellID)
        return collectionView
    
    }()
    
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
            parentVC?.addChildViewController(childVC)
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
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        isForbidScrollDelegate = false
        
        startOffsetX = scrollView.contentOffset.x
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // 判断是否是点击事件
        if isForbidScrollDelegate {
            return
        }
        
        //
        var progress : CGFloat = 0
        var sourceIndex : Int = 0
        var targetIndex : Int = 0
        // 判断左滑动还是右滑动
        let currentOffsetX = scrollView.contentOffset.x
        let scrollViewW = scrollView.bounds.width
        if currentOffsetX > startOffsetX { // 左滑动
            // 计算progress
            progress = currentOffsetX / scrollViewW - floor(currentOffsetX / scrollViewW)
            // 计算sourceIndex
            sourceIndex = Int(currentOffsetX / scrollViewW)
            // 计算targerIndex
            targetIndex = sourceIndex + 1
            
            if targetIndex >= childVC.count {
                targetIndex = childVC.count - 1
            }
            // 如果完全划过去
            if currentOffsetX - startOffsetX == scrollViewW {
                progress = 1
                targetIndex = sourceIndex
            }
        }else {
         
            // 计算progress
            progress = 1 - (currentOffsetX / scrollViewW - floor(currentOffsetX / scrollViewW))
            // 计算sourceIndex
            targetIndex = Int(currentOffsetX / scrollViewW)
            // 计算targerIndex
            sourceIndex = targetIndex + 1
            
            if targetIndex >= childVC.count {
                targetIndex = childVC.count - 1
            }

            
        }
        // 将progress sourceIndex targetIndex 传递给titleView
        delegate?.pageContentView(contentView: self, progress: progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
        
    }
    
    // MARK: -对外暴露的方法
    func setCurrentIndex(index: Int) {
        
        isForbidScrollDelegate = true
        
        let offsetX = CGFloat(index) * collectionView.frame.width
        collectionView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: false)
    }
}
