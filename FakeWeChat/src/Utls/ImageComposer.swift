//
//  ImageComposer.swift
//  ImageComposer
//
//  Created by huangluyang on 15/10/21.
//  Copyright © 2015年 Luyang Huang. All rights reserved.
//

import Foundation
import UIKit

private let instance = ImageComposer()
private let ImageComposerImageViewCount = "count"

public typealias ImageComposerLayoutInfoGenerateBlock = ((size: CGSize, imageCount: Int) -> [String]?)

public class ImageComposer: NSObject {
    
    lazy var canvasViews: Dictionary<String, UIView> = Dictionary()
    
    override init() {
        super.init()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "didReceiveMemoryWarningNotification", name: UIApplicationDidReceiveMemoryWarningNotification, object: nil)
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIApplicationDidReceiveMemoryWarningNotification, object: nil)
    }
    
    func composedImage(images: [UIImage], destinationSize size: CGSize, backgroundColor: UIColor, layoutGenerator: ImageComposerLayoutInfoGenerateBlock) -> UIImage? {
        if images.isEmpty {
            return nil
        }
        
        if CGSizeEqualToSize(size, CGSizeZero) {
            return UIImage()
        }
        
        let destinationSize = size
        
        if images.count == 1 {
            let image = images.last!
            UIGraphicsBeginImageContext(destinationSize)
            image.drawInRect(CGRectMake(0, 0, destinationSize.width, destinationSize.height))
            let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            return resizedImage
        }
        
        let tobeComposeCount = images.count <= 9 ? images.count : 9
        let countKey = "\(ImageComposerImageViewCount)-\(tobeComposeCount)"
        var snapView: UIView? = nil
        
        // 有缓存则直接复用
        if let canvasView = self.canvasViews[countKey] {
            for i in 0..<tobeComposeCount {
                let image = images[i]
                let imageView = canvasView.viewWithTag(100 + i)! as! UIImageView
                imageView.image = image
            }
            snapView = canvasView
        }
        else {
            snapView = UIView(frame: CGRectMake(0, 0, destinationSize.width, destinationSize.height))
            snapView!.backgroundColor = backgroundColor
            let layoutInfos = layoutGenerator(size: destinationSize, imageCount: tobeComposeCount)!
            for i in 0..<tobeComposeCount {
                let image = images[i]
                let frame = CGRectFromString(layoutInfos[i])
                let imageView = UIImageView(frame: frame)
                imageView.tag = 100 + i
                imageView.image = image
                snapView!.addSubview(imageView)
            }
        }
        
        UIGraphicsBeginImageContextWithOptions(destinationSize, true, 0)
        
        let context = UIGraphicsGetCurrentContext()!
        snapView!.layer.renderInContext(context)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        return image
    }
}

// MARK: - Class Methods
extension ImageComposer {
    
    public class var sharedInstance: ImageComposer {
        return instance;
    }
    
    public class func composedImage(images: [UIImage], destinationSize size: CGSize) -> UIImage? {
        
        return self.composedImage(images, destinationSize: size, backgroundColor: UIColor.whiteColor())
    }
    
    public class func composedImage(images: [UIImage], destinationSize size: CGSize, backgroundColor color: UIColor) -> UIImage? {
        
        return self.sharedInstance.composedImage(images, destinationSize: size, backgroundColor: color, layoutGenerator: { (size, imageCount) -> [String]? in
            
            let count = imageCount <= 9 ? imageCount : 9
            
            if count == 0 {
                return nil
            }
            
            if count == 1 {
                return [NSStringFromCGRect(CGRectMake(0, 0, size.width, size.height))]
            }
            
            var layoutInfos = [String]()
            var originPoint = CGPointZero
            let column = count > 4 ? 3 : 2
            let width = size.width / CGFloat(column)
            let padding: CGFloat = 0.5
            
            if count == 2 || count == 6 {
                originPoint.y = width * 0.5
            }
            else if count == 3 || count == 8 {
                originPoint.x = width * 0.5
            }
            else if count == 5 {
                originPoint.x = width * 0.5
                originPoint.y = width * 0.5
            }
            else if count == 7 {
                originPoint.x = width
            }
            
            for i in 0..<count {
                if originPoint.x + width > size.width {
                    originPoint.x = 0
                    originPoint.y += width
                }
                // 7张图片第二张需特殊处理
                if i == 1 && count == 7 {
                    originPoint.x = 0
                    originPoint.y += width
                }
                let frameString = NSStringFromCGRect(CGRectInset(CGRectMake(originPoint.x, originPoint.y, width, width), padding, padding))
                layoutInfos += [frameString]
                
                originPoint.x += width
            }
            
            return layoutInfos
        })
    }
    
    public class func composedImage(images: [UIImage], destinationSize size: CGSize, backgroundColor color: UIColor, layouInfoGenerator: ImageComposerLayoutInfoGenerateBlock) -> UIImage? {
        
        return self.sharedInstance.composedImage(images, destinationSize: size, backgroundColor: color, layoutGenerator: layouInfoGenerator)
    }
}

// MARK: - Notification
extension ImageComposer {
    func didReceiveMemoryWarningNotification() {

        self.canvasViews.removeAll()
    }
}
