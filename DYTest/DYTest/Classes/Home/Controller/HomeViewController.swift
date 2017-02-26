//
//  HomeViewController.swift
//  DYTest
//
//  Created by 倪庆军 on 2017/2/26.
//  Copyright © 2017年 jun. All rights reserved.
//  首页

import UIKit

private let kTitleViewH : CGFloat = 40
class HomeViewController: UIViewController {

    // 懒加载titleView
    private lazy var pageTitleView : PageTitleView = {
       
        let frame = CGRect(x: 0, y:kStatueBarH + kNavigationBarH, width: kScreenW, height: kTitleViewH)
        let titles = ["推荐","游戏","娱乐","趣玩"]
        let titleView = PageTitleView(frame: frame, titles: titles)
        
        return titleView
    }()
    
    private lazy var pageContentView: PageContentView = { [weak self] in
        
        let viewH = kScreenH - kStatueBarH - kNavigationBarH - kTitleViewH
        let frame = CGRect(x: 0, y: kStatueBarH + kNavigationBarH + kTitleViewH, width: kScreenW, height: viewH)
        
        var childVC = [UIViewController]()
        for _ in 0..<4
        {
            let vc = UIViewController()
            vc.view.backgroundColor = UIColor(r: CGFloat(arc4random_uniform(255)), g: CGFloat(arc4random_uniform(255)), b: CGFloat(arc4random_uniform(255)))
            
            childVC.append(vc)
            
        }
        let contentView = PageContentView(frame: frame, childVC: childVC, parentVC: self!)
        return contentView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // 不要系统自动调整scrollView的内边距
        automaticallyAdjustsScrollViewInsets = false
        
        // 设置UI
        setupUI()
        // 增加titleView
        view.addSubview(pageTitleView)
        // 增加 contentView
        view.addSubview(pageContentView)
        
        
    }
    

}
private extension HomeViewController {
    
    func setupUI() {
        // 设置导航栏按钮
        setNavigatinBar()
        
        
    }
    
    // MARK: -设置导航栏按钮
    func setNavigatinBar() {
        // 设置左边logo
        let logoItem = UIBarButtonItem(normalImgName: "logo")
        navigationItem.leftBarButtonItem = logoItem
        
        // 设置右边三个按钮
        let size = CGSize(width: 40, height: 40)
        let historyItem = UIBarButtonItem(normalImgName: "image_my_history", highImgName: "Image_my_history_click", size: size)
        let searchItem = UIBarButtonItem(normalImgName: "btn_search", highImgName: "btn_search_clicked", size: size)
        let qrcodeItem = UIBarButtonItem(normalImgName: "Image_scan", highImgName: "Image_scan_click", size: size)
        navigationItem.rightBarButtonItems = [historyItem,searchItem,qrcodeItem]
        

    }
}
