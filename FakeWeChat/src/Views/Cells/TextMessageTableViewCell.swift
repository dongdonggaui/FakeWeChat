//
//  TextMessageTableViewCell.swift
//  FakeWeChat
//
//  Created by huangluyang on 15/12/26.
//  Copyright © 2015年 huangluyang. All rights reserved.
//

import UIKit

class TextMessageTableViewCell: MultiSelectTableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func multiSelectContentView() -> UIView {
        return textMessageNodeView
    }
    
    override func shouldMultiSelect() -> Bool {
        return true
    }
    
    // MARK: - Property
    let textMessageNodeView = TextMessageNodeView()

}
