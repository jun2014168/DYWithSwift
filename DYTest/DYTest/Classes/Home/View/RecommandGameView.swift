//
//  RecommandGameView.swift
//  DYTest
//
//  Created by 倪庆军 on 2017/3/6.
//  Copyright © 2017年 jun. All rights reserved.
//

import UIKit

private let kGameCell = "kGameCell"
private let kMargin : CGFloat = 10

class RecommandGameView: UIView {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var gameModels : [BaseGameModel]?{
        didSet{
            
            // 刷新collectionView
            collectionView.reloadData()
            
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // 设置不随父控件拉伸
        autoresizingMask = .init(rawValue: 0)
        
        // 注册cell
        collectionView.register(UINib(nibName: "GameCell", bundle: nil), forCellWithReuseIdentifier: kGameCell)
        collectionView.dataSource = self;
        
        // 设置collectionview内编剧
        collectionView.contentInset = UIEdgeInsets(top: 0, left: kMargin, bottom: 0, right: kMargin)
    }

}

// MARK: - UICollectionViewDataSource
extension RecommandGameView : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return gameModels?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kGameCell, for: indexPath) as! GameCell
        
        cell.gameModel = gameModels?[indexPath.item]
        return cell
        
    }
}

// MARK: - 返回RecommandGameView
extension RecommandGameView{
    class func recommanGameView() -> RecommandGameView {
        return Bundle.main.loadNibNamed("RecommandGameView", owner: nil, options: nil)?.first as! RecommandGameView
    }
}
