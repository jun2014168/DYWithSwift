//
//  RecommandVC.swift
//  DYTest
//
//  Created by 倪庆军 on 2017/2/27.
//  Copyright © 2017年 jun. All rights reserved.
//  推荐

import UIKit

private let kCycleViewH : CGFloat = kScreenW * 3 / 8
private let kGameViewH : CGFloat = 90

class RecommandVC: BaseAnchroViewController {

    
    // MARK: -懒加载属性
    lazy var recommandViewModel : RecommandViewModel = RecommandViewModel()
    
    /// 广告滚动视图
    private lazy var cycleView : RecommandCycleView = {
        let cycleView = RecommandCycleView.recommanCycleView()
        cycleView.frame = CGRect(x: 0, y: -(kCycleViewH + kGameViewH), width: kScreenW, height: kCycleViewH)
        return cycleView
    }()
    
    /// 游戏推荐视图
    private lazy var gameView : RecommandGameView = {
        let gameView = RecommandGameView.recommanGameView()
        gameView.frame = CGRect(x: 0, y: -kGameViewH, width: kScreenW, height: kGameViewH)
        return gameView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    // MARK: -设置UI
    override func setupUI() {
        super.setupUI()
        // 添加滚动视图到collectionView
        collectionView.addSubview(cycleView)
        
        // 添加游戏推荐视图到collectionView
        collectionView.addSubview(gameView)
        
        // 设置contentInset  显示cycleView
        collectionView.contentInset = UIEdgeInsets(top: kCycleViewH + kGameViewH, left: 0, bottom: 0, right: 0)
    }
    override func loadData(){
        baseVM  = recommandViewModel
        
        // 轮播数据
        recommandViewModel.requestCycleData(finshCallBack: {
            self.cycleView.cycleModels = self.recommandViewModel.cycleModel
        })
        
        recommandViewModel.requestData {
            var group = self.recommandViewModel.anchroGroup
            group.removeFirst()
            group.removeFirst()
            
            let more = AnchroGroup()
            more.tag_name = "更多"
            group.append(more)
            self.gameView.gameModels = group
            
            self.collectionView.reloadData()
            
            // 数据加载完成
            self.loadDataFinish()
        }
    }

    
}
extension RecommandVC : UICollectionViewDelegateFlowLayout{
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // 取出模型
        let group = recommandViewModel.anchroGroup[indexPath.section]
        let anchro = group.anchros[indexPath.item]
        
        var cell = CollectionBaseCell()
    
        if indexPath.section == 1 {
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: kPrettyCellID, for: indexPath) as! CollectionPrettyCell
            
        }else {
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: kNormalCellID, for: indexPath) as! CollectionNormalCell
        }
        cell.anchro = anchro
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 1 {
            
            return CGSize(width: kNormalItemW, height: kPrettyItemH)
        }
        return CGSize(width: kNormalItemW, height: kNormalItemH)
    }

}
