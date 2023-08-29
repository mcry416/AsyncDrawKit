/**
 * Copyright mcry416(mcry416@outlook.com). and its affiliates.
 *
 * This source code is licensed under the MIT license found in the
 * LICENSE file in the root directory of this source tree.
 */

import UIKit

extension AsyncImageView {
    
    private static var sg_asyncImageCaches: AsyncImageViewCache = { AsyncImageViewCache(limitCount: 100) }()
    
    /**
     Set image with an URL sting, provide placeholder and completion callback.
     - Parameter urlString: Image url string.
     - Parameter placeholder: When the image was not loaded, and show placeholder from local resource.
     - Parameter completion: Image loaded succeed, and execute this callback.
     */
    func sg_setImage(_ urlString: String, placeholderName placeholder: String? = nil, completion: ((UIImage) -> Void)? = nil) {
        if let cache = AsyncImageView.sg_asyncImageCaches.getObject(forKey: urlString) as? UIImage {
            self.image = cache
            return
        }
        
        if let placeholder = placeholder, let placeholderImage = UIImage(named: placeholder) {
            self.image = placeholderImage
        }
        
        DispatchQueue.global().async {
            guard let url = URL(string: urlString) else { return }
            URLSession.shared.dataTask(with: url) { data, response, error  in
                if let data = data, let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        AsyncImageView.sg_asyncImageCaches.setObject(image, forKey: urlString)
                        self.image = image
                        completion?(image)
                    }
                } else {
                    if let error = error {
                        debugPrint("----> ERROR : \(error)")
                    }
                }
            }.resume()
        }
        
    }
    
}
