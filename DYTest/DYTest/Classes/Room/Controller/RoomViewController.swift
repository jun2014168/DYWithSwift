//
//  RoomViewController.swift
//  DYTest
//
//  Created by 倪庆军 on 2017/3/10.
//  Copyright © 2017年 jun. All rights reserved.
//

import UIKit

class RoomViewController: UIViewController {

    var anchro : AnchroModel?
    fileprivate lazy var maskImageView : UIImageView = UIImageView(frame: self.view.bounds)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.clear
        setupUI()
    }


}

extension RoomViewController {
    
    /// 设置UI
    fileprivate func setupUI() {
        
        let blurEffect = UIBlurEffect(style: .light)
        let effectView = UIVisualEffectView(effect: blurEffect)
        effectView.frame = maskImageView.bounds
        maskImageView.addSubview(effectView)
        guard let icon_URL = URL(string: (anchro?.vertical_src)!) else { return }
        maskImageView.kf.setImage(with: icon_URL)
        view.addSubview(maskImageView)
    }
}


extension RoomViewController  {
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
        
    }
}

