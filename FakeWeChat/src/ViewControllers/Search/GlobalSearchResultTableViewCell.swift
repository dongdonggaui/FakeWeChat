//
//  GlobalSearchResultTableViewCell.swift
//  FakeWeChat
//
//  Created by huangluyang on 16/1/6.
//  Copyright © 2016年 huangluyang. All rights reserved.
//

import UIKit

class GlobalSearchResultTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        
        _globalSearchResultTableViewCellInit()
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        _globalSearchResultTableViewCellInit()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // MARK: - Properties
    lazy var resultView: GlobalSearchResultView = GlobalSearchResultView()
    
    // MARK: - Private Methods
    func _globalSearchResultTableViewCellInit() {
        selectionStyle = .None
        contentView.backgroundColor = UIColor.clearColor()
        backgroundColor = UIColor.clearColor()
        contentView.addSubview(resultView)
        resultView.backgroundColor = UIColor.whiteColor()
        resultView.snp_makeConstraints { (make) -> Void in
            make.leading.trailing.top.equalTo(contentView)
            make.bottom.equalTo(contentView).offset(-6)
        }
    }

}
