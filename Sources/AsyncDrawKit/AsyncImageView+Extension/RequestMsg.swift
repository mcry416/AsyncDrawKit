/**
 * Copyright mcry416(mcry416@outlook.com). and its affiliates.
 *
 * This source code is licensed under the MIT license found in the
 * LICENSE file in the root directory of this source tree.
 */

import Foundation

open class RequestMsg: NSObject {
    
    public var token: String?
    
    public var session: URLSession?
    
    public var task: URLSessionDataTask?
    
    open class func getConfig() -> URLSessionConfiguration {
        let configuration: URLSessionConfiguration = URLSessionConfiguration.default

        configuration.httpShouldSetCookies = true
        configuration.httpShouldUsePipelining = false

        configuration.requestCachePolicy = .useProtocolCachePolicy
        configuration.allowsCellularAccess = true
        configuration.timeoutIntervalForRequest = 60

        configuration.urlCache = RequestMsg.defaultURLCache()

        return configuration
    }
    
    open class func defaultURLCache() -> URLCache {
        let memoryCapacity: Int = 50 * 1024 * 1024
        let diskCapacity: Int = 150 * 1024 * 1024
        let imageDownloaderPath: String = "com.sg.async_draw_kit.async_image_view.network"

        return URLCache(memoryCapacity: memoryCapacity,
                        diskCapacity: diskCapacity,
                        diskPath: imageDownloaderPath)
    }
    
}
