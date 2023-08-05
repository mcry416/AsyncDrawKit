//
//  AsyncImageView.swift
//  Compent
//
//  Created by Eldest's MacBook on 2023/5/31.
//

import UIKit
import CoreGraphics

public enum ImageDecoderMode: Int {
    case jpeg = 0
    case png = 1
}

open class AsyncImageView: UIView, SGAsyncDelgate {
    
    /**
     Indicate the decode image mode for AsyncImageView. Defalut is jpeg.
     - Note: ImageDecoderMode.jpeg is the compress mode, and ImageDecoderMode.png is non-compress mode.
     */
    public var imageDecoderMode: ImageDecoderMode = .jpeg
    
    public var image: UIImage? {
        didSet { SGALTranscation(target: self, funcPtr: #selector(drawTask)).commit() }
    }
    
    /** Effective in content mode of `ImageDecoderMode == .jpeg` only.  */
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
        
        guard let image = self.image else { return }
        
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
    
    private final func decoderImage(_ src: UIImage?) -> UIImage? {
        guard let src = src else { return src }
        guard let imageRef: CGImage = image?.cgImage else { return src }
        guard let colorSpaceRef: CGColorSpace = imageRef.colorSpace else { return src }
        let bitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.premultipliedLast.rawValue)
        let width: size_t = imageRef.width
        let height: size_t = imageRef.height
        guard let context: CGContext = CGContext(data: nil, width: width, height: height, bitsPerComponent: 8, bytesPerRow: 0, space: colorSpaceRef, bitmapInfo: bitmapInfo.rawValue) else { return src }
        
        context.draw(imageRef, in: CGRect(x: 0, y: 0, width: width, height: height))
        guard let newImageRef: CGImage = context.makeImage() else { return src }
        let newImage: UIImage = UIImage(cgImage: newImageRef, scale: src.scale, orientation: src.imageOrientation)
        
        return newImage
    }

}
