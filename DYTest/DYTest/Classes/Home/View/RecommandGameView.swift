//
//  RecommandGameView.swift
//  DYTest
//
//  Created by 倪庆军 on 2017/3/6.
//  Copyright © 2017年 jun. All rights reserved.
//

import UIKit

class RecommandGameView: UIView {

    override func awakeFromNib() {
        super.awakeFromNib()
        // 设置不随父控件拉伸
        autoresizingMask = .init(rawValue: 0)
    }

}


// MARK: - 返回RecommandGameView
extension RecommandGameView{
    class func recommanGameView() -> RecommandGameView {
        return Bundle.main.loadNibNamed("RecommandGameView", owner: nil, options: nil)?.first as! RecommandGameView
    }
}
