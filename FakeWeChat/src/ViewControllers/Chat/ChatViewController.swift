//
//  ChatViewController.swift
//  FakeWeChat
//
//  Created by huangluyang on 15/12/26.
//  Copyright © 2015年 huangluyang. All rights reserved.
//

import UIKit
import SnapKit

class ChatViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(messageListView)
        messageListView.snp_makeConstraints { (make) -> Void in
            make.edges.equalTo(view)
        }
        messageListView.tableView.separatorStyle = .None
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Private Properties
    private let messageListView =  MessageListView()
    
    // MARK: - Event Response
    @IBAction func selectTapped(sender: UIBarButtonItem) {
        messageListView.tableView.setEditing(!messageListView.tableView.editing, animated: true)
    }

}
