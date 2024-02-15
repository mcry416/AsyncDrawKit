/**
 * Copyright mcry416(mcry416@outlook.com). and its affiliates.
 *
 * This source code is licensed under the MIT license found in the
 * LICENSE file in the root directory of this source tree.
 */

import UIKit
import Foundation

extension AsyncImageView {
    
    private static var sg_lru_cache_limited: UInt64 = 100
    
    private static var sg_asyncImageCaches: AsyncImageViewCache = { AsyncImageViewCache(limitCount: sg_lru_cache_limited) }()
    
    private var imageNetwork: ImageNetwork? {
        set { objc_setAssociatedObject(self, &AsyncImageViewAssociatedKeys.imageNetwork, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC) }
        get { objc_getAssociatedObject(self, &AsyncImageViewAssociatedKeys.imageNetwork) as? ImageNetwork }
    }
    
    /**
     Set image with an URL sting, provide placeholder and completion callback.
     - Parameter urlString: Image url string.
     - Parameter placeholder: When the image was not loaded, and show placeholder from local resource.
     - Parameter completion: Image loaded succeed, and execute this callback.
     */
    public func sg_setImage(_ urlString: String, placeholderName placeholder: String? = nil, completion: ((UIImage) -> Void)? = nil) {
        if let cache = AsyncImageView.sg_asyncImageCaches.getObject(forKey: urlString) as? UIImage {
            self.image = cache
            return
        }
        
        if let placeholder = placeholder, let placeholderImage = UIImage(named: placeholder) {
            self.image = placeholderImage
        }
        
        if imageNetwork == nil {
            imageNetwork = ImageNetwork()
        }
        
        guard let url = URL(string: urlString) else { return }
        imageNetwork?.fetchData(url: url, requestToken: urlString, completionHandler: { (data) in
            if let tempImage = UIImage(data: data) {
                AsyncImageView.sg_asyncImageCaches.setObject(tempImage, forKey: urlString)
                self.image = tempImage
                completion?(tempImage)
            }
        })
        
    }
    
    public func sg_cancelRequest() {
        imageNetwork?.cancelData()
    }
    
}

private enum AsyncImageViewAssociatedKeys {
    static var imageNetwork: Bool = true
    static var imageToken:   Bool = true
}
