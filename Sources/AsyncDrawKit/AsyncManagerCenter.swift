/**
 * Copyright mcry416(mcry416@outlook.com). and its affiliates.
 *
 * This source code is licensed under the MIT license found in the
 * LICENSE file in the root directory of this source tree.
 */

import UIKit

public class SGAsyncManagerCenter: NSObject {
    
    public static var `default`: SGAsyncManagerCenter = SGAsyncManagerCenter()
    
    public var dynamicCacheBase: Int = 3
    
    @syncVariable
    private var cgImageCaches: Dictionary<String, CGImage> = Dictionary<String, CGImage>()
    
    @syncVariable
    private var cgImageIndexs: Array<String> = Array<String>()
    
    private override init() {
        super.init()
        
        onInit()
    }
    
    private func onInit() {
    
    }
    
    public func clearCache() {
        cgImageIndexs.removeAll()
        cgImageCaches.removeAll()
    }
    
    internal func pushDecodeFileName(_ file: String) -> Int {
        cgImageIndexs.append(file)
        let count: Int = cgImageIndexs.filter{ $0 == file }.count
        return count
    }
    
    internal func setCGImageCache(file: String, cgImage: CGImage) {
        cgImageCaches[file] = cgImage
    }
    
    internal func getCGImageCache(_ file: String) -> CGImage? {
        if let res = cgImageCaches[file] {
            return res
        }
        return nil
    }
    
}
