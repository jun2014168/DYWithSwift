//
//  BaseAnchroViewController.swift
//  DYTest
//
//  Created by 倪庆军 on 2017/3/9.
//  Copyright © 2017年 jun. All rights reserved.
//

import UIKit

private let kItemMargin : CGFloat = 10

private let kHeadViewID = "kHeadViewID"
private let kHeadViewH : CGFloat = 50

let kNormalCellID = "kNormalCellID"
let kPrettyCellID = "kPrettyCellID"
let kNormalItemW : CGFloat = (kScreenW - 3 * kItemMargin) / 2
let kNormalItemH : CGFloat = kNormalItemW * 3 / 4
let kPrettyItemH : CGFloat = kNormalItemW * 4 / 3

class BaseAnchroViewController: BaseViewController {

    var baseVM : BaseViewModel!
    
    lazy var collectionView : UICollectionView = { [unowned self] in
        // 布局
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kNormalItemW, height: kNormalItemH)
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

    override func viewDidLoad() {
        super.viewDidLoad()
    
        loadData()

    }

}
extension BaseAnchroViewController {
    override func setupUI() {
        contentView = collectionView
        
        view.addSubview(self.collectionView)
        
        super.setupUI()
    }
    // 让子类加载自己的数据
    func loadData(){
    
    }
    
}
extension BaseAnchroViewController : UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return baseVM.anchroGroup.count
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        let group = baseVM.anchroGroup[section]
        return group.anchros.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // 取出模型
        let group = baseVM.anchroGroup[indexPath.section]
        let anchro = group.anchros[indexPath.item]
        
        var cell = CollectionBaseCell()
        
        cell = collectionView.dequeueReusableCell(withReuseIdentifier: kNormalCellID, for: indexPath) as! CollectionNormalCell
        
        cell.anchro = anchro
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headView  = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kHeadViewID, for: indexPath) as! CollectionHeaderView
        
        // 取出模型
        let group = baseVM.anchroGroup[indexPath.section]
        
        headView.group = group
        
        return headView
    }
    
    
}

extension BaseAnchroViewController : UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        // 取出anchro
        let group = baseVM.anchroGroup[indexPath.section]
        let anchro = group.anchros[indexPath.item]
        
        anchro.isVertical == 0 ? pushNormalRoom() : presentShowRoom()
        
    }
    
    private func presentShowRoom() {
        let showRoomVC = RoomShowViewController()
        
        present(showRoomVC, animated: true, completion: nil)
    }
    private func pushNormalRoom() {
        let normalRoomVC = RoomViewController()
        
        normalRoomVC.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(normalRoomVC, animated: true)
    }
}
