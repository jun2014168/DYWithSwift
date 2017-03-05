//
//  RecommandCycleView.swift
//  DYTest
//
//  Created by 倪庆军 on 2017/3/5.
//  Copyright © 2017年 jun. All rights reserved.
//

import UIKit

private let kCycleViewCellID = "kCycleViewCellID"

class RecommandCycleView: UIView {

    var cycleModels : [CycleModel]?{
        didSet{
            // 刷新collectionView
            collectionView.reloadData()
            // 设置pageControl 页数
            pageControl.numberOfPages = cycleModels?.count ?? 0
        }
    }
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // 注册cell
        collectionView.register(UINib(nibName: "CycleCell", bundle: nil), forCellWithReuseIdentifier: kCycleViewCellID)
        collectionView.dataSource = self
        collectionView.delegate = self
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        
        let layer = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layer.itemSize = collectionView.bounds.size
        
    }
}

extension RecommandCycleView {
    class func recommanCycleView() -> RecommandCycleView {
        return Bundle.main.loadNibNamed("RecommandCycleView", owner: nil, options: nil)?.first as! RecommandCycleView
    }
}

extension RecommandCycleView: UICollectionViewDataSource {
    
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
        pageControl.currentPage = Int(offsetX / scrollView.bounds.width)
        
    }
}

extension RecommandCycleView : PageContentViewDelegate {
    func pageContentView(contentView: PageContentView, progress: CGFloat, sourceIndex: Int, targetIndex: Int) {
        print(progress,sourceIndex)
    }
}
