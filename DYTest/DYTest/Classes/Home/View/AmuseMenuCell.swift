//
//  AmuseMenuCell.swift
//  DYTest
//
//  Created by 倪庆军 on 2017/3/10.
//  Copyright © 2017年 jun. All rights reserved.
//

import UIKit

private let kMenuCellID = "kMenuCellID"
class AmuseMenuCell: UICollectionViewCell {

    var group : [BaseGameModel]?{
        didSet {
            self.collectionView.reloadData()
        }
    }
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        collectionView.register(UINib(nibName: "GameCell", bundle: nil), forCellWithReuseIdentifier: kMenuCellID)
        collectionView.dataSource = self
        
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let layer = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        let itemW = collectionView.bounds.size.width / 4
        let itemH = collectionView.bounds.size.height / 2
        layer.itemSize = CGSize(width: itemW, height: itemH)
        
        
    }

}

extension AmuseMenuCell : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return group?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kMenuCellID, for: indexPath) as! GameCell
        
        cell.gameModel = group?[indexPath.item]
        
        return cell
    }
}

