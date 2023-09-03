/**
 * Copyright mcry416(mcry416@outlook.com). and its affiliates.
 *
 * This source code is licensed under the MIT license found in the
 * LICENSE file in the root directory of this source tree.
 */

import Foundation

open class ImageNetwork: NSObject {
    
    public typealias CompletionHandler = ((Data) -> Void)?
    
    @syncVariable
    private var tokens: Array<String> = Array<String>()
    
    @syncVariable
    private var msgs: Array<RequestMsg> = Array<RequestMsg>()
    
    private lazy var syncQueue: DispatchQueue = {
        let name = String(format: "org.sg.image_network.sync_queue-%08x%08x", arc4random(), arc4random())
        return DispatchQueue(label: name)
    }()

    open func fetchData(url: URL, requestToken: String, completionHandler: CompletionHandler) {
        self.tokens.append(requestToken)
        msgs.forEach { tokens.contains($0.token ?? "") ? nil : $0.task?.cancel() }
        
        syncQueue.async {
            let requestMsg: RequestMsg = RequestMsg()
            requestMsg.token = requestToken
            requestMsg.session = URLSession(configuration: RequestMsg.getConfig())
            requestMsg.task = requestMsg.session?.dataTask(with: url, completionHandler: { (dstData, dstResponse, error) in
                guard let data = dstData else { return }
                if error == nil {
                    DispatchQueue.main.async {
                        completionHandler?(data)
                    }
                } else {
                    debugPrint("------> ImageNetwotk Error: \(String(describing: error))")
                }
            })
            requestMsg.task?.resume()
            
            self.msgs.append(requestMsg)
        }
    }
    
    open func cancelData() {
        msgs.forEach { $0.task?.cancel() }
        tokens.removeAll()
    }
    
}
