//
//  HomeViewController.swift
//  DYTest
//
//  Created by 倪庆军 on 2017/2/26.
//  Copyright © 2017年 jun. All rights reserved.
//  首页

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // 设置左边logo
        let logoItem = UIBarButtonItem(normalImgName: "logo")
        self.navigationItem.leftBarButtonItem = logoItem
        
        // 设置右边三个按钮
        let size = CGSize(width: 40, height: 40)
        let historyItem = UIBarButtonItem(normalImgName: "image_my_history", highImgName: "Image_my_history_click", size: size)
        let searchItem = UIBarButtonItem(normalImgName: "btn_search", highImgName: "btn_search_clicked", size: size)
        let qrcodeItem = UIBarButtonItem(normalImgName: "Image_scan", highImgName: "Image_scan_click", size: size)
        self.navigationItem.rightBarButtonItems = [historyItem,searchItem,qrcodeItem]
        
        
    }
    

}
