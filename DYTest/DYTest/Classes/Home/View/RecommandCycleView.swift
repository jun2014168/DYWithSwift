//
//  RecommandCycleView.swift
//  DYTest
//
//  Created by 倪庆军 on 2017/3/5.
//  Copyright © 2017年 jun. All rights reserved.
//

import UIKit

private let KMaxSections = 10
private let kCycleViewCellID = "kCycleViewCellID"

class RecommandCycleView: UIView {
    
    // 定时器
    var timer : Timer?

    var cycleModels : [CycleModel]?{
        didSet{
            // 刷新collectionView
            collectionView.reloadData()
            // 设置pageControl 页数
            pageControl.numberOfPages = cycleModels?.count ?? 0
            
            let indexPath = IndexPath(item: 0, section: KMaxSections / 2)
            collectionView.scrollToItem(at: indexPath, at: .left, animated: false)
            
            // 添加定时器前 先移除
            removeTimer()
            addTimer()
        }
    }
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // 设置不随父控件拉伸  这里是通过操作xib实现的 还有一种方式直接通过代码  如：RecommandGameView.swift中awakeFromNib  autoresizingMask = .init(rawValue: 0)
        
        // 注册cell
        collectionView.register(UINib(nibName: "CycleCell", bundle: nil), forCellWithReuseIdentifier: kCycleViewCellID)
        collectionView.dataSource = self
        collectionView.delegate = self
        
        
    }

    /// 布局collectionView layer
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let layer = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layer.itemSize = collectionView.bounds.size
        
    }
}

// MARK: - 定时器相关方法
private extension RecommandCycleView {
    
    /// 添加定时器
    func addTimer() {
        timer = Timer(timeInterval: 3.0, target: self, selector: #selector(scrollToNext), userInfo: nil, repeats: true)
        
        RunLoop.main.add(timer!, forMode: .commonModes)
    }
    
    /// 移除定时器
    func removeTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    /// 滚动到下一个
    @objc func scrollToNext() {
        // 立即回到中间组的数据
        let currentIndexPathReset = resetIndexPath()
        
        // 计算下一个需要展示的位置
        var nextItem = currentIndexPathReset.item + 1
        var nextSection = currentIndexPathReset.section
        if nextItem == cycleModels?.count {
            nextItem = 0
            nextSection = nextSection + 1
        }
        
        let nextIndexPath = IndexPath(item: nextItem, section: nextSection)
        
        collectionView.scrollToItem(at: nextIndexPath, at: .left, animated: true)
    }
    
    /// 重置indexPath
    func resetIndexPath() -> IndexPath {
        // 当前展示的位置
        let currentIndexPath = collectionView.indexPathsForVisibleItems.last
        // 马上回到最中间的那组数据
        let currentIndexPathReset = IndexPath(item: (currentIndexPath?.item)!, section: KMaxSections / 2)
        
        collectionView.scrollToItem(at: currentIndexPathReset, at: .left, animated: false)
        
        return currentIndexPathReset
    }
    
}

extension RecommandCycleView: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return KMaxSections
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cycleModels?.count ?? 0
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kCycleViewCellID, for: indexPath) as! CycleCell
        
        cell.cycleModel = cycleModels?[indexPath.item]
        return cell
    }
}

extension RecommandCycleView : UICollectionViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetX = scrollView.contentOffset.x + scrollView.bounds.width * 0.5
        pageControl.currentPage = Int(offsetX / scrollView.bounds.width) % (cycleModels?.count ?? 1)
        
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        removeTimer()
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        addTimer()
    }
}


// MARK: - 返回RecommandCycleView
extension RecommandCycleView {
    class func recommanCycleView() -> RecommandCycleView {
        return Bundle.main.loadNibNamed("RecommandCycleView", owner: nil, options: nil)?.first as! RecommandCycleView
    }
}
