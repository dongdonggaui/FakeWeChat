//
//  AvatarBadgeView.swift
//  FakeWeChat
//
//  Created by huangluyang on 15/12/25.
//  Copyright © 2015年 huangluyang. All rights reserved.
//

import UIKit
import Kingfisher
import SnapKit

typealias AvatarComposeCompletionHandler = (() -> ())

class AvatarBadgeView: UIView {
    
    var avatarImageTasks: [RetrieveImageTask] = []
    
    lazy var imageCache = KingfisherManager.sharedManager.cache
    
    var badgeValue = 0 {
        didSet {
            badgeView.badgeValue = badgeValue
        }
    }
    
    let webImageDownloader = ImageDownloader(name: "\(AvatarBadgeView.self)")
    
    let avatarImageView = UIImageView()
    let badgeView = BadgeView()
    
    override func awakeFromNib() {
        avatarBadgeViewInit()
    }
    
    func avatarBadgeViewInit() {
        self.addSubview(avatarImageView)
        self.addSubview(badgeView)
        avatarImageView.snp_makeConstraints { (make) -> Void in
            make.edges.equalTo(self)
        }
    }
    
    func setImagePaths(paths: [String], completion: AvatarComposeCompletionHandler?) {
        let cacheKey = self.cacheKeyForPaths(paths)
        let cachedResult = self.imageCache.isImageCachedForKey(cacheKey)
        var cachedImage: UIImage? = nil
        if let cacheType = cachedResult.cacheType {
            switch cacheType {
            case .Memory: cachedImage = self.imageCache.retrieveImageInMemoryCacheForKey(cacheKey)
            case .Disk: cachedImage = self.imageCache.retrieveImageInDiskCacheForKey(cacheKey)
            default: break
            }
        }
        if let sCachedImage = cachedImage {
            self.avatarImageView.image = sCachedImage
            completion?()
            return;
        }
        let count = paths.count
        var currentCount = 0
        var images: [UIImage] = []
        for task in avatarImageTasks {
            task.cancel()
        }
        for path in paths {
            let task = KingfisherManager.sharedManager.retrieveImageWithURL(NSURL(string: path)!, optionsInfo: nil, progressBlock: nil, completionHandler: { (image, error, cacheType, imageURL) -> () in
                if image == nil {
                    return;
                }
                images.append(image!)
                currentCount++
                if currentCount == count {
                    if let composedImage = ImageComposer.composedImage(images, destinationSize: CGSizeMake(CGFloat(50), CGFloat(50)), backgroundColor: UIColor.lightGrayColor()) {
                        self.imageCache.storeImage(composedImage, forKey: cacheKey)
                        self.avatarImageView.image = composedImage
                    }
                }
            })
            self.avatarImageTasks += [task]
        }
    }
    
    func cacheKeyForPaths(paths: [String]) -> String {
        let sortedPath = paths.sort()
        let key = sortedPath.joinWithSeparator("")
        return key
    }
}
