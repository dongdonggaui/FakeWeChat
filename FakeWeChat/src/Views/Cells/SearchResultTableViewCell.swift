//
//  SearchResultTableViewCell.swift
//  FakeWeChat
//
//  Created by huangluyang on 15/12/29.
//  Copyright © 2015年 huangluyang. All rights reserved.
//

import UIKit

class SearchResultTableViewCell: UITableViewCell {

    // MARK: - Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        
        _searchResultTableViewCellInit()
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        _searchResultTableViewCellInit()
    }

    required convenience init?(coder aDecoder: NSCoder) {
        self.init()
    }
    
    override func intrinsicContentSize() -> CGSize {
        let size = simpleView.systemLayoutSizeFittingSize(UILayoutFittingCompressedSize)
        return CGSizeMake(size.width, size.height + 1)
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // MARK: - Properties
    lazy var simpleView = SimpleCellView()
    
    // MARK: - Private Methods
    private func _searchResultTableViewCellInit() {
        contentView.addSubview(simpleView)
        simpleView.snp_makeConstraints { (make) -> Void in
            make.edges.equalTo(contentView)
        }
    }

}
