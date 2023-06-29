//
//  PhotoDownloader.swift
//  NZImageDemo
//
//  Created by Nilesh Zambre on 23/12/21.
//  Copyright © 2021 Nilesh Zambre. All rights reserved.
//
import Foundation
import UIKit

typealias DownloadCompletionHandler = (Data?, URLResponse?, NSError?) -> Void

public class PhotoDownloader: NSObject, DownloaderContract {
    private let oneHour: TimeInterval = 60 * 60
    private var completionHandlerForTask = [URLSessionTask: DownloadCompletionHandler]()
    private var dataForTask = [URLSessionTask: NSMutableData?]()
    private lazy var session = self.createSession()
    private lazy var imageProcessor = ImageProcessor()
    
    private func createSession() -> URLSession {
        return  URLSession(configuration: sessionConfiguration,
                           delegate: self,
                           delegateQueue: OperationQueue.main)
    }
    
    private func createRequest(url: String) -> URLRequest {
        return URLRequest(url: URL(string: url)!)
    }
    
    private let sessionConfiguration: URLSessionConfiguration
    private let maxCacheTime: TimeInterval
    
    public init(maxCacheTimeInHour: Int,
                URLCache: Foundation.URLCache? = URLSessionConfiguration.default.urlCache) {
        self.maxCacheTime = TimeInterval(maxCacheTimeInHour * Int(oneHour))
        self.sessionConfiguration = URLSessionConfiguration.default
        self.sessionConfiguration.urlCache = URLCache
    }
    
    public func cancelSession() {
        session.invalidateAndCancel()
        session = createSession()
    }
    
    
    public func loadImage(with url: String,
                          completion :@escaping (DownloadCompletion)) -> CancelDowloading {
        func completeOnMainThread(_ result: PhotoDownloadResult) {
            if case .error = result { print(result) }
            OperationQueue.main.addOperation { completion(result) }
        }
        let request = createRequest(url: url)
        let task = session.dataTask(with: request)
        setCompletionHandlerForTask(task) { (data, response, error) in
            guard error?.code != NSURLErrorCancelled else {
                completeOnMainThread(.userCancelled)
                return
            }
            if let result = PhotoDownloadResult.resultWithResponse(response, error: error) {
                completeOnMainThread(result)
                return
            }
            guard let data = data, data.count > 0 else {
                completeOnMainThread(.noData)
                return
            }
            do {
                guard let object = try self.imageProcessor.parse(data) else {
                    completeOnMainThread(.noData)
                    return
                }
                completeOnMainThread(.success(object))
            } catch {
                completeOnMainThread(.error(error))
            }
        }
        task.resume()
        return { [weak task] in
            task?.cancel()
        }
    }
    
    private func setCompletionHandlerForTask(_ task: URLSessionDataTask,
                                             handler: @escaping DownloadCompletionHandler) {
        completionHandlerForTask[task] = handler
    }
}
extension PhotoDownloader: URLSessionTaskDelegate {
    
    public func urlSession(_ session: URLSession,
                           task: URLSessionTask,
                           didCompleteWithError error: Error?) {
        let data = dataForTask[task] ?? nil
        completionHandlerForTask[task]?(data as Data?, task.response, error as NSError?)
        completionHandlerForTask[task] = nil
    }
}

extension PhotoDownloader: URLSessionDataDelegate {
    
    public func urlSession(_ session: URLSession,
                           dataTask: URLSessionDataTask,
                           didReceive data: Data) {
        guard let mutableData = dataForTask[dataTask] else {
            dataForTask[dataTask] = NSMutableData(data: data)
            return
        }
        mutableData?.append(data)
    }
    
    public func urlSession(_ session: URLSession,
                           dataTask: URLSessionDataTask,
                           willCacheResponse proposedResponse: CachedURLResponse,
                           completionHandler: @escaping (CachedURLResponse?) -> Void) {
        switch proposedResponse.response {
        case let response as HTTPURLResponse:
            var headers = response.allHeaderFields as! [String: String]
            headers["Cache-Control"] = "max-age=\(maxCacheTime)"
            let modifiedResponse = HTTPURLResponse(url: response.url!,
                                                   statusCode: response.statusCode,
                                                   httpVersion: "HTTP/1.1",
                                                   headerFields: headers)
            let modifiedCachedResponse = CachedURLResponse(response: modifiedResponse!,
                                                           data: proposedResponse.data,
                                                           userInfo: proposedResponse.userInfo,
                                                           storagePolicy: proposedResponse.storagePolicy)
            completionHandler(modifiedCachedResponse)
        default:
            completionHandler(proposedResponse)
        }
    }
}

