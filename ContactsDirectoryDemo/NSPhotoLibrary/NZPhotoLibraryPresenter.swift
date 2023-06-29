//
//  NZPhotoLibraryPresenter.swift
//  NZImageDemo
//
//  Created by Nilesh Zambre on 23/12/21.
//  Copyright © 2021 Nilesh Zambre. All rights reserved.
//

import UIKit
import CommonCode

class NZPhotoLibraryPresenter {
    var router: NZPhotoLibraryRouterContract?
    var mapper: NZPhotoLibraryMapperContract?
    var interactor: NZPhotoLibraryInteractorContract?
    weak var viewController: NZPhotoLibraryViewControllerContract?
}

//Ask presenter to fetch data from interactor
extension NZPhotoLibraryPresenter: NZPhotoLibraryViewControllerToPresenterContract {
    func loadRecentPhotos() {
        interactor?.loadRecentPhotos()
    }
    
    func searchPhoto(with text: String) {
        interactor?.searchPhoto(with: text)
    }
}

//Display data on viewcontroller
extension NZPhotoLibraryPresenter: NZPhotoLibraryInteractorToPresenterContract {
    func presentError(error: NZPhotoError) {
        let error = parseError(error: error)
        viewController?.displayError(title: error.title, message: error.message)
    }
    
    func presentPhotos(photos: [PhotoModel]) {
        viewController?.displayPhotos(photos: mapper?.mapToViewModel(models: photos) ?? [])
    }
    
    func startLoading() {
        viewController?.startLoading()
    }
    
    func stopLoading() {
        viewController?.stopLoading()
    }
}
