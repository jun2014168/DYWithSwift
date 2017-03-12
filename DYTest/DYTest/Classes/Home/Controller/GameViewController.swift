//
//  GameViewController.swift
//  DYTest
//
//  Created by 倪庆军 on 2017/3/7.
//  Copyright © 2017年 jun. All rights reserved.
//

import UIKit

private let kItemMargin : CGFloat = 10
private let kItemW : CGFloat = (kScreenW - 2 * kItemMargin) / 3
private let kItemH : CGFloat = kItemW * 6 / 5
private let kHeadViewH : CGFloat = 40
private let kGameViewH : CGFloat = 90

private let kGameViewCellID = "kGameViewCellID"
private let kHeaderViewID = "kHeaderViewID"

class GameViewController: BaseViewController {
    // MARK: -懒加载属性
    fileprivate lazy var gameViewModel : GameViewModel = GameViewModel()

    fileprivate lazy var collectionView : UICollectionView = { [unowned self] in
        // 布局
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kItemW, height: kItemH)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsetsMake(0, kItemMargin, 0, kItemMargin)
        layout.headerReferenceSize = CGSize(width: kScreenW, height: kHeadViewH)
        
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.autoresizingMask = [.flexibleHeight,.flexibleWidth]
        
        // 注册默认cell
        collectionView.register(UINib(nibName: "GameCell", bundle: nil), forCellWithReuseIdentifier: kGameViewCellID)
        
        // 注册Headview
        collectionView.register(UINib(nibName: "CollectionHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: kHeaderViewID)
        
        
        collectionView.backgroundColor = UIColor.white
        return collectionView

    }()
    fileprivate lazy var headerView : CollectionHeaderView = {
        let headView = CollectionHeaderView.headerView()
        headView.frame = CGRect(x: 0, y: -kHeadViewH-kGameViewH, width: kScreenW, height: kHeadViewH)
        headView.groupIcon.image = UIImage(named: "Img_orange")
        headView.groupName.text = "常见"
        headView.moreBtn.isHidden = true
        
        return headView
        
    }()
    
    fileprivate lazy var gameView : RecommandGameView = {
        let gameV = RecommandGameView.recommanGameView()
        gameV.frame = CGRect(x: 0, y: -kGameViewH, width: kScreenW, height: kGameViewH)
        
        return gameV
        
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // 加载数据
        loadData()
        
    
    }
}
extension GameViewController{
    override func setupUI(){
        
        contentView = collectionView
        
        view.addSubview(collectionView)
        
        collectionView.addSubview(headerView)
        collectionView.addSubview(gameView)
        
        collectionView.contentInset = UIEdgeInsets(top: kHeadViewH+kGameViewH, left: 0, bottom: 0, right: 0)
        
        super.setupUI()
        
    }
    fileprivate func loadData() {
        gameViewModel.requestGamesData {
            self.collectionView.reloadData()
            
            self.gameView.gameModels = Array(self.gameViewModel.gameModel[0..<10])
            
            // 数据加载完成
            self.loadDataFinish()
        }
    }
}

extension GameViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return gameViewModel.gameModel.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kGameViewCellID, for: indexPath) as! GameCell
        
        cell.gameModel = gameViewModel.gameModel[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kHeaderViewID, for: indexPath) as! CollectionHeaderView
        
        headerView.groupName.text = "全部"
        headerView.groupIcon.image = UIImage(named: "Img_orange")
        headerView.moreBtn.isHidden = true
    
        return headerView
    
    }
    
    
}
