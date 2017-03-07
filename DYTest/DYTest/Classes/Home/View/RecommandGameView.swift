//
//  RecommandGameView.swift
//  DYTest
//
//  Created by 倪庆军 on 2017/3/6.
//  Copyright © 2017年 jun. All rights reserved.
//

import UIKit

private let kGameCell = "kGameCell"
class RecommandGameView: UIView {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var gameModels : [GameModel]?{
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
    }

}

// MARK: - UICollectionViewDataSource
extension RecommandGameView : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 8
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
