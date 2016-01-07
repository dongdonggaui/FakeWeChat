//
//  SimpleCellView.swift
//  FakeWeChat
//
//  Created by huangluyang on 15/12/29.
//  Copyright © 2015年 huangluyang. All rights reserved.
//

import UIKit
import YYKit

struct SCVLayoutInfo {
    static let AvatarWidth = CGFloatPixelRound(CGFloat(50.0 * UIApplication.tq_windowWidth() / 320.0))
    static let AvatarHeight = CGFloatPixelRound(CGFloat(50.0 * UIApplication.tq_windowWidth() / 320.0))
    static let AvatarTopMargin = CGFloat(8)
    static let AvatarLeadingMargin = CGFloat(8)
    
    static let HPadding = CGFloat(5)
    static let VPadding = CGFloat(5)
    static let BottomMargin = CGFloat(8)
}

class SimpleCellView: UIView {
    
    // MARK: - Life Cycle
    override init(frame: CGRect) {
        super.init(frame: CGRectMake(0, 0, 320, 100))
        
        addSubview(avatarView)
        addSubview(titleLabel)
        addSubview(detailLabel)
        addSubview(timeLabel)
        
        avatarView.snp_makeConstraints { (make) -> Void in
            make.width.equalTo(SCVLayoutInfo.AvatarWidth)
            make.height.equalTo(SCVLayoutInfo.AvatarHeight)
            make.top.equalTo(self).offset(SCVLayoutInfo.AvatarTopMargin)
            make.leading.equalTo(self).offset(SCVLayoutInfo.AvatarLeadingMargin)
            make.bottom.lessThanOrEqualTo(self).offset(-SCVLayoutInfo.BottomMargin)
        }
        titleLabel.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(avatarView).offset(SCVLayoutInfo.AvatarTopMargin)
            make.leading.equalTo(avatarView.snp_trailing).offset(SCVLayoutInfo.HPadding)
            make.trailing.lessThanOrEqualTo(timeLabel).offset(-SCVLayoutInfo.HPadding)
        }
        detailLabel.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(titleLabel.snp_bottom).offset(SCVLayoutInfo.VPadding)
            make.leading.equalTo(titleLabel)
            make.trailing.lessThanOrEqualTo(self).offset(-SCVLayoutInfo.AvatarLeadingMargin)
            make.bottom.lessThanOrEqualTo(self).offset(-SCVLayoutInfo.BottomMargin)
        }
        timeLabel.snp_makeConstraints { (make) -> Void in
            make.baseline.equalTo(titleLabel)
            make.trailing.equalTo(self).offset(-SCVLayoutInfo.AvatarLeadingMargin)
        }
    }
    
    convenience init() {
        self.init(frame: CGRectZero)
    }

    required convenience init?(coder aDecoder: NSCoder) {
        self.init(frame: CGRectZero)
    }
    
    // MARK: - Public Properties
    lazy var avatarView: AvatarBadgeView = {
        return AvatarBadgeView()
    }()
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFontOfSize(15)
        return label
    }()
    lazy var detailLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFontOfSize(14)
        label.textColor = UIColor.lightGrayColor()
        label.numberOfLines = 0
        return label
    }()
    lazy var timeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFontOfSize(12)
        label.textColor = UIColor.lightGrayColor()
        return label
    }()

}
