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

extension CGSize {
    static func size(type: AppContext.IconSizeType) -> CGSize {
        switch type {
        case .Small:
            return CGSizeMake(14, 14)
        case .Middle:
            return CGSizeMake(30, 30)
        case .Big:
            return CGSizeMake(60, 60)
        }
    }
}

extension CGFloat {
    static func fontSize(type: AppContext.IconSizeType) -> CGFloat {
        switch type {
        case .Small:
            return CGFloat(14)
        case .Middle:
            return CGFloat(17)
        case .Big:
            return CGFloat(30)
        }
    }
}

extension String {
    func cacheKey(type: AppContext.IconSizeType) -> String {
        switch type {
        case .Small:
            return "\(self)_small"
        case .Middle:
            return "\(self)_middle"
        case .Big:
            return "\(self)_big"
        }
    }
}

class AppContext : NSObject {
    
    enum IconSizeType : Int {
        case Small
        case Middle
        case Big
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
    
    // MARK: - Search Resource
    static let globalSearchTintColor = FlatSkyBlueDark()
    static func globalSearchTimelineIcon(sizeType: IconSizeType = .Big) -> UIImage {
        return iconWithCacheKey(ImageCacheKey.SearchTimelineIcon, title: "圈", sizeType: sizeType, bold: true, backgroundColor: FlatPink(), foregroundColor: UIColor.whiteColor())
    }
    
    static func globalSearchArticleIcon(sizeType: IconSizeType = .Big) -> UIImage {
        return iconWithCacheKey(ImageCacheKey.SearchArticleIcon, title: "文", sizeType: sizeType, bold: true, backgroundColor: FlatMint(), foregroundColor: UIColor.whiteColor())
    }
    
    static func globalSearchCelebrityIcon(sizeType: IconSizeType = .Big) -> UIImage {
        return iconWithCacheKey(ImageCacheKey.SearchCelebrityIcon, title: "众", sizeType: sizeType, bold: true, backgroundColor: FlatSand(), foregroundColor: UIColor.whiteColor())
    }
    
    // MARK: - Message List Resource
    static let messageListViewTextDrawAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor(), NSFontAttributeName: UIFont.boldSystemFontOfSize(17)]
    static let messageListViewFunctionToolbarIconSize = CGSizeMake(24, 24)
    static func redirectIcon() -> UIImage {
        return iconWithCacheKey(ImageCacheKey.RedirectIcon, title: "转", bold: true, backgroundColor: FlatYellow(), foregroundColor: UIColor.whiteColor(), size: CGSizeMake(24, 24), fontSize: 17)
    }
    
    static func collectIcon() -> UIImage {
        return iconWithCacheKey(ImageCacheKey.CollectIcon, title: "藏", bold: true, backgroundColor: FlatMint(), foregroundColor: UIColor.whiteColor(), size: CGSizeMake(24, 24), fontSize: 17)
    }
    
    static func deleteIcon() -> UIImage {
        return iconWithCacheKey(ImageCacheKey.DeleteIcon, title: "删", bold: true, backgroundColor: FlatRed(), foregroundColor: UIColor.whiteColor(), size: CGSizeMake(24, 24), fontSize: 17)
    }
    
    static func moreIcon() -> UIImage {
        return iconWithCacheKey(ImageCacheKey.MoreIcon, title: "···", bold: true, backgroundColor: FlatMaroon(), foregroundColor: UIColor.whiteColor(), size: CGSizeMake(24, 24), fontSize: 17)
    }
    
    // MARK: - Utilities
    static func iconWithCacheKey(key: String, title: String, bold: Bool? = false, backgroundColor: UIColor? = UIColor.whiteColor(), foregroundColor: UIColor? = UIColor.blackColor(), size: CGSize? = CGSizeMake(60, 60), fontSize: CGFloat? = 30) -> UIImage {
        var image = imageWithCacheKey(key)
        if image == nil {
            let attributes = [NSForegroundColorAttributeName: foregroundColor!, NSFontAttributeName: bold! ? UIFont.boldSystemFontOfSize(fontSize!) : UIFont.systemFontOfSize(fontSize!)]
            image = UIImage.tq_imageFromString(title, backgroundColor: backgroundColor!, attributes: attributes, size: size!) ?? UIImage(color: FlatBlue(), size: size!)
            globalImageCache.storeImage(image!, originalData: UIImageJPEGRepresentation(image!, 0.9), forKey: key)
        }
        return image!
    }
    
    static func iconWithCacheKey(key: String, title: String, sizeType: IconSizeType, bold: Bool? = false, backgroundColor: UIColor? = UIColor.whiteColor(), foregroundColor: UIColor? = UIColor.blackColor()) -> UIImage {
        
        return iconWithCacheKey(key.cacheKey(sizeType), title: title, bold: bold, backgroundColor: backgroundColor, foregroundColor: foregroundColor, size: CGSize.size(sizeType), fontSize: CGFloat.fontSize(sizeType))
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
