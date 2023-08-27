/**
 * Copyright mcry416(mcry416@outlook.com). and its affiliates.
 *
 * This source code is licensed under the MIT license found in the
 * LICENSE file in the root directory of this source tree.
 */

import Foundation

// MARK: - AtomicTask(AtomicMsg)

final fileprivate class AtomicTask: NSObject {
    
    internal var target: NSObject!
    internal var funcPtr: Selector!
    
    init(target: NSObject!, funcPtr: Selector!) {
        self.target = target
        self.funcPtr = funcPtr
    }
    
    override var hash: Int {
        target.hash ^ funcPtr.hashValue
    }
    
}

// MARK: - PTheradLock

final fileprivate class PTheradLock {
    
    init() {
        pthread_mutexattr_init(&recursiveMutexAttr)
        pthread_mutexattr_settype(&recursiveMutexAttr, PTHREAD_MUTEX_RECURSIVE)
        pthread_mutex_init(&recursiveMutex, &recursiveMutexAttr)
    }
    
    @inline(__always)
    final func lock() {
        pthread_mutex_lock(&recursiveMutex)
    }
    
    @inline(__always)
    final func unlock() {
        pthread_mutex_unlock(&recursiveMutex)
    }
    
    private var recursiveMutex = pthread_mutex_t()
    private var recursiveMutexAttr = pthread_mutexattr_t()
    
}


// MARK: - SGALTranscation

final internal class SGALTranscation {
    
    /** The task that need process in current runloop. */
    private static var tasks: Set<AtomicTask> = { Set<AtomicTask>() }()
    
    /** Create a SGAsyncLayer Transcation task. */
    internal init (target: NSObject, funcPtr: Selector) {
        SGALTranscation.tasks.insert(AtomicTask(target: target, funcPtr: funcPtr))
    }
    
    /** Listen the runloop's change, and execute callback handler to process task. */
    private func initTask() {
        DispatchQueue.once(token: "sg_async_layer_transcation") {
            let runloop    = CFRunLoopGetCurrent()
            let activities = CFRunLoopActivity.beforeWaiting.rawValue | CFRunLoopActivity.exit.rawValue
            let observer   = CFRunLoopObserverCreateWithHandler(nil, activities, true, 0xFFFFFF) { (ob, ac) in
                guard SGALTranscation.tasks.count > 0 else { return }
                SGALTranscation.tasks.forEach { $0.target.perform($0.funcPtr) }
                SGALTranscation.tasks.removeAll()
            }
            CFRunLoopAddObserver(runloop, observer, .defaultMode)
        }
    }
    
    /** Commit  the draw task into runloop. */
    public func commit(){
        initTask()
    }
    
}

// MARK: - DispatQueue.once

extension DispatchQueue {
    
    private static var _onceTokenDictionary: [String: String] = { [: ] }()
    
    private static var _dispatch_thread_lock: PTheradLock = { PTheradLock() }()
    
    /** Execute once safety. */
    static func once(token: String, _ block: (() -> Void)){
        defer { _dispatch_thread_lock.unlock() }
        _dispatch_thread_lock.lock()
        
        if _onceTokenDictionary[token] != nil {
            return
        }

        _onceTokenDictionary[token] = token
        block()
    }
    
}
