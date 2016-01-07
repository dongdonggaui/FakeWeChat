//
//  DiscoveryViewController.swift
//  FakeWeChat
//
//  Created by huangluyang on 16/1/6.
//  Copyright © 2016年 huangluyang. All rights reserved.
//

import UIKit

class DiscoveryViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    struct DataSource {
        var title: String
        var icon: UIImage
    }
    
    // MARK: - Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        title = NSLocalizedString("发现", comment: "Discovery Title")
        tabBarItem.image = UIImage.fontAwesomeIconWithName(.Safari, textColor: UIColor.flatBlueColor(), size: CGSizeMake(30, 30))
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        dataSource += [[DataSource(title: "朋友圈", icon: AppContext.clearIcon(withTitle: "圈").backgrounded(UIColor.flatRedColor()))]]
        dataSource += [[DataSource(title: "扫一扫", icon: AppContext.clearIcon(withTitle: "扫").backgrounded(UIColor.flatRedColor()))]]
        dataSource += [[DataSource(title: "购物", icon: AppContext.clearIcon(withTitle: "购").backgrounded(UIColor.flatRedColor())), DataSource(title: "游戏", icon: AppContext.clearIcon(withTitle: "游").backgrounded(UIColor.flatRedColor()))]]
        tableView.tableHeaderView = UIView(frame: CGRectMake(0, 0, 0, 15))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table View
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return dataSource.count
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let datas = dataSource[section]
        return datas.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as UITableViewCell
        self.configureCell(cell, atIndexPath: indexPath)
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    
    func configureCell(cell: UITableViewCell, atIndexPath indexPath: NSIndexPath) {
        let data = dataSource[indexPath.section][indexPath.row]
        cell.imageView?.image = data.icon
        cell.textLabel?.text = data.title
    }
    
    // MARK: - Properties
    @IBOutlet weak var tableView: UITableView!
    lazy var dataSource: [[DataSource]] = []

}
