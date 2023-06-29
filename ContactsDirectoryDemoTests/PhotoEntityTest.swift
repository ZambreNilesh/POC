//
//  PhotoEntityTest.swift
//  NZImageDemoTests
//
//  Created by Nilesh Zambre on 06/01/22.
//  Copyright © 2021 Nilesh Zambre. All rights reserved.
//

import XCTest
import Foundation
import CommonCode
@testable import ContactsDirectoryDemo
class PhotoEntityTest: XCTestCase {
    override func setUp() {  }
    
    func testPhotoEntity() {
        XCTAssertThrowsError(try createPhotoEntity().toDomainModel())
        XCTAssertThrowsError(try createPhotoEntity(id: "1234").toDomainModel())
        XCTAssertThrowsError(try createPhotoEntity(id: "1234", owner: "abc").toDomainModel())
        XCTAssertThrowsError(try createPhotoEntity(id: "1234", owner: "abc",
                                                   secret: "xyz").toDomainModel())
        XCTAssertThrowsError(try createPhotoEntity(id: "1234", owner: "abc",
                                                   secret: "xyz", server: "apple").toDomainModel())
        XCTAssertThrowsError(try createPhotoEntity(id: "1234", owner: "abc",
                                                   secret: "xyz", server: "apple",
                                                   farm: 1).toDomainModel())
        XCTAssertNoThrow(try createPhotoEntity(id: "1234", owner: "abc",
                                               secret: "xyz", server: "apple",
                                               farm: 1, title: "myImage").toDomainModel())
        XCTAssertNoThrow(try createPhotoEntity(id: "1234", owner: "abc",
                                               secret: "xyz", server: "apple",
                                               farm: 1, title: "myImage",
                                               ispublic: 1, isfriend: 1,
                                               isfamily: 1).toDomainModel())
    }
    
    private func createPhotoEntity(id: String? = nil,
                                   owner: String? = nil,
                                   secret: String? = nil,
                                   server: String? = nil,
                                   farm: Int? = nil,
                                   title: String? = nil,
                                   ispublic: Int? = nil,
                                   isfriend: Int? = nil,
                                   isfamily: Int? = nil) -> PhotoEntity {
        return PhotoEntity(id: id,
                           owner: owner,
                           secret: secret,
                           server: server,
                           farm: farm,
                           title: title,
                           ispublic: ispublic,
                           isfriend: isfriend, isfamily: isfamily)
        
        
        
    }
}


