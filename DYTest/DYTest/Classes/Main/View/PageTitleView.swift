//
//  PageTitleView.swift
//  DYTest
//
//  Created by 倪庆军 on 2017/2/26.
//  Copyright © 2017年 jun. All rights reserved.
//

import UIKit

private let kScrollLineH : CGFloat = 2

class PageTitleView: UIView {

    private lazy var scrollLine : UIView = {
       
        let scrollLine = UIView()
        scrollLine.backgroundColor = UIColor.orange
        return scrollLine
    }()
    
    private lazy var scrollView : UIScrollView = {
       let scrollView = UIScrollView()
        scrollView.bounces = false
        scrollView.scrollsToTop = false
        scrollView.showsHorizontalScrollIndicator = false
        return scrollView
        
    }()
    
    private lazy var titleLabels : [UILabel]
    
    private var titles : [String]
    
    // MARK: -自定义构造函数
    init(frame: CGRect,titles: [String]) {
        self.titles = titles
        
        super.init(frame: frame)
        
        // 设置UI
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: -设置UI
    private func setupUI() {
        // 添加scrollView
        addSubview(scrollView)
        
        // 添加title对应的label
        setupTitleLables()
        // 设置底线和滚动滑块
        setupBottomLineAndScrollLine()
    }
    private func setupTitleLables() {
        
        let labelW : CGFloat = frame.width / CGFloat(titles.count)
        let labelH : CGFloat = frame.height - kScrollLineH
        
        for (index, title) in titles.enumerated() {
            // 创建label
            let label = UILabel()
            // 设置label属性
            label.text = title
            label.tag = index
            label.font = UIFont.systemFont(ofSize: 16)
            label.textColor = UIColor.darkGray
            label.textAlignment = .center
            // 设置frame
            let labelX : CGFloat = CGFloat(index) * labelW
            label.frame = CGRect(x: labelX, y: 0, width: labelW, height: labelH)
            // 添加到scrollView
            scrollView.addSubview(label)
            
            titleLabels.append(label)
        }
    }
    private func setupBottomLineAndScrollLine() {
        let bottomLine = UIView()
        bottomLine.backgroundColor = UIColor.lightGray
        let bottomLineH : CGFloat = 0.5
        bottomLine.frame = CGRect(x: 0, y: frame.height - bottomLineH, width: frame.width, height: bottomLineH)
        addSubview(bottomLine)
        
        // 获取第一个label的宽度
        guard let  firstLabel  = titleLabels.first else { return }
        firstLabel.textColor = UIColor.orange
        
        scrollView.addSubview(scrollLine)
        scrollLine.frame = CGRect(x: firstLabel.frame.origin.x, y: frame.height - kScrollLineH, width: firstLabel.frame.width, height: kScrollLineH)
    }
}
