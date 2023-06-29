//
//  NZPhotoServiceTest.swift
//  NZImageDemoTests
//
//  Created by Nilesh Zambre on 06/01/22.
//  Copyright © 2021 Nilesh Zambre. All rights reserved.
//

import XCTest
import Foundation
import CommonCode
@testable import ContactsDirectoryDemo
class NZPhotoServiceTest: XCTestCase {
    override func setUp() {
        AppSetting.shared.enviroment = .live
    }
    
    func testGetRecent(){
        let service = NZPhotoService.getRecent
        XCTAssertTrue(service.mockName == "/recentPhotos.json")
        XCTAssertTrue(service.host == "https://www.flickr.com/services/")
        XCTAssertTrue(service.path == "/rest")
        XCTAssertTrue(service.restMethod == "flickr.photos.getrecent")
        XCTAssertTrue(service.httpMethod == .get)
        let parameters = ["format": "json",
                          "nojsoncallback": "1",
                          "method": "flickr.photos.getrecent",
                          "api_key": "3aaeaf09d9e52f7176b08551731ad5b6"]
        XCTAssertTrue(service.parameters == parameters)
    }
    
    func testSearchPhotos(){
        let service = NZPhotoService.searchPhotos(text: "World")
        XCTAssertTrue(service.mockName == "/searchPhotos.json")
        XCTAssertTrue(service.host == "https://www.flickr.com/services/")
        XCTAssertTrue(service.path == "/rest")
        XCTAssertTrue(service.restMethod == "flickr.photos.search")
        XCTAssertTrue(service.httpMethod == .get)
        let parameters = ["text": "World",
                          "format": "json",
                          "nojsoncallback": "1",
                          "method": "flickr.photos.search",
                          "api_key": "3aaeaf09d9e52f7176b08551731ad5b6",
        ]
        XCTAssertTrue(service.parameters == parameters)
    }
}
