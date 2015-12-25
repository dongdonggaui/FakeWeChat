//
//  ConversationViewController.swift
//  FakeWeChat
//
//  Created by huangluyang on 15/12/25.
//  Copyright © 2015年 huangluyang. All rights reserved.
//

import UIKit

class ConversationViewController: BaseViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "聊天";
        self.tableView.rowHeight = 60.0
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table View
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as UITableViewCell
        self.configureCell(cell, atIndexPath: indexPath)
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 60.0
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.performSegueWithIdentifier("showChat", sender: nil)
    }
    
    func configureCell(cell: UITableViewCell, atIndexPath indexPath: NSIndexPath) {
        if let avatarView = cell.viewWithTag(1) as? AvatarBadgeView {
            avatarView.setImagePaths(["http://imgsrc.baidu.com/baike/pic/item/734f12f389d6b5860a46e0cf.jpg", "http://img.315che.com/s/C201/109S/50r4/qths/oLU3/53U2/15.gif"], completion: nil)
        }
    }
}
