//
//  ContactsViewController.swift
//  FakeWeChat
//
//  Created by huangluyang on 15/12/30.
//  Copyright © 2015年 huangluyang. All rights reserved.
//

import UIKit

class ContactsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    // MARK: - Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        
        title = NSLocalizedString("通讯录", comment: "Contacts")
        let rightButton = UIButton(type: .Custom)
        let addIcon = UIImage.fontAwesomeIconWithName(.UserPlus, textColor: UIColor.whiteColor(), size: CGSizeMake(30, 30))
        rightButton.setImage(addIcon, forState: .Normal)
        rightButton.sizeToFit()
        let rightItem = UIBarButtonItem(customView: rightButton)
        navigationItem.rightBarButtonItem = rightItem
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = 53
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Properties
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Table View
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 26
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! ContactTableViewCell
        self.configureCell(cell, atIndexPath: indexPath)
        return cell
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "\(Character(UnicodeScalar(65 + section)))"
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    
    func configureCell(cell: ContactTableViewCell, atIndexPath indexPath: NSIndexPath) {
        cell.nameLabel.text = "某某某"
        let avatar = UIImage.fontAwesomeIconWithName(.User, textColor: UIColor.whiteColor(), size: CGSizeMake(36, 36)).squared(UIColor.lightGrayColor(), style: .Square)
        cell.avatarImageView.image = avatar
    }
    
    func sectionIndexTitlesForTableView(tableView: UITableView) -> [String]? {
        var titles: [String] = []
        for section in 0..<26 {
            titles += ["\(Character(UnicodeScalar(65 + section)))"]
        }
        return titles
    }
    
    func tableView(tableView: UITableView, sectionForSectionIndexTitle title: String, atIndex index: Int) -> Int {
        let char = title.unicodeScalars.first as UnicodeScalar!
        let index = char.value - 65
        return Int(index)
    }

}

class ContactTableViewCell: UITableViewCell {
    
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
}
