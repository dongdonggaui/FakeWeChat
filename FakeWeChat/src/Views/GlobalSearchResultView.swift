//
//  GlobalSearchResultView.swift
//  FakeWeChat
//
//  Created by huangluyang on 16/1/6.
//  Copyright © 2016年 huangluyang. All rights reserved.
//

import UIKit

class GlobalSearchResultView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        titleLabel.text = "联系人"
        footerButton.setTitle("查看更多联系人", forState: .Normal)
        stackView.axis = .Vertical
        addSubview(stackView)
        stackView.snp_makeConstraints { (make) -> Void in
            make.edges.equalTo(self)
        }
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(GlobalSearchResultContactView())
        stackView.addArrangedSubview(GlobalSearchResultContactView())
        stackView.addArrangedSubview(GlobalSearchResultContactView())
        stackView.addArrangedSubview(footerButton)
        
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        self.init(frame: CGRectZero)
    }

    // MARK: - Properties
    lazy var stackView = UIStackView()
//    lazy var titleView = UIView()
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFontOfSize(12)
        label.textColor = UIColor.lightGrayColor()
        return label
    }()
//    lazy var footerView = UIView()
    lazy var footerButton = UIButton(type: .Custom)

}

class GlobalSearchResultItemView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        topLine.backgroundColor = UIColor.lightGrayColor()
        addSubview(topLine)
        topLine.snp_makeConstraints { (make) -> Void in
            make.height.equalTo(0.5)
            make.top.trailing.equalTo(self)
            make.leading.equalTo(self).offset(20)
        }
    }

    required convenience init?(coder aDecoder: NSCoder) {
        self.init(frame: CGRectZero)
    }
    
    lazy var topLine = UIView()
}

class GlobalSearchResultContactView: GlobalSearchResultItemView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(simpleView)
        simpleView.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(topLine.snp_bottom)
            make.leading.trailing.bottom.equalTo(self)
        }
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        self.init(frame: CGRectZero)
    }
    
    override func intrinsicContentSize() -> CGSize {
        let size = simpleView.systemLayoutSizeFittingSize(UILayoutFittingCompressedSize)
        return CGSizeMake(size.width, size.height + 0.5)
    }
    
    lazy var simpleView = SimpleCellView()
}
