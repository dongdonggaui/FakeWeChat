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
    static let SearchTimelineIcon = "searchTimeline"
    static let SearchArticleIcon = "searchArticel"
    static let SearchCelebrityIcon = "searchCelebrity"
    
    static let RedirectIcon = "redirect"
    static let CollectIcon = "collect"
    static let DeleteIcon = "delelte"
    static let MoreIcon = "more"
}

class AppContext: NSObject {
    
    // MARK: - Global Resource
    static let globalImageCache = KingfisherManager.sharedManager.cache
    
    // MARK: - Search Resource
    static let globalSearchTextDrawAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor(), NSFontAttributeName: UIFont.boldSystemFontOfSize(30)]
    static let globalSearchIconSize = CGSizeMake(80, 80)
    static func globalSearchTimelineIcon() -> UIImage {
        return iconWithCacheKey(AppContextLocalImageCacheKey.SearchTimelineIcon, title: "圈", backgroundColor: FlatPink(), attributes: globalSearchTextDrawAttributes, size: globalSearchIconSize)
    }
    
    static func globalSearchArticleIcon() -> UIImage {
        return iconWithCacheKey(AppContextLocalImageCacheKey.SearchTimelineIcon, title: "文", backgroundColor: FlatMint(), attributes: globalSearchTextDrawAttributes, size: globalSearchIconSize)
    }
    
    static func globalSearchCelebrityIcon() -> UIImage {
        return iconWithCacheKey(AppContextLocalImageCacheKey.SearchTimelineIcon, title: "众", backgroundColor: FlatSand(), attributes: globalSearchTextDrawAttributes, size: globalSearchIconSize)
    }
    
    // MARK: - Message List Resource
    static let messageListViewTextDrawAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor(), NSFontAttributeName: UIFont.boldSystemFontOfSize(17)]
    static let messageListViewFunctionToolbarIconSize = CGSizeMake(24, 24)
    static func redirectIcon() -> UIImage {
        return iconWithCacheKey(AppContextLocalImageCacheKey.RedirectIcon, title: "转", backgroundColor: nil, attributes: nil, size: nil)
    }
    
    static func collectIcon() -> UIImage {
        return iconWithCacheKey(AppContextLocalImageCacheKey.CollectIcon, title: "藏", backgroundColor: nil, attributes: nil, size: nil)
    }
    
    static func deleteIcon() -> UIImage {
        return iconWithCacheKey(AppContextLocalImageCacheKey.DeleteIcon, title: "删", backgroundColor: nil, attributes: nil, size: nil)
    }
    
    static func moreIcon() -> UIImage {
        return iconWithCacheKey(AppContextLocalImageCacheKey.MoreIcon, title: "···", backgroundColor: nil, attributes: nil, size: nil)
    }
    
    // MARK: - Utilities
    static func iconWithCacheKey(key: String, title: String, backgroundColor: UIColor?, attributes: Dictionary<String, AnyObject>?, size: CGSize?) -> UIImage {
        var image = imageWithCacheKey(key)
        if image == nil {
            image = UIImage.tq_imageFromString(title, backgroundColor: backgroundColor ?? UIColor.clearColor(), attributes: attributes ?? messageListViewTextDrawAttributes, size: size ?? messageListViewFunctionToolbarIconSize) ?? UIImage(color: FlatBlue(), size: size ?? messageListViewFunctionToolbarIconSize)
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
