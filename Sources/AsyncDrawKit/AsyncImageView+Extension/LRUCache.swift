/**
 * Copyright mcry416(mcry416@outlook.com). and its affiliates.
 *
 * This source code is licensed under the MIT license found in the
 * LICENSE file in the root directory of this source tree.
 */
import Foundation

// MARK: - Node

final internal class Node: NSObject {
    var pre: Node?
    var next: Node?
    var key: AnyHashable
    var value: Any
    
    init(value: Any, key: AnyHashable) {
        self.value = value
        self.key = key
        super.init()
    }
    
    override var description: String {
        return "\(key):\(value)"
    }
}

// MARK: - LinkMap

final internal class LinkMap: NSObject {
    var headNode: Node?
    var tailNode: Node?
    var dict = [AnyHashable: Node]()
    
    var totalCount: UInt64 = 0
    
    /// Insert a new element.
    /// - Parameter node: Element node.
    func insert(_ node: Node) {
        totalCount += 1
        dict[node.key] = node
        
        if let head = headNode {
            node.next = head
            head.pre = node
            
            // Reset the head node.
            headNode = node
        } else {
            headNode = node
            tailNode = node
        }
    }
    
    /// Remove a node.
    /// - Parameter node: Element node.
    func removeNode(_ node: Node) {
        totalCount -= 1
        dict.removeValue(forKey: node.key)
        
        if let _ = node.pre {
            node.pre?.next = node.next
        }
        
        if let _ = node.next {
            node.next?.pre = node.pre
        }
        
        if headNode == node {
            headNode = node.next
        }
        
        if tailNode == node {
            tailNode = node.pre
        }
    }

    /// Move the current node into head.
    /// - Parameter node: Element node.
    func moveNodeToHead(_ node: Node) {
        if headNode == node {
            return
        }
        
        // Delete the current node.
        if tailNode == node {
            tailNode = node.pre
            tailNode?.next = nil
        } else {
            node.next?.pre = node.pre
            node.pre?.next = node.next
        }
        
        // Move the current node into head.
        node.next = headNode
        node.pre = nil
        headNode?.pre = node
        
        // Reset the head node.
        headNode = node
    }
    
    /// Remove a tail node.
    func removeTailNode() -> Node? {
        totalCount -= 1
        if let tail = tailNode {
            let key = tail.key
            dict.removeValue(forKey: key)
        }
        
        if headNode == tailNode {
            return nil
        } else {
            tailNode = tailNode?.pre
            tailNode?.next = nil
            return tailNode
        }
    }
    
    /// Remove all elements.
    func removeAllNode() {
        totalCount = 0
        
        headNode = nil
        tailNode = nil
        dict = [AnyHashable: Node]()
    }
}

// MARK: - AsyncImageViewCache

final internal class AsyncImageViewCache: NSObject {
    var lru = LinkMap()
    var lock = NSLock()
    let limitCount: UInt64
    
    init(limitCount: UInt64 = 100) {
        self.limitCount = limitCount
        super.init()
    }
    
    func getObject(forKey key: AnyHashable) -> Any? {
        lock.lock()
        var node: Node?
        
        node = lru.dict[key]
        if let node = node {
            lru.moveNodeToHead(node)
        }
        lock.unlock()
        return node?.value
    }
    
    func setObject(_ value: Any, forKey key: AnyHashable) {
        lock.lock()
        
        if let node = lru.dict[key] {
            // If the node is existed, and move the node into head.
            // If the value is not equal, and set the new value into the node.
            node.value = value
            lru.moveNodeToHead(node)
        } else {
            // If the node was not existed, and insert a new element.
            let node = Node(value: value, key: key)
            lru.insert(node)
        }
        
        if lru.totalCount > limitCount {
            // Totally count was over the limit, and remoe the tail node.
            let _ = lru.removeTailNode()
        }
        
        lock.unlock()
    }
    
    func removeObjc(forKey key: AnyHashable) {
        lock.lock()
        
        if let node = lru.dict[key] {
            lru.removeNode(node)
        }
        lock.unlock()
    }
    
    override var description: String {
        var description = ""
        var node: Node? = lru.headNode
        while let current = node {
            description.append("\(current.description) ")
            node = current.next
        }
        
        return description
    }
}
