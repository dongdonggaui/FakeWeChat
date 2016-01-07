//
//  MoreViewController.swift
//  FakeWeChat
//
//  Created by huangluyang on 15/12/30.
//  Copyright © 2015年 huangluyang. All rights reserved.
//

import UIKit

class MoreViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    struct DataSource {
        var title: String
        var icon: UIImage?
        var detail: String?
        var iconPath: String?
        var badgeView: UIView?
        var height: CGFloat
    }
    
    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        
        title = NSLocalizedString("更多", comment: "More")
        tabBarItem.image = UIImage.fontAwesomeIconWithName(.Gear, textColor: UIColor.blackColor(), size: CGSizeMake(30, 30))
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataSource += [
            [DataSource(title: "刘德华", icon: nil, detail: "xx号：liudehua", iconPath: "http://image.baidu.com/search/down?tn=download&ipn=dwnl&word=download&ie=utf8&fr=result&url=http%3A%2F%2Fwww.cnwnews.com%2Fuploads%2Fallimg%2F080804%2F0824530.jpg", badgeView: nil, height: 80)]
        ]
        dataSource += [
            [DataSource(title: "相册", icon: AppContext.clearIcon(withTitle: "📷"), detail: nil, iconPath: nil, badgeView: nil, height: 44),
            DataSource(title: "收藏", icon: AppContext.clearIcon(withTitle: "💾"), detail: nil, iconPath: nil, badgeView: nil, height: 44),
            DataSource(title: "钱包", icon: AppContext.clearIcon(withTitle: "🏧"), detail: nil, iconPath: nil, badgeView: nil, height: 44)]
        ]
        dataSource += [
            [DataSource(title: "表情", icon: AppContext.clearIcon(withTitle: "😄"), detail: nil, iconPath: nil, badgeView: nil, height: 44)]
        ]
        dataSource += [
            [DataSource(title: "设置", icon: AppContext.clearIcon(withTitle: "设").backgrounded(UIColor.flatRedColor()), detail: nil, iconPath: nil, badgeView: nil, height: 44)]
        ]
        
        tableView.tableHeaderView = UIView(frame: CGRectMake(0, 0, 0, 15))
        tableView.registerNib(UINib(nibName: "SimpleSettingTableViewCellTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Properties
    lazy var dataSource: [[DataSource]] = []
    
    
    // MARK: - Table View
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return dataSource.count
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource[section].count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! SimpleSettingTableViewCellTableViewCell
        self.configureCell(cell, atIndexPath: indexPath)
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return dataSource[indexPath.section][indexPath.row].height
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    func configureCell(cell: SimpleSettingTableViewCellTableViewCell, atIndexPath indexPath: NSIndexPath) {
        
        let data = dataSource[indexPath.section][indexPath.row]
        if let imagePath = data.iconPath {
            cell.iconImageView.setImageWithURL(NSURL(string: imagePath), placeholder: AppContext.avatarPlaceholder())
            cell.iconHeightConstraint.constant = 60
        } else if let image = data.icon {
            cell.iconImageView.image = image
            cell.iconHeightConstraint.constant = 27
        }
        cell.titleLabel.text = data.title
        if let detail = data.detail {
            cell.subtitleLabel.text = detail
            cell.stackView.addArrangedSubview(cell.subtitleLabel)
            cell.subtitleLabel.hidden = false
        } else {
            cell.stackView.removeArrangedSubview(cell.subtitleLabel)
            cell.subtitleLabel.hidden = true
        }
    }

}
