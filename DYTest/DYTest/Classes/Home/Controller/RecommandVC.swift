//
//  RecommandVC.swift
//  DYTest
//
//  Created by 倪庆军 on 2017/2/27.
//  Copyright © 2017年 jun. All rights reserved.
//  推荐

import UIKit

private let kCycleViewH : CGFloat = kScreenW * 3 / 8

private let kItemMargin : CGFloat = 10
private let kItemW : CGFloat = (kScreenW - 3 * kItemMargin) / 2
private let kItemH : CGFloat = kItemW * 3 / 4
private let kPrettyItemH : CGFloat = kItemW * 4 / 3

private let kNormalCellID = "kNormalCellID"
private let kPrettyCellID = "kPrettyCellID"
private let kHeadViewID = "kHeadViewID"
private let kHeadViewH : CGFloat = 50

class RecommandVC: UIViewController {

    
    // MARK: -懒加载属性
    lazy var recommandViewModel : RecommandViewModel = RecommandViewModel()
    
    private lazy var collectionView : UICollectionView = { [unowned self] in
        // 布局
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kItemW, height: kItemH)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = kItemMargin
        layout.headerReferenceSize = CGSize(width: kScreenW, height: kHeadViewH)
        layout.sectionInset = UIEdgeInsetsMake(0, kItemMargin, 0, kItemMargin)
        
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.autoresizingMask = [.flexibleHeight,.flexibleWidth]
        // 注册默认cell
        collectionView.register(UINib(nibName: "CollectionNormalCell", bundle: nil), forCellWithReuseIdentifier: kNormalCellID)
        
        collectionView.register(UINib(nibName: "CollectionPrettyCell", bundle: nil), forCellWithReuseIdentifier: kPrettyCellID)
        
        // 注册Headviewcell
        collectionView.register(UINib(nibName: "CollectionHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: kHeadViewID)
        
        collectionView.backgroundColor = UIColor.white
        return collectionView
        
    }()
    private lazy var cycleView : RecommandCycleView = {
        
        let cycleView = RecommandCycleView.recommanCycleView()
        cycleView.frame = CGRect(x: 0, y: -kCycleViewH, width: kScreenW, height: kCycleViewH)
        
        return cycleView
        
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 设置UI
        setupUI()
        
        // 加载数据
        loadData()
    }
    // MARK: -设置UI
    private func setupUI() {
        view.addSubview(collectionView)
        
        collectionView.addSubview(cycleView)
        
        // 设置contentInset  显示cycleView
        collectionView.contentInset = UIEdgeInsets(top: kCycleViewH, left: 0, bottom: 0, right: 0)
    }
    private func loadData(){
        // 轮播数据
        recommandViewModel.requestCycleData(finshCallBack: {
        
            
            if self.recommandViewModel.cycleModel.count > 0 {
                
                self.cycleView.cycleModels = self.recommandViewModel.cycleModel
            }else {
                // 设置contentInset  隐藏cycleView
                self.collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            }
        })
        
        recommandViewModel.requestData { 
            self.collectionView.reloadData()
        }
    }

    
}
extension RecommandVC : UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout{
    // MARK: -UICollectionViewDataSource,UICollectionViewDelegate
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return recommandViewModel.anchroGroup.count
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        let group = recommandViewModel.anchroGroup[section]
        return group.anchros.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
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
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headView  = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kHeadViewID, for: indexPath) as! CollectionHeaderView
        
        // 取出模型
        let group = recommandViewModel.anchroGroup[indexPath.section]
        
        headView.group = group
        
        return headView
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 1 {
            
            return CGSize(width: kItemW, height: kPrettyItemH)
        }
        return CGSize(width: kItemW, height: kItemH)
    }

}
