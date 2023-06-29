//
//  PhotoResponseEntityTest.swift
//  NZImageDemoTests
//
//  Created by Nilesh Zambre on 06/01/22.
//  Copyright © 2021 Nilesh Zambre. All rights reserved.
//

import XCTest
import Foundation
import CommonCode
@testable import ContactsDirectoryDemo
class PhotoResponseEntityTest: XCTestCase {
    override func setUp() {  }
    
    func testPhotoPageEntity() {
        XCTAssertThrowsError(try createPhotoResponseEntity().toDomainModel())
        let photoEnity = PhotoEntity(id: "1234", owner: "abc",
                                     secret: "xyz", server: "apple",
                                     farm: 1, title: "myImage",
                                     ispublic: 1, isfriend: 1,
                                     isfamily: 1)
        let photoPageEntity = PhotoPageEntity(page: 1, pages: 100,
                                              perpage: 10, photo: [photoEnity])
        XCTAssertThrowsError(try createPhotoResponseEntity(photos: photoPageEntity).toDomainModel())
        
        XCTAssertNoThrow(try createPhotoResponseEntity(photos: photoPageEntity,
                                                       stat: "100").toDomainModel())
    }
    
    private func createPhotoResponseEntity(photos: PhotoPageEntity? = nil,
                                           stat: String? = nil) -> PhotoResponseEntity {
        return PhotoResponseEntity(photos: photos, stat: stat)
    }
}
