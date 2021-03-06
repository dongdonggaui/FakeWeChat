//
//  GlobalSearchResultViewController.swift
//  FakeWeChat
//
//  Created by huangluyang on 15/12/29.
//  Copyright © 2015年 huangluyang. All rights reserved.
//

import UIKit

class GlobalSearchResultViewController: UIViewController, UISearchResultsUpdating, UITableViewDataSource, UITableViewDelegate {
    
    // MARK: - Life Cycle
    convenience init() {
        self.init(nibName: nil, bundle: nil)
    }

    required convenience init?(coder aDecoder: NSCoder) {
        self.init()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(_tableView)
        _tableView.backgroundColor = UIColor.clearColor()
        _tableView.snp_makeConstraints { (make) -> Void in
            make.edges.equalTo(view)
        }
        _tableView.dataSource = self
        _tableView.delegate = self
        _tableView.estimatedRowHeight = 80
        _tableView.registerClass(GlobalSearchResultTableViewCell.self, forCellReuseIdentifier: "cell")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Private Properties
    private lazy var _tableView = UITableView()
    
    // MARK: - Table View
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 5
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as UITableViewCell
        self.configureCell(cell, atIndexPath: indexPath)
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {

    }
    
    func configureCell(cell: UITableViewCell, atIndexPath indexPath: NSIndexPath) {
        
    }

    // MARK: - UISearchResultsUpdating
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        _tableView.reloadData()
    }

}
