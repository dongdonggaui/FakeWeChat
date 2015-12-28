//
//  MultiSelectTableViewCell.swift
//  FakeWeChat
//
//  Created by huangluyang on 15/12/26.
//  Copyright © 2015年 huangluyang. All rights reserved.
//

import UIKit
import SnapKit
import Chameleon

enum MultiSelectTableViewState {
    case Normal
    case Selectable
}

private let SelectImageInVisibleLeading = CGFloat(-36)
private let SelectImageVisibleLeading = CGFloat(0)

class MultiSelectTableViewCell: UITableViewCell {

    // MARK: - Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.multiSelectTableViewCellInit()
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.multiSelectTableViewCellInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.multiSelectTableViewCellInit()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        if !shouldMultiSelect() {
            return
        }
        selectImageView.image = selected ? selectedIcon : normalIcon
    }
    
    override func setEditing(editing: Bool, animated: Bool) {
        if !self.shouldMultiSelect() {
            return
        }
        let constant = editing ? SelectImageVisibleLeading : SelectImageInVisibleLeading
        updateContentStackLeadingConstraint(constant, animated: animated)
        
        contentStackView.userInteractionEnabled = !editing
    }
    
    // MARK: - Property
    private let contentStackView = UIStackView()
    private let selectImageView = UIImageView()
    private let containerView = UIView()
    private var contentStackLeadingConstraint: Constraint?
    private let normalIcon = UIImage(color: FlatSand(), size: CGSizeMake(20, 20)).imageByRoundCornerRadius(10)
    private let selectedIcon = UIImage(color: FlatGreenDark(), size: CGSizeMake(20, 20)).imageByRoundCornerRadius(10)
    
    // MARK: - Public
    func multiSelectContentView() -> UIView {
        fatalError("multiSelectContentView should be implement")
    }
    
    func shouldMultiSelect() -> Bool {
        fatalError("shouldMultiSelect should be implement")
    }
    
    // MARK: - Private
    private func multiSelectTableViewCellInit() {
        contentStackView.axis = .Horizontal
        contentStackView.alignment = .Center
        contentStackView.distribution = .Fill
        contentStackView.spacing = 8
        contentStackView.layoutMargins = UIEdgeInsetsMake(0, 8, 0, 0);
        contentStackView.layoutMarginsRelativeArrangement = true
        contentStackView.addArrangedSubview(selectImageView)
        contentStackView.addArrangedSubview(containerView)
        
        selectImageView.snp_makeConstraints { (make) -> Void in
            make.size.equalTo(CGSizeMake(20, 20))
        }
        containerView.snp_makeConstraints { (make) -> Void in
            make.top.bottom.equalTo(contentStackView)
        }
        
        let multiSelectContentView = self.multiSelectContentView()
        containerView.addSubview(multiSelectContentView)
        multiSelectContentView.snp_makeConstraints { (make) -> Void in
            make.edges.equalTo(containerView).inset(UIEdgeInsetsMake(5, 10, 5, 10))
        }
        
        self.contentView.addSubview(contentStackView)
        contentStackView.snp_makeConstraints { (make) -> Void in
            self.contentStackLeadingConstraint = make.leading.equalTo(self.contentView).offset(CGFloat(SelectImageInVisibleLeading)).constraint
            make.top.trailing.bottom.equalTo(self.contentView)
        }
        
        self.selectionStyle = .None
    }
    
    private func updateContentStackLeadingConstraint(constant: CGFloat, animated: Bool) {
        self.contentStackLeadingConstraint!.updateOffset(constant)
        UIView.animateWithDuration(animated ? 0.25 : 0) { () -> Void in
            self.layoutIfNeeded()
        }
    }

}
