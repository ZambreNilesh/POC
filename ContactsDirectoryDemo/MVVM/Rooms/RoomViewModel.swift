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

class RoomViewModel: NSObject {
    var successResponse: (() -> ()) = {}
    var failureResponse: (() -> ()) = {}
    var startLoading: (() -> ()) = {}
    var stopLoading: (() -> ()) = {}
    private(set) var rooms: [RoomModel] = [] {
        didSet {
            self.successResponse()
        }
    }
    private(set) var roomsError: String? {
        didSet {
            self.failureResponse()
        }
    }
    
    func loadRooms() {
        CacheHandler.sharedHandler.setupCache(memoryInMB: 100, diskCapacityInMB: 100)
        startLoading()
        let serviceProvider = ServiceProvider<RoomService>(service: RoomService())
        
        serviceProvider.response { [weak self] (data, error) in
            guard let self = self else { return }
            self.stopLoading()
            do {
                if let error = error {
                    self.roomsError = self.getErrorString(error: error)
                } else if let data = data {
                    let rooms = try JSONDecoder().decode([RoomEntity].self, from: data).toDomainModel()
                    print("GOT RESPONSE \(rooms)");
                    self.rooms = rooms
                } else {
                    self.roomsError = self.getErrorString(error: APIError.parseError(URLError(.badServerResponse)))
                }
            }
            catch {
                self.roomsError =  self.getErrorString(error: APIError.parseError(error))
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
