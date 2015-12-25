//
//  TQHelper.swift
//  FakeWeChat
//
//  Created by huangluyang on 15/12/25.
//  Copyright © 2015年 huangluyang. All rights reserved.
//

import Foundation

extension String {
    public func tq_md5() -> String! {
        let oc = NSString(string: self)
        return oc.md5String()
    }
}
