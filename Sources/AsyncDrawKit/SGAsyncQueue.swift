/**
 * Copyright mcry416(mcry416@outlook.com). and its affiliates.
 *
 * This source code is licensed under the MIT license found in the
 * LICENSE file in the root directory of this source tree.
 */

import Foundation

final internal class SGAsyncQueue {
    
    internal var queue: DispatchQueue = { dispatch_queue_serial_t(label: "com.sg.async_draw.queue", qos: .userInitiated) }()
    
    internal var taskCount: Int = 0
    
    internal var index: Int = 0
}
