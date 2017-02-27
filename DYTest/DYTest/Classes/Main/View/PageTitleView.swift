//
//  PageTitleView.swift
//  DYTest
//
//  Created by 倪庆军 on 2017/2/26.
//  Copyright © 2017年 jun. All rights reserved.
//

import UIKit
// 定义常量
private let kNormalColor : (CGFloat,CGFloat,CGFloat) = (85 ,85 ,85)
private let kSelectedColor : (CGFloat,CGFloat,CGFloat) = (255,128,0)
private let kScrollLineH : CGFloat = 2

// 代理
protocol PageTitleViewDelegate : class {

    func pageTitleView(titleView: PageTitleView, selectedIndex index: Int)
}

class PageTitleView: UIView {

    weak var delegate : PageTitleViewDelegate?
    
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
    
    private lazy var titleLabels = [UILabel]()
    
    private var titles : [String]
    // 当前的label的下标
    private var currentIndex : Int = 0
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
        scrollView.frame = bounds
        
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
            label.textColor = UIColor(r: kNormalColor.0, g: kNormalColor.1, b: kNormalColor.2)
            label.textAlignment = .center
            // 设置frame
            let labelX : CGFloat = CGFloat(index) * labelW
            label.frame = CGRect(x: labelX, y: 0, width: labelW, height: labelH)
            // 添加到scrollView
            scrollView.addSubview(label)
            
            titleLabels.append(label)
            
            // 添加监听事件
            label.isUserInteractionEnabled = true
            let tap  = UITapGestureRecognizer(target: self, action: #selector(titleLabelClick(tap:)))
            label.addGestureRecognizer(tap)
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
        firstLabel.textColor = UIColor(r: kSelectedColor.0, g: kSelectedColor.1, b: kSelectedColor.2)
        
        scrollView.addSubview(scrollLine)
        scrollLine.frame = CGRect(x: firstLabel.frame.origin.x, y: frame.height - kScrollLineH, width: firstLabel.frame.width, height: kScrollLineH)
    }
    
    // 事件监听最好加上 @objc
    @objc func titleLabelClick(tap: UITapGestureRecognizer) {
        // 获取当前label的下标值
        guard let currentLabel = tap.view as? UILabel else { return }
        
        // 获取之前的label
        let oldLabel = titleLabels[currentIndex]
        
        // 切换文字颜色
        currentLabel.textColor = UIColor.orange
        oldLabel.textColor = UIColor.darkGray
        
        // 保存当前label的下标
        currentIndex = currentLabel.tag
        
        // 滚动条位置
        let scrollLineX = CGFloat(currentIndex) * scrollLine.frame.width
        UIView.animate(withDuration: 0.15, animations: {
            self.scrollLine.frame.origin.x = scrollLineX
        })
        // 通知代理
        delegate?.pageTitleView(titleView: self, selectedIndex: currentIndex)
    }
 
    // MARK: -暴露方法
    func setTitleWithProgress(progress: CGFloat,sourceIndex: Int,targetIndex: Int) {
        let sourceLabel = titleLabels[sourceIndex]
        let targetLabel = titleLabels[targetIndex]
        
        // 处理滑块
        let moveTotalX = targetLabel.frame.origin.x - sourceLabel.frame.origin.x
        let moveX = moveTotalX * progress
        scrollLine.frame.origin.x = sourceLabel.frame.origin.x + moveX
        
        // 颜色变化
        let colorDetal = (kSelectedColor.0 - kNormalColor.0,kSelectedColor.1 - kNormalColor.1,kSelectedColor.2 - kNormalColor.2)
        
        sourceLabel.textColor = UIColor(r: kSelectedColor.0 - colorDetal.0 * progress, g: kSelectedColor.1 - colorDetal.1 * progress, b: kSelectedColor.2 - colorDetal.2 * progress)
        
        targetLabel.textColor = UIColor(r: kNormalColor.0 + colorDetal.0 * progress, g: kNormalColor.1 + colorDetal.1 * progress, b: kNormalColor.2 + colorDetal.2 * progress)

        // 记录最新的index
        currentIndex = targetIndex
        
    }
}
