//
//  NZPhotoService.swift
//  NZImageDemo
//
//  Created by Nilesh Zambre on 24/12/22.
//  Copyright © 2021 Nilesh Zambre. All rights reserved.
//
import Foundation
import Network
import CommonCode
class RoomService: BaseService{
    var mockName: String {
        return "searchPhotos"
    }
    var failureMock: String {
       return "/error.json"
    }
    
    var host: String {
        switch AppSetting.shared.enviroment {
        case .live:
            return "https://61e947967bc0550017bc61bf.mockapi.io/"
        case .mock, .failureMock:
            return Bundle.main.bundlePath
        }
    }
    
    var path: String {
        return "api/v1/"
    }
    
    var restMethod: String {
        return "rooms"
    }
    
    var httpMethod: HTTPMethod {
      return .get

    }
    var parameters: [String: String] {
        var params = ["method": restMethod]
        return params
    }
}
