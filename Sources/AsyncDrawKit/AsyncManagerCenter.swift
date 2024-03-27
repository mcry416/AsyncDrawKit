//
//  AsyncManagerCenter.swift
//  
//
//  Created by Eldest's MacBook on 2024/2/15.
//

import UIKit

internal class AsyncManagerCenter: NSObject {
    
    internal static var `default`: AsyncManagerCenter = AsyncManagerCenter()
    
    private override init() {
        super.init()
        
        onInit()
    }
    
    private func onInit() {
        
    }
    
    
    
}
