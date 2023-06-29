//
//  PhotoModelTest.swift
//  NZImageDemoTests
//
//  Created by Nilesh Zambre on 06/01/22.
//  Copyright © 2021 Nilesh Zambre. All rights reserved.
//

import XCTest
import Foundation
import CommonCode
@testable import ContactsDirectoryDemo
class PhotoModelTest: XCTestCase {
    override func setUp() {  }
    func testPhotoModel() {
        let firstModel =  createPhotoModel(id: "1234", owner: "abc",
                                           secret: "xyz", server: "apple",
                                           farm: 1, title: "myImage",
                                           ispublic: true, isfriend: true,
                                           isfamily: true)
        let secondModel =  createPhotoModel(id: "987643", owner: "lmn",
                                            secret: "1nr4", server: "google",
                                            farm: 1, title: "demo image",
                                            ispublic: true, isfriend: true,
                                            isfamily: true)
        let thirdModel =  createPhotoModel(id: "1234", owner: "abc",
                                           secret: "xyz", server: "apple",
                                           farm: 1, title: "myImage",
                                           ispublic: true, isfriend: true,
                                           isfamily: true)
        
        XCTAssertFalse(firstModel == secondModel)
        XCTAssertTrue(firstModel == thirdModel)
        XCTAssertFalse(secondModel == thirdModel)
    }
    
    private func createPhotoModel(id: String,
                                  owner: String,
                                  secret: String,
                                  server: String,
                                  farm: Int,
                                  title: String,
                                  ispublic: Bool,
                                  isfriend: Bool,
                                  isfamily: Bool) -> PhotoModel {
        return PhotoModel(id: id,
                          owner: owner,
                          secret: secret,
                          server: server,
                          farm: farm,
                          title: title,
                          isPublic: ispublic,
                          isFriend: isfriend, isFamily: isfamily)
        
    }
}


