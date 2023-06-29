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

class ContactService: BaseService{
    var mockName: String {
        return "recentPhotos"
    }
    var failureMock: String {
       return "/error.json"
    }
    
    var host: String {
        return "https://61e947967bc0550017bc61bf.mockapi.io/"
    }
    
    var path: String {
       return "api/v1/"
    }
    
    var restMethod: String {
        return  "people"
    }
    
    var httpMethod: HTTPMethod {
        return .get
    }
    var parameters: [String: String] {
        let params = ["method":restMethod]
        return params
    }
    
}
