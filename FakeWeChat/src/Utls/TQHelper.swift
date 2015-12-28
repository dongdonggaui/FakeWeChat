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

extension UIApplication {
    public static func tq_windowWidth() -> CGFloat {
        let appDelegate = UIApplication.sharedApplication().delegate
        if appDelegate == nil {
            return 0
        }
        let window = appDelegate!.window
        if window == nil {
            return 0
        }
        return window!!.frame.width
    }
}

extension UIImage {
    public static func tq_imageFromString(string: String, backgroundColor: UIColor, attributes: [String : AnyObject], size: CGSize) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, true, UIScreen.mainScreen().scale)
        let context = UIGraphicsGetCurrentContext()
        CGContextSetFillColorWithColor(context, backgroundColor.CGColor)
        CGContextFillRect(context, CGRectMake(0, 0, size.width, size.height))
        let ocString = string as NSString
        let stringSize = ocString.sizeWithAttributes(attributes)
        ocString.drawInRect(CGRectMake((size.width - stringSize.width) * 0.5, (size.height - stringSize.height) * 0.5, stringSize.width, stringSize.height), withAttributes: attributes)
        let image: UIImage? = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
}
