//
//  AppContext.swift
//  FakeWeChat
//
//  Created by huangluyang on 15/12/28.
//  Copyright © 2015年 huangluyang. All rights reserved.
//

import UIKit
import Chameleon
import Kingfisher

struct AppContextLocalImageCacheKey {
    static let RedirectIcon = "redirect"
    static let CollectIcon = "collect"
    static let DeleteIcon = "delelte"
    static let MoreIcon = "more"
}

class AppContext: NSObject {
    
    static let globalImageCache = KingfisherManager.sharedManager.cache
    static let textDrawAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor(), NSFontAttributeName: UIFont.boldSystemFontOfSize(17)]
    static let messageListViewFunctionToolbarIconSize = CGSizeMake(24, 24)
    
    static func redirectIcon() -> UIImage {
        return iconWithCacheKey(AppContextLocalImageCacheKey.RedirectIcon, title: "转")
    }
    
    static func collectIcon() -> UIImage {
        return iconWithCacheKey(AppContextLocalImageCacheKey.CollectIcon, title: "藏")
    }
    
    static func deleteIcon() -> UIImage {
        return iconWithCacheKey(AppContextLocalImageCacheKey.DeleteIcon, title: "删")
    }
    
    static func moreIcon() -> UIImage {
        return iconWithCacheKey(AppContextLocalImageCacheKey.MoreIcon, title: "···")
    }
    
    static func iconWithCacheKey(key: String, title: String) -> UIImage {
        var image = imageWithCacheKey(key)
        if image == nil {
            image = UIImage.tq_imageFromString(title, backgroundColor: FlatBlue(), attributes: textDrawAttributes, size: messageListViewFunctionToolbarIconSize) ?? UIImage(color: FlatBlue(), size: messageListViewFunctionToolbarIconSize)
        }
        return image!
    }
    
    static func imageWithCacheKey(key: String) -> UIImage? {
        let cachedResult = globalImageCache.isImageCachedForKey(key)
        var cachedImage: UIImage? = nil
        if let cacheType = cachedResult.cacheType {
            switch cacheType {
            case .Memory: cachedImage = globalImageCache.retrieveImageInMemoryCacheForKey(key)
            case .Disk: cachedImage = globalImageCache.retrieveImageInDiskCacheForKey(key)
            default: break
            }
        }
        return cachedImage
    }
}
