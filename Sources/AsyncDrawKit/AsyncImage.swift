/**
 * Copyright mcry416(mcry416@outlook.com). and its affiliates.
 *
 * This source code is licensed under the MIT license found in the
 * LICENSE file in the root directory of this source tree.
 */


import UIKit

// MARK: - SGAsyncImage

open class SGAsyncImage: NSObject {
    
    @syncVariable
    public var cgImage: CGImage?
    
    public init?(_ data: Data?, size: CGSize) {
        
        guard let data = data else { return }
        let viewMaxSide: CGFloat = max(size.width, size.height)
        // Transfer Image into CFData
        guard let cfData: CFData = CFDataCreate(nil, data.withUnsafeBytes { $0 }, data.count) else { return }
        // Transfer CFData into CGImage
        let thumbnailOption = [kCGImageSourceCreateThumbnailWithTransform: kCFBooleanTrue!,
                           kCGImageSourceCreateThumbnailFromImageIfAbsent: kCFBooleanTrue!,
                                      kCGImageSourceThumbnailMaxPixelSize: viewMaxSide] as CFDictionary
        guard let thumbnailCGImageSource = CGImageSourceCreateWithData(cfData, thumbnailOption) else { return }
        guard let thumbnailCGImage: CGImage = CGImageSourceCreateImageAtIndex(thumbnailCGImageSource, 0, nil) else { return }
        cgImage = thumbnailCGImage
    }
    
}

// MARK: - @syncVariable

/** Sync a variable by using `NSLock`. */
@propertyWrapper
public class syncVariable<T> {
    
    private lazy var lock: NSLock = { NSLock() }()
    
    private var _wrappedValue: T?
    public var wrappedValue: T {
        set {
            lock.lock()
            self._wrappedValue = newValue
            lock.unlock()
        }
        get {
            var tempValue: T!
            lock.lock()
            tempValue = self._wrappedValue
            lock.unlock()
            return tempValue
        }
    }
    
    public init(wrappedValue: T) {
        self.wrappedValue = wrappedValue
    }
    
}

