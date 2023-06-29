//
//  ImageProcessor.swift
//  NZImageDemo
//
//  Created by Nilesh Zambre on 23/12/21.
//  Copyright © 2021 Nilesh Zambre. All rights reserved.
//
import Foundation
import UIKit

public protocol Processor {
    associatedtype ParsedObject
    var parse: (Data) throws -> ParsedObject { get }
}

public struct ImageProcessor: Processor { }
public extension ImageProcessor {
    var parse: (Data) throws -> UIImage? {
        return { data in
            UIImage(data: data)
        }
    }
}
