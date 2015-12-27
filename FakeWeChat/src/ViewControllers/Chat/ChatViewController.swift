//
//  ChatViewController.swift
//  FakeWeChat
//
//  Created by huangluyang on 15/12/26.
//  Copyright © 2015年 huangluyang. All rights reserved.
//

import UIKit
import SnapKit

class ChatViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, MessageNodeViewDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.registerClass(TextMessageTableViewCell.self, forCellReuseIdentifier: "cell")
        self.tableView.estimatedRowHeight = 60.0
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Property
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Table View
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as UITableViewCell
        self.configureCell(cell, atIndexPath: indexPath)
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func configureCell(cell: UITableViewCell, atIndexPath indexPath: NSIndexPath) {
        let textMessageCell = cell as! TextMessageTableViewCell
        let dice: UInt32 = 100
        let randomNum = Int(arc4random_uniform(dice)) + 1
        textMessageCell.textMessageNodeView.textMessage = "message --> \(randomNum)"
    }
    
    // MARK: - MessageViewDelegate
    func messageViewDidTappedAvatar(messageNodeView: MessageNodeView) {
        print("tapped")
    }
    
    // MARK: - Event Response
    @IBAction func selectTapped(sender: UIBarButtonItem) {
        self.tableView.setEditing(!self.tableView.editing, animated: true)
    }

}
