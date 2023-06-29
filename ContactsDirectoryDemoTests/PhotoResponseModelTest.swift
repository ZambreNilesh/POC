//
//  PhotoResponseModelTest.swift
//  NZImageDemoTests
//
//  Created by Nilesh Zambre on 06/01/22.
//  Copyright © 2021 Nilesh Zambre. All rights reserved.
//

import XCTest
import Foundation
import CommonCode
@testable import ContactsDirectoryDemo
class PhotoResponseModelTest: XCTestCase {
    override func setUp() {  }
    
    func testPhotoResponseModel() {
        let photoModel1 =  PhotoModel(id: "987643", owner: "lmn",
                                      secret: "1nr4", server: "google",
                                      farm: 1, title: "demo image",
                                      isPublic: true, isFriend: true,
                                      isFamily: true)
        let photoModel2 =  PhotoModel(id: "1234", owner: "abc",
                                      secret: "xyz", server: "apple",
                                      farm: 1, title: "myImage",
                                      isPublic: true, isFriend: true,
                                      isFamily: true)
        let photoPageModel1 =  PhotoPageModel(page: 1, pages: 10,
                                              perpage: 5, photo: [photoModel1])
        let photoPageModel2 = PhotoPageModel(page: 2, pages: 20,
                                             perpage: 5, photo: [photoModel2])
        
        let firstModel =  createPhotoResponseModel(photos: photoPageModel1, stat: "123")
        let secondModel =  createPhotoResponseModel(photos: photoPageModel2, stat: "987")
        let thirdModel =  createPhotoResponseModel(photos: photoPageModel1, stat: "123")
        
        XCTAssertFalse(firstModel == secondModel)
        XCTAssertTrue(firstModel == thirdModel)
        XCTAssertFalse(secondModel == thirdModel)
    }
    
    private func createPhotoResponseModel(photos: PhotoPageModel,
                                          stat: String) -> PhotoResponseModel{
        return  PhotoResponseModel(photos: photos, stat: stat)
    }
}
