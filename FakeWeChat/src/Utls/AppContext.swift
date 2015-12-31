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

class AppContext : NSObject {
    
    enum IconSizeType : Int {
        case Smallest
        case Small
        case Middle
        case Big
        case Biggest
    }
    
    enum IconStyle : Int {
        case Square
        case Round
        case RoundCorner
    }
    
    struct ImageCacheKey {
        static let SearchTimelineIcon = "searchTimeline"
        static let SearchArticleIcon = "searchArticel"
        static let SearchCelebrityIcon = "searchCelebrity"
        
        static let RedirectIcon = "redirect"
        static let CollectIcon = "collect"
        static let DeleteIcon = "delelte"
        static let MoreIcon = "more"
    }
    
    // MARK: - Global Resource
    static let globalImageCache = KingfisherManager.sharedManager.cache
    
    // MARK: - Conversation
    
    // MARK: - Search Resource
    static let globalSearchTintColor = FlatSkyBlueDark()
    static func globalSearchTimelineIcon(sizeType: IconSizeType = .Biggest) -> UIImage {
        return clearIcon(withTitle: "圈", sizeType: sizeType).backgrounded(FlatBlue())
    }
    
    static func globalSearchArticleIcon(sizeType: IconSizeType = .Biggest) -> UIImage {
        return clearIcon(withTitle: "文", sizeType: sizeType).backgrounded(FlatPink())
    }
    
    static func globalSearchCelebrityIcon(sizeType: IconSizeType = .Biggest) -> UIImage {
        return clearIcon(withTitle: "众", sizeType: sizeType).backgrounded(FlatSand())
    }
    
    // MARK: - Message List Resource
    static let messageListViewTextDrawAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor(), NSFontAttributeName: UIFont.boldSystemFontOfSize(17)]
    static let messageListViewFunctionToolbarIconSize = CGSizeMake(24, 24)
    static func redirectIcon() -> UIImage {
        return icon(withTitle: "转", sizeType: .Big, style: .RoundCorner)
    }
    
    static func collectIcon() -> UIImage {
        return icon(withTitle: "藏", sizeType: .Big, style: .RoundCorner)
    }
    
    static func deleteIcon() -> UIImage {
        return icon(withTitle: "删", sizeType: .Big, style: .RoundCorner)
    }
    
    static func moreIcon() -> UIImage {
        return icon(withTitle: "···", sizeType: .Big, style: .RoundCorner)
    }
    
    // MARK: - Utilities    
    static func clearIcon(withTitle title: String, sizeType: IconSizeType = .Middle) -> UIImage {
        
        return icon(withTitle: title, sizeType: sizeType, style: .Square, backgroundColor: UIColor.clearColor(), foregroundColor: UIColor.whiteColor())
    }
    
    static func icon(withTitle title: String, sizeType: IconSizeType = .Big, style: IconStyle = .Round, backgroundColor: UIColor = FlatBlue(), foregroundColor: UIColor = UIColor.whiteColor()) -> UIImage {
        
        let firstChar = title.substringToIndex(title.startIndex.advancedBy(1))
        let cacheKey = firstChar.cacheKey(sizeType)
        var image = imageWithCacheKey(cacheKey)
        if image == nil {
            let imageSize = CGSize.size(sizeType)
            let attributes = [NSForegroundColorAttributeName: foregroundColor, NSFontAttributeName: UIFont.boldSystemFontOfSize(CGFloat.fontSize(sizeType))]
            image = UIImage.tq_imageFromString(title, backgroundColor: backgroundColor, attributes: attributes, size: imageSize) ?? UIImage(color: foregroundColor, size: imageSize)
            globalImageCache.storeImage(image!, originalData: UIImagePNGRepresentation(image!), forKey: cacheKey)
        }
        return image!
    }
    
    static func imageWithCacheKey(key: String) -> UIImage? {
        let cachedResult = globalImageCache.isImageCachedForKey(key)
        var cachedImage: UIImage? = nil
        if let cacheType = cachedResult.cacheType {
            switch cacheType {
            case .Memory: cachedImage = globalImageCache.retrieveImageInMemoryCacheForKey(key)
            case .Disk: cachedImage = globalImageCache.retrieveImageInDiskCacheForKey(key, scale: UIScreen.mainScreen().scale)
            default: break
            }
        }
        return cachedImage
    }
}
