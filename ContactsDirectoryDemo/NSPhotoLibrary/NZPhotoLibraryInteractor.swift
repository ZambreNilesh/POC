//
//  NZPhotoLibrarynteractor.swift
//  NZImageDemo
//
//  Created by Nilesh Zambre on 23/12/21.
//  Copyright © 2021 Nilesh Zambre. All rights reserved.
//
import Downloader
import CommonCode
import Foundation

class NZPhotoLibraryInteractor: NZPhotoLibraryInteractorContract {
    weak var presenter: NZPhotoLibraryInteractorToPresenterContract?
    
    func loadRecentPhotos() {
     CacheHandler.sharedHandler.setupCache(memoryInMB: 100, diskCapacityInMB: 100)
        presenter?.startLoading()
        let serviceProvider = ServiceProvider<NZPhotoService>(service: .getRecent)
        serviceProvider.response { [weak self] (data, error) in
            guard let self = self else { return }
            self.presenter?.stopLoading()
            do {
                if let error = error {
                    self.presenter?.presentError(error: error)
                } else if let data = data {
                    let response = try JSONDecoder()
                        .decode(PhotoResponseEntity.self, from: data).toDomainModel()
                    self.presenter?.presentPhotos(photos: response.photos.photo)
                } else {
                    self.presenter?
                        .presentError(error: NZPhotoError.parseError((URLError(.badServerResponse))))
                }
            }
            catch {
                self.presenter?.presentError(error: NZPhotoError.parseError(error))
            }
        }
    }
    
    func searchPhoto(with text: String) {
        presenter?.startLoading()
        let serviceProvider = ServiceProvider<NZPhotoService>(service: .searchPhotos(text: text))
        serviceProvider.response { [weak self] (data, error) in
            guard let self = self else { return }
            self.presenter?.stopLoading()
            do {
                if let error = error {
                    self.presenter?.presentError(error: error)
                } else if let data = data {
                    let response = try JSONDecoder()
                        .decode(PhotoResponseEntity.self, from: data).toDomainModel()
                    self.presenter?.presentPhotos(photos: response.photos.photo)
                } else {
                    self.presenter?
                        .presentError(error: NZPhotoError.parseError((URLError(.badServerResponse))))
                }
            }
            catch {
                self.presenter?.presentError(error: NZPhotoError.parseError(error))
            }
        }
    }
    
}
