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
import YYKit

typealias AvatarComposeCompletionHandler = (() -> ())

class AvatarBadgeView: UIView {
    
    // MARK: - Life Cycle
    override func awakeFromNib() {
        avatarBadgeViewInit()
    }
    
    // MARK: - Properties
    private var avatarImageTasks: [RetrieveImageTask] = []
    
    var badgeValue = 0 {
        didSet {
            badgeView.badgeValue = badgeValue
        }
    }
    
    var imageSize = CGSizeMake(50, 50)
    
    let imageCache = KingfisherManager.sharedManager.cache
    let webImageDownloader = ImageDownloader(name: "\(AvatarBadgeView.self)")
    let avatarImageView = UIImageView()
    let badgeView = BadgeView()
    
    // MARK: - Public Methods
    func setImagePaths(paths: [String], placeholder: UIImage?, completion: AvatarComposeCompletionHandler?) {
        if let sPlaceholder = placeholder {
            self.avatarImageView.image = sPlaceholder
        }
        
        let cacheKey = self.cacheKeyForPaths(paths)
        if let cachedImage = AppContext.imageWithCacheKey(cacheKey) {
            self.avatarImageView.image = cachedImage
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
            let task = KingfisherManager.sharedManager.retrieveImageWithURL(NSURL(string: path)!, optionsInfo: nil, progressBlock: nil, completionHandler: { [weak self](image, error, cacheType, imageURL) -> () in
                if image == nil || self == nil {
                    return;
                }
                images.append(image!)
                currentCount++
                if currentCount == count {
                    if let composedImage = ImageComposer.composedImage(images, destinationSize: self!.imageSize, backgroundColor: UIColor.lightGrayColor()) {
                        self!.imageCache.storeImage(composedImage, forKey: cacheKey)
                        dispatch_async(dispatch_get_main_queue(), { () -> Void in
                            self!.avatarImageView.image = composedImage
                        })
                    }
                }
            })
            self.avatarImageTasks += [task]
        }
    }
    
    // MARK: - Private Methods
    
    func avatarBadgeViewInit() {
        self.addSubview(avatarImageView)
        self.addSubview(badgeView)
        avatarImageView.snp_makeConstraints { (make) -> Void in
            make.edges.equalTo(self)
        }
    }
    
    func cacheKeyForPaths(paths: [String]) -> String {
        let sortedPath = paths.sort()
        let key = sortedPath.joinWithSeparator("")
        return key.tq_md5()
    }
}
