//
//  AppContextExtensions.swift
//  FakeWeChat
//
//  Created by huangluyang on 15/12/31.
//  Copyright © 2015年 huangluyang. All rights reserved.
//

import Foundation
import YYKit

extension CGSize {
    static func size(type: AppContext.IconSizeType) -> CGSize {
        switch type {
        case .Smallest:
            return CGSizeMake(13, 13)
        case .Small:
            return CGSizeMake(17.5, 17.5)
        case .Middle:
            return CGSizeMake(22, 22)       // navigation
        case .Big:
            return CGSizeMake(25, 25)       // tab
        case .Biggest:
            return CGSizeMake(60, 60)
        }
    }
}

extension CGFloat {
    static func fontSize(type: AppContext.IconSizeType) -> CGFloat {
        switch type {
        case .Smallest:
            return CGFloat(12)
        case .Small:
            return CGFloat(14)
        case .Middle:
            return CGFloat(14)
        case .Big:
            return CGFloat(17)
        case .Biggest:
            return CGFloat(30)
        }
    }
    
    func radius(style: AppContext.IconStyle) -> CGFloat {
        switch style {
        case .Round:
            return CGFloatPixelRound(self * 0.5)
        case .RoundCorner:
            return CGFloat(3)
        default:
            return CGFloat(0)
        }
    }
}

extension String {
    func cacheKey(type: AppContext.IconSizeType, customSuffix: String = "") -> String {
        switch type {
        case .Smallest:
            return "\(self)_smallest_\(customSuffix)"
        case .Small:
            return "\(self)_small_\(customSuffix)"
        case .Middle:
            return "\(self)_middle_\(customSuffix)"
        case .Big:
            return "\(self)_big_\(customSuffix)"
        case .Biggest:
            return "\(self)_biggest_\(customSuffix)"
        }
    }
}

extension UIImage {
    func backgrounded(color: UIColor, style: AppContext.IconStyle = .Round) -> UIImage {
        
        UIGraphicsBeginImageContextWithOptions(self.size, false, self.scale)
        let context = UIGraphicsGetCurrentContext()
        let rect = CGRectMake(0, 0, self.size.width, self.size.height)
        CGContextScaleCTM(context, 1, -1)
        CGContextTranslateCTM(context, 0, -rect.size.height)
        
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: .AllCorners, cornerRadii: CGSizeMake(self.size.width.radius(style), self.size.height.radius(style)))
        path.closePath()
        color.setFill()
        path.fill()
        CGContextDrawImage(context, rect, self.CGImage)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image
    }
    
    func squared(color: UIColor = UIColor.clearColor(), style: AppContext.IconStyle = .Square) -> UIImage {
        let dimension = max(self.size.width, self.size.height)
        let size = CGSizeMake(dimension, dimension)
        UIGraphicsBeginImageContextWithOptions(size, false, self.scale)
        let context = UIGraphicsGetCurrentContext()
        let rect = CGRectMake(0, 0, dimension, dimension)
        let drawRect = CGRectMake(CGFloatPixelRound((self.size.width - dimension) * 0.5), CGFloatPixelRound((self.size.height - dimension) * 0.5), self.size.width, self.size.height)
        CGContextScaleCTM(context, 1, -1)
        CGContextTranslateCTM(context, 0, -rect.size.height)
        
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: .AllCorners, cornerRadii: CGSizeMake(self.size.width.radius(style), self.size.height.radius(style)))
        path.closePath()
        color.setFill()
        path.fill()
        CGContextDrawImage(context, drawRect, self.CGImage)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image
    }
}
