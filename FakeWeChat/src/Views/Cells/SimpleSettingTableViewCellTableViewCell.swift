//
//  SimpleSettingTableViewCellTableViewCell.swift
//  FakeWeChat
//
//  Created by huangluyang on 16/1/7.
//  Copyright © 2016年 huangluyang. All rights reserved.
//

import UIKit

class SimpleSettingTableViewCellTableViewCell: UITableViewCell {
    
    // MARK: - Outlets
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var extensionView: UIView!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var iconHeightConstraint: NSLayoutConstraint!

    // MARK: - Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        
        extensionView.hidden = true
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        stackView.removeArrangedSubview(subtitleLabel)
    }
    
}
