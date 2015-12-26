//
//  MultiSelectTableViewCell.swift
//  FakeWeChat
//
//  Created by huangluyang on 15/12/26.
//  Copyright © 2015年 huangluyang. All rights reserved.
//

import UIKit
import SnapKit

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

        // Configure the view for the selected state
    }
    
    override func setEditing(editing: Bool, animated: Bool) {        
        let constant = editing ? SelectImageVisibleLeading : SelectImageInVisibleLeading
        self.updateContentStackLeadingConstraint(constant, animated: animated)
    }
    
    // MARK: - Property
    let contentStackView = UIStackView()
    let selectImageView = UIImageView()
    let containerView = UIView()
    var contentStackLeadingConstraint: Constraint?
    
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
        contentStackView.addArrangedSubview(selectImageView)
        contentStackView.addArrangedSubview(containerView)
        
        selectImageView.snp_makeConstraints { (make) -> Void in
            make.size.equalTo(CGSizeMake(20, 20))
            make.leading.equalTo(8)
        }
        containerView.snp_makeConstraints { (make) -> Void in
            make.top.bottom.equalTo(contentStackView)
        }
        
        let multiSelectContentView = self.multiSelectContentView()
        containerView.addSubview(multiSelectContentView)
        multiSelectContentView.snp_makeConstraints { (make) -> Void in
            make.edges.equalTo(containerView).inset(UIEdgeInsetsMake(0, 10, 5, 10))
        }
        
        self.contentView.addSubview(contentStackView)
        contentStackView.snp_makeConstraints { (make) -> Void in
            self.contentStackLeadingConstraint = make.leading.equalTo(self.contentView).offset(CGFloat(SelectImageInVisibleLeading)).constraint
            make.top.trailing.bottom.equalTo(self.contentView)
        }
        
        // for test
        selectImageView.backgroundColor = UIColor.yellowColor()
        containerView.backgroundColor = UIColor.cyanColor()
    }
    
    private func updateContentStackLeadingConstraint(constant: CGFloat, animated: Bool) {
        self.contentStackLeadingConstraint!.updateOffset(constant)
        UIView.animateWithDuration(animated ? 0.25 : 0) { () -> Void in
            self.layoutIfNeeded()
        }
    }

}
