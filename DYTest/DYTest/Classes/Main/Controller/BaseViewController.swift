//
//  BaseViewController.swift
//  DYTest
//
//  Created by 倪庆军 on 2017/3/10.
//  Copyright © 2017年 jun. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    var contentView : UIView?
    
    /// 加载动画
    fileprivate lazy var animationView : UIImageView = {
        let animationV = UIImageView(image: UIImage(named: "img_loading_1"))
        animationV.center = self.view.center
        animationV.animationImages = [UIImage(named: "img_loading_1")!,UIImage(named: "img_loading_2")!]
        animationV.animationDuration = 0.45
        animationV.animationRepeatCount = LONG_MAX
        animationV.autoresizingMask = [.flexibleTopMargin,.flexibleBottomMargin]
        return animationV
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 统一背景色
        view.backgroundColor = UIColor.init(r: 244, g: 244, b: 244)
        // 设置UI
        setupUI()
    }
    

}

extension BaseViewController {
    func setupUI() {
        // 隐藏contentView
        contentView?.isHidden = true
        
        view.addSubview(animationView)
        
        // 开始动画
        animationView.startAnimating()
    
    }
    
    func loadDataFinish() {
        // 结束动画
        animationView.stopAnimating()
        
        animationView.isHidden = true
        
        contentView?.isHidden = false
        
    }
}
