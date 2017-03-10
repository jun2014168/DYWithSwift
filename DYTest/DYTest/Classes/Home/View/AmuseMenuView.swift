//
//  AmuseMenuView.swift
//  DYTest
//
//  Created by 倪庆军 on 2017/3/10.
//  Copyright © 2017年 jun. All rights reserved.
//

import UIKit

private let kMenuViewCell = "kMenuViewCell"

class AmuseMenuView: UIView {
    
    var anchroGroup : [AnchroGroup]? {
        didSet {
            self.collectionView.reloadData()
        }
    }
    

    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // 注册cell
        collectionView.register(UINib(nibName: "AmuseMenuCell", bundle: nil), forCellWithReuseIdentifier: kMenuViewCell)
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let layer = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layer.itemSize = collectionView.bounds.size
    }
    
}


extension AmuseMenuView : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if anchroGroup == nil {
            return 0
        }
        let pageNum = anchroGroup!.count  / 8 + 1
        pageControl.numberOfPages = pageNum
        return pageNum
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kMenuViewCell, for: indexPath) as! AmuseMenuCell
        
        // 设置数据
        setUpCellData(cell: cell, indexPath: indexPath)
        
        return cell
        
    }
    
    private func setUpCellData(cell: AmuseMenuCell, indexPath: IndexPath){
        // 0页：0-7  1：8-15 2：16-23
        let startIndex = indexPath.item * 8
        var endIndex = (indexPath.item + 1) * 8 - 1
        
        if endIndex > anchroGroup!.count - 1 {
            endIndex = anchroGroup!.count - 1
        }
        
        cell.group = Array(self.anchroGroup![startIndex...endIndex])
    
    }
}

extension AmuseMenuView : UICollectionViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let offsetX = scrollView.contentOffset.x + scrollView.bounds.width * 0.5
        pageControl.currentPage = Int(offsetX / scrollView.bounds.width) % (pageControl.numberOfPages )
    }
}


extension AmuseMenuView {
    class func amuseMenuView() -> AmuseMenuView {
        return Bundle.main.loadNibNamed("AmuseMenuView", owner: nil, options: nil)?.first as! AmuseMenuView
    }
}
