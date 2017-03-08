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

private let kGameViewCellID = "kGameViewCellID"

class GameViewController: UIViewController {
    // MARK: -懒加载属性
    fileprivate lazy var gameViewModel : GameViewModel = GameViewModel()

    
    fileprivate lazy var collectionView : UICollectionView = { [unowned self] in
        // 布局
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kItemW, height: kItemH)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsetsMake(0, kItemMargin, 0, kItemMargin)
        
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.autoresizingMask = [.flexibleHeight,.flexibleWidth]
        
        // 注册默认cell
        collectionView.register(UINib(nibName: "GameCell", bundle: nil), forCellWithReuseIdentifier: kGameViewCellID)
        
        collectionView.backgroundColor = UIColor.white
        return collectionView

    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //设置UI
        setupUI()
        // 加载数据
        loadData()
        
    
    }
}
extension GameViewController{
    fileprivate func setupUI(){
        view.addSubview(collectionView)
        
        
    }
    fileprivate func loadData() {
        gameViewModel.requestGamesData {
            self.collectionView.reloadData()
        }
    }
}

extension GameViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return gameViewModel.gameModel.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kGameViewCellID, for: indexPath) as! GameCell
        
        cell.gamesModel = gameViewModel.gameModel[indexPath.item]
        return cell
    }
}
