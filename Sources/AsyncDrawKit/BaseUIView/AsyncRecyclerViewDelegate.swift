/**
 * Copyright mcry416(mcry416@outlook.com). and its affiliates.
 *
 * This source code is licensed under the MIT license found in the
 * LICENSE file in the root directory of this source tree.
 */

import UIKit

/**
 Delegate and data source for AsyncRecyclerView. And the delegate will be runned on main thread defalut.
 - Note: for lowist edition operations, the APIs was desigend is similar with `UITableView`.
 
 */
@objc
@MainActor public protocol AsyncRecyclerViewDelegate {
    
    func numberOfRows(in recyclerView: AsyncRecyclerView) -> Int
    
    func recyclerView(_ recyclerView: AsyncRecyclerView, cellForRowAt indexPath: IndexPath) -> UIView
    
    @objc
    optional func recyclerView(_ recyclerView: AsyncRecyclerView, didSelectRowAt indexPath: IndexPath)
    
    @objc
    optional func recyclerView(_ recyclerView: AsyncRecyclerView, heightForRowAt indexPath: IndexPath) -> CGFloat
}

@MainActor public protocol AsyncRecyclerViewCellDelegate {
    
    func prepareForReuse()
}
