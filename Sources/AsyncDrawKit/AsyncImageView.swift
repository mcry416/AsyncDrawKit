/**
 * Copyright mcry416(mcry416@outlook.com). and its affiliates.
 *
 * This source code is licensed under the MIT license found in the
 * LICENSE file in the root directory of this source tree.
 */

import UIKit
import CoreGraphics

public enum ImageDecoderMode: Int {
    case jpeg = 0
    case png = 1
}

/**
 Async draw image with CGContext and async decode data to image. Access an URL string to set image for itself.
 - Note: Image source was come from `UIImage` initlized, the property of `imageFiled` , the property of `imageNamed` and the method of `sg_setImage(:)`. And advanced class was `imageFiled`,  `imageNamed`, `image`, `sg_setImage(:)` was equal to `image`.
 - Note: The default cache strategy is LRU and its limited is 100.
 */
open class AsyncImageView: UIView, SGAsyncDelgate {
    
    /**
     Indicate the decode image mode for AsyncImageView. Defalut is jpeg.
     - Note: ImageDecoderMode.jpeg is the compress mode, and ImageDecoderMode.png is non-compress mode.
     */
    public var imageDecoderMode: ImageDecoderMode = .jpeg
    
    public var imageFiled: String? {
        didSet { SGALTranscation(target: self, funcPtr: #selector(drawTask)).commit() }
    }
    
    public var imageNamed: String? {
        didSet { SGALTranscation(target: self, funcPtr: #selector(drawTask)).commit() }
    }
    
    public var image: UIImage? {
        didSet { SGALTranscation(target: self, funcPtr: #selector(drawTask)).commit() }
    }
    
    /** Effective in content mode of `ImageDecoderMode == .jpeg` and source from `image` property only.  */
    public var quality: CGFloat = 0.9 {
        didSet { SGALTranscation(target: self, funcPtr: #selector(drawTask)).commit() }
    }
    
    open override class var layerClass: AnyClass {
        SGAsyncLayer.self
    }
    
    @objc private func drawTask() {
        self.layer.setNeedsDisplay()
    }
    
    func asyncDraw(layer: CALayer, in context: CGContext, size: CGSize, isCancel cancel: Bool) {
        if cancel {
            return
        }
        
        let size: CGSize = layer.bounds.size
        context.textMatrix = CGAffineTransformIdentity
        context.translateBy(x: 0, y: size.height)
        context.scaleBy(x: 1, y: -1)
        
        if let res = self.imageFiled {
            decoderImage(res, layer: layer, in: context, size: size, isCancel: cancel)
            return
        }
        
        if let res = self.imageNamed {
            decoderImage(res, layer: layer, in: context, size: size, isCancel: cancel)
            return
        }
        
        if let image = self.image {
            decoderImage(image, layer: layer, in: context, size: size, isCancel: cancel)
            return
        }
    }

}

// MARK: - Decode

extension AsyncImageView {
    
    private final func decoderImage(_ res: String, layer: CALayer, in context: CGContext, size: CGSize, isCancel cancel: Bool) {
        var path: String?
        if let tempPath = Bundle.main.path(forResource: res, ofType: "jpg") {
            path = tempPath
        }
        if let tempPath = Bundle.main.path(forResource: res, ofType: "jpeg") {
            path = tempPath
        }
        if let tempPath = Bundle.main.path(forResource: res, ofType: "png") {
            path = tempPath
        }
        guard let path = path else { return }
        guard let data: Data = try? Data(contentsOf: URL(fileURLWithPath: path)) else { return }
        
        let viewMaxSide: CGFloat = max(size.width, size.height)
        // Transfer CFData into CGImage
        let downsampleOption = [kCGImageSourceCreateThumbnailWithTransform: kCFBooleanTrue!,
                           kCGImageSourceCreateThumbnailFromImageIfAbsent: kCFBooleanTrue!,
                                      kCGImageSourceThumbnailMaxPixelSize: viewMaxSide] as CFDictionary
        guard let imageSrc: CGImageSource = CGImageSourceCreateWithData(data as CFData, downsampleOption) else { return }
        guard let imageRef: CGImage = CGImageSourceCreateImageAtIndex(imageSrc, 0, nil) else { return }
        
        context.draw(imageRef, in: CGRect(origin: .zero, size: size))
    }
    
    private final func decoderImage(_ resImage: UIImage?, layer: CALayer, in context: CGContext, size: CGSize, isCancel cancel: Bool) {
        
        guard let image = resImage else { return }
        let viewMaxSide: CGFloat = max(size.width, size.height)
        
        // Transfer Image into CFData
        let imageDecoderData: Data? = (self.imageDecoderMode == .jpeg) ? image.jpegData(compressionQuality: self.quality) : image.pngData()
        guard let imageDecoderData = imageDecoderData else { return }
        guard let cfData: CFData = CFDataCreate(nil, imageDecoderData.withUnsafeBytes { $0 }, imageDecoderData.count) else { return }
        
        // Transfer CFData into CGImage
        let thumbnailOption = [kCGImageSourceCreateThumbnailWithTransform: kCFBooleanTrue!,
                           kCGImageSourceCreateThumbnailFromImageIfAbsent: kCFBooleanTrue!,
                                      kCGImageSourceThumbnailMaxPixelSize: viewMaxSide] as CFDictionary
        guard let thumbnailCGImageSource = CGImageSourceCreateWithData(cfData, thumbnailOption) else { return }
        guard let thumbnailCGImage: CGImage = CGImageSourceCreateImageAtIndex(thumbnailCGImageSource, 0, nil) else { return }
        
        context.draw(thumbnailCGImage, in: CGRect(origin: .zero, size: size))
    }
    
}
