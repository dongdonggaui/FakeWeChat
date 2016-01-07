//
//  TimelineViewController.swift
//  FakeWeChat
//
//  Created by huangluyang on 15/12/30.
//  Copyright © 2015年 huangluyang. All rights reserved.
//

import UIKit

class TimelineViewController: UIViewController {
    
    // MARK: - Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        
        title = NSLocalizedString("朋友圈", comment: "Timeline")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Properties
    @IBOutlet weak var tableView: UITableView!

}
