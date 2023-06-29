
//
//  PhotoDownloadResult.swift
//  NZImageDemo
//
//  Created by Nilesh Zambre on 23/12/21.
//  Copyright © 2021 Nilesh Zambre. All rights reserved.
//

import Foundation
import CommonCode
import UIKit

public enum PhotoDownloadResult {
    case success(UIImage)
    case noData
    case userCancelled
    case error(Error) /// Might be SynchronizerError or parsing error thrown by Resource parse function
}

extension PhotoDownloadResult {
    static func resultWithResponse(_ response: URLResponse?, error: NSError?) -> PhotoDownloadResult? {
        guard error == nil else {
            return self.error(APIError.urlSessionError(error!))
        }
        let statusCode = (response as! HTTPURLResponse).statusCode
        guard 200..<300 ~= statusCode else {
            return self.error(APIError.wrongStatusError(status: statusCode))
        }
        return nil
    }
}
