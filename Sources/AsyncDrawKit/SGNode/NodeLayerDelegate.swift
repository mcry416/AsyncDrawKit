/**
 * Copyright mcry416(mcry416@outlook.com). and its affiliates.
 *
 * This source code is licensed under the MIT license found in the
 * LICENSE file in the root directory of this source tree.
 */

import UIKit

protocol NodeLayerDelegate: NSObject {
    
    var contents: (Any & NSObject)? { set get }
    
    var backgroundColor: UIColor { set get }
    
    var frame: CGRect { set get }
    
    var hidden: Bool { set get }
    
    var alpha: CGFloat { set get }
    
    var superView: NodeLayerDelegate? { get }
    
    var paintSignal: Bool { set get }
    
    func setOnTapListener(_ listerner: (() -> Void)?)
    
    func setOnClickListener(_ listerner: (() -> Void)?)
    
    func didReceiveTapSignal()
    
    func didReceiveClickSignal()
    
    func removeFromSuperView()
    
    func willLoadToSuperView()
    
    func didLoadToSuperView()
    
    func setNeedsDisplay()
    
}
