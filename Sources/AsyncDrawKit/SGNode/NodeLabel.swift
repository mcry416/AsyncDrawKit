/**
 * Copyright mcry416(mcry416@outlook.com). and its affiliates.
 *
 * This source code is licensed under the MIT license found in the
 * LICENSE file in the root directory of this source tree.
 */

import UIKit

open class NodeLabel: NSObject, NodeLayerDelegate {
    
    var font: UIFont = .systemFont(ofSize: 12)
    
    var text: String = ""
    
    var contents: (Any & NSObject)?
    
    var textColor: UIColor = .black
    
    var backgroundColor: UIColor = .white
    
    var frame: CGRect = .zero
    
    var hidden: Bool = false
    
    var alpha: CGFloat = 1.0
    
    var superView: NodeLayerDelegate?
    
    var paintSignal: Bool = false
    
    func setOnTapListener(_ listerner: (() -> Void)?) {
        
    }
    
    func setOnClickListener(_ listerner: (() -> Void)?) {
        
    }
    
    func didReceiveTapSignal() {
        
    }
    
    func didReceiveClickSignal() {
        
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
