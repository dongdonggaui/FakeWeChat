//
//  MoreViewController.swift
//  FakeWeChat
//
//  Created by huangluyang on 15/12/30.
//  Copyright © 2015年 huangluyang. All rights reserved.
//

import UIKit

class MoreViewController: UIViewController {
    
    // MARK: - Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        
        title = NSLocalizedString("更多", comment: "More")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
