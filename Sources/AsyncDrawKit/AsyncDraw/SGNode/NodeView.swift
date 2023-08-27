/**
 * Copyright mcry416(mcry416@outlook.com). and its affiliates.
 *
 * This source code is licensed under the MIT license found in the
 * LICENSE file in the root directory of this source tree.
 */

import UIKit

open class NodeView: NSObject, NodeLayerDelegate {
    
    var contents: (Any & NSObject)?
    
    var backgroundColor: UIColor = .white
    
    var frame: CGRect = .zero
    
    var hidden: Bool = false
    
    var alpha: CGFloat = 1.0
    
    var superView: NodeLayerDelegate?
    
    var paintSignal: Bool = false
    
    private var didReceiveTapBlock: (() -> Void)?
    
    private var didReceiveClickBlock: (() -> Void)?
    
    func setOnTapListener(_ listerner: (() -> Void)?) {
        didReceiveTapBlock = {
            listerner?()
        }
    }
    
    func setOnClickListener(_ listerner: (() -> Void)?) {
        didReceiveClickBlock = {
            listerner?()
        }
    }
    
    func didReceiveTapSignal() {
        didReceiveTapBlock?()
    }
    
    func didReceiveClickSignal() {
        didReceiveClickBlock?()
    }
    
    func removeFromSuperView() {
        
    }
    
    func willLoadToSuperView() {
        
    }
    
    func didLoadToSuperView() {
        
    }
    
    func setNeedsDisplay() {
        
    }
    
}
