//
//  CacheHandlerContract.swift
//  NZImageDemo
//
//  Created by Nilesh Zambre on 23/12/21.
//  Copyright © 2021 Nilesh Zambre. All rights reserved.
//
public typealias CancelDownloading = () -> Void
public protocol CacheHandlerContract {
    func setupCache(memory: Int, disk: Int)
}
