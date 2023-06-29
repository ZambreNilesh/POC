//
//  CacheHandler.swift
//  NZImageDemo
//
//  Created by Nilesh Zambre on 23/12/21.
//  Copyright © 2021 Nilesh Zambre. All rights reserved.
//

import UIKit
public final class CacheHandler: NSObject {
    private let MB = 1024 * 1024
    public static let sharedHandler = CacheHandler()
    public var cache = URLCache()
    public func setupCache(memoryInMB: Int = 100,
                           diskCapacityInMB: Int = 100) {
        cache.memoryCapacity = memoryInMB * MB
        cache.diskCapacity = diskCapacityInMB * MB

    }
}
