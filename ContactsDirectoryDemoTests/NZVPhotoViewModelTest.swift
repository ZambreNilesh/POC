//
//  NZVPhotoViewModelTest.swift
//  NZImageDemoTests
//
//  Created by Nilesh Zambre on 06/01/22.
//  Copyright © 2021 Nilesh Zambre. All rights reserved.
//

import XCTest
import Foundation
import CommonCode
@testable import ContactsDirectoryDemo
class NZVPhotoViewModelTest: XCTestCase {
    var nzvPhotViewModel: NZVPhotoViewModel!
    override func setUp() {
        
        nzvPhotViewModel = NZVPhotoViewModel()
    }
    func testLoadRecentPhotos() {
        AppSetting.shared.enviroment = .mock
        let expectation = XCTestExpectation(description: "load recent photos")
        nzvPhotViewModel.successResponse = { [weak self] in
            guard let self = self else { return }
            XCTAssertNotNil(self.nzvPhotViewModel.photos)
            expectation.fulfill()
        }
        nzvPhotViewModel.failureResponse = {
            XCTFail("Photos did not load error")
            expectation.fulfill()
        }
        nzvPhotViewModel.loadRecentPhotos()
        wait(for: [expectation], timeout: 10)
    }
    func testLoadSearchPhotos() {
        AppSetting.shared.enviroment = .mock
        let expectation = XCTestExpectation(description: "load recent photos")
        nzvPhotViewModel.successResponse = { [weak self] in
            guard let self = self else { return }
            XCTAssertNotNil(self.nzvPhotViewModel.photos)
            expectation.fulfill()
        }
        nzvPhotViewModel.failureResponse = {
            XCTFail("Photos did not load error")
            expectation.fulfill()
        }
        nzvPhotViewModel.searchPhoto(with: "World")
        wait(for: [expectation], timeout: 10)
    }
    func testLoadSearchPhotosFailure() {
        AppSetting.shared.enviroment = .failureMock
        let expectation = XCTestExpectation(description: "load recent photos")
        nzvPhotViewModel.successResponse = {
            XCTFail("Photos did not load error")
            expectation.fulfill()
        }
        nzvPhotViewModel.failureResponse = { [weak self] in
            guard let self = self else { return }
            XCTAssertNotNil(self.nzvPhotViewModel.photoError)
            expectation.fulfill()
        }
        nzvPhotViewModel.searchPhoto(with: "World")
        wait(for: [expectation], timeout: 10)
    }
    func testLoadRecentPhotosFailure() {
        AppSetting.shared.enviroment = .failureMock
        let expectation = XCTestExpectation(description: "load recent photos")
        nzvPhotViewModel.successResponse = {
            XCTFail("Photos did not load error")
            expectation.fulfill()
        }
        nzvPhotViewModel.failureResponse = { [weak self] in
            guard let self = self else { return }
            XCTAssertNotNil(self.nzvPhotViewModel.photoError)
            expectation.fulfill()
        }
        nzvPhotViewModel.loadRecentPhotos()
        wait(for: [expectation], timeout: 10)
    }
}
