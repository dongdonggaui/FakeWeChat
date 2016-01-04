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
    
    public static func window() -> UIWindow {
        return UIApplication.sharedApplication().delegate!.window!!
    }
}

extension UIView {
    public func tq_isMinimumWindowHeight() -> Bool {
        
        let isLandscape = UIApplication.sharedApplication().statusBarOrientation.isLandscape
        let isCompact = traitCollection.verticalSizeClass == .Compact
        return isLandscape && isCompact
    }
}

extension UIViewController {
    public func tq_isMinimumWindowHeight() -> Bool {
        
        let isLandscape = UIApplication.sharedApplication().statusBarOrientation.isLandscape
        let isCompact = traitCollection.verticalSizeClass == .Compact
        return isLandscape && isCompact
    }
}

extension UIImage {
    public static func tq_imageFromString(string: String, backgroundColor: UIColor, attributes: [String : AnyObject], size: CGSize) -> UIImage? {
        
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
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
