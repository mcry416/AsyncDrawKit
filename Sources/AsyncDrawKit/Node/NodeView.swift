/**
 * Copyright mcry416(mcry416@outlook.com). and its affiliates.
 *
 * This source code is licensed under the MIT license found in the
 * LICENSE file in the root directory of this source tree.
 */

import UIKit

open class NodeView: NSObject, NodeLayerDelegate {
    
    open var dynamicTouchInsets: UIEdgeInsets = .zero
    
    open var contents: (Any & NSObject)?
    
    open var backgroundColor: UIColor = .white
    
    open var frame: CGRect = .zero
    
    open var hidden: Bool = false
    
    open var alpha: CGFloat = 1.0
    
    open var superView: NodeLayerDelegate?
    
    open var paintSignal: Bool = false
    
    private var didReceiveTapBlock: (() -> Void)?
    
    private var didReceiveClickBlock: (() -> Void)?
    
    open func setOnTapListener(_ listerner: (() -> Void)?) {
        didReceiveTapBlock = {
            listerner?()
        }
    }
    
    open func setOnClickListener(_ listerner: (() -> Void)?) {
        didReceiveClickBlock = {
            listerner?()
        }
    }
    
    open func didReceiveTapSignal() {
        didReceiveTapBlock?()
    }
    
    open func didReceiveClickSignal() {
        didReceiveClickBlock?()
    }
    
    open func removeFromSuperView() {
        
    }
    
    open func willLoadToSuperView() {
        
    }
    
    open func didLoadToSuperView() {
        
    }
    
    open func setNeedsDisplay() {
        
    }
    
}
