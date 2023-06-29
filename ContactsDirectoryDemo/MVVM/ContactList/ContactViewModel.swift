//
//  NZVPhotoViewModel.swift
//  NZImageDemo
//
//  Created by Nilesh Zambre on 05/01/22.
//  Copyright © 2021 Nilesh Zambre. All rights reserved.
//

import Foundation
import Downloader
import CommonCode

class ContactViewModel: NSObject {
    var successResponse: (() -> ()) = {}
    var failureResponse: (() -> ()) = {}
    var startLoading: (() -> ()) = {}
    var stopLoading: (() -> ()) = {}
    private(set) var people: [PersonModel] = [] {
        didSet {
            self.successResponse()
        }
    }
    private(set) var peopleError: String? {
        didSet {
            self.failureResponse()
        }
    }
    
    func loadContacts() {
        CacheHandler.sharedHandler.setupCache(memoryInMB: 100, diskCapacityInMB: 100)
        startLoading()
        let serviceProvider = ServiceProvider<ContactService>(service: ContactService())
        serviceProvider.response { [weak self] (data, error) in
            guard let self = self else { return }
            self.stopLoading()
            do {
                if let error = error {
                    self.peopleError = self.getErrorString(error: error)
                } else if let data = data {
                    let persons = try JSONDecoder().decode([PersonEntity].self, from: data).toDomainModel()
                    self.people =  persons
                } else {
                    self.peopleError = self.getErrorString(error: APIError.parseError(URLError(.badServerResponse)))
                }
            }
            catch {
                self.peopleError =  self.getErrorString(error: APIError.parseError(error))
            }
        }
    }
    
    func getErrorString(error: APIError ) -> String {
        switch error {
        case let .parseError(error):
            return error.localizedDescription
        case let .urlSessionError(error):
            return error.localizedDescription
        case let .wrongStatusError(status: status):
            return "request failed with status \(status)"
        }
    }
}
