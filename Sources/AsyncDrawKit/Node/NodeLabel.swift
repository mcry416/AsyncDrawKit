/**
 * Copyright mcry416(mcry416@outlook.com). and its affiliates.
 *
 * This source code is licensed under the MIT license found in the
 * LICENSE file in the root directory of this source tree.
 */

import UIKit

open class NodeLabel: NSObject, NodeLayerDelegate {
    
    open var font: UIFont = .systemFont(ofSize: 12)
    
    open var text: String = ""
    
    open var contents: (Any & NSObject)?
    
    open var textColor: UIColor = .black
    
    open var backgroundColor: UIColor = .white
    
    open var frame: CGRect = .zero
    
    open var hidden: Bool = false
    
    open var alpha: CGFloat = 1.0
    
    open var superView: NodeLayerDelegate?
    
    open var paintSignal: Bool = false
    
    open func setOnTapListener(_ listerner: (() -> Void)?) {
        
    }
    
    open func setOnClickListener(_ listerner: (() -> Void)?) {
        
    }
    
    open func didReceiveTapSignal() {
        
    }
    
    open func didReceiveClickSignal() {
        
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
