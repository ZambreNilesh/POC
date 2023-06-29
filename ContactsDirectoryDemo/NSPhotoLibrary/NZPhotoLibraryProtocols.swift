//
//  NZPhotoLibraryProtocols.swift
//  NZImageDemo
//
//  Created by Nilesh Zambre on 23/12/22.
//  Copyright © 2021 Nilesh Zambre. All rights reserved.
//
import UIKit
import CommonCode


// VIPER

// VC -> PR -> IN -> PR -> VC

//            Service
//Presenter Protocols
protocol NZPhotoLibraryViewControllerToPresenterContract:  AnyObject {
    var interactor: NZPhotoLibraryInteractorContract? { get }
    func loadRecentPhotos()
    func searchPhoto(with text: String)
}

protocol NZPhotoLibraryInteractorToPresenterContract: AnyObject, InteractorToPresenterContract {
    var viewController: NZPhotoLibraryViewControllerContract? { get }
    func presentError(error: NZPhotoError)
    func presentPhotos(photos: [PhotoModel])
}

//Interactor Protocols
protocol NZPhotoLibraryInteractorContract:  AnyObject {
    var presenter: NZPhotoLibraryInteractorToPresenterContract? { get }
    func loadRecentPhotos()
    func searchPhoto(with text: String)
}

//Mapper Protocols
protocol NZPhotoLibraryMapperContract {
    func mapToViewModel(models: [PhotoModel]) -> [PhotoViewModel]
}

//Viewcontroller protocols
protocol NZPhotoLibraryViewControllerContract: AnyObject, PresenterToViewControllerContract{
    var presenter: NZPhotoLibraryViewControllerToPresenterContract? { get }
    func displayPhotos(photos: [PhotoViewModel])
}

//Configuration Protocol
protocol NZPhotoLibraryConfigurationContract { }

//Router Protocol
protocol NZPhotoLibraryRouterContract {
    func popView()
}

//Configurator Protocols
protocol NZPhotoLibraryConfiguratorContract {
    func configure(configuration: NZPhotoLibraryConfigurationContract) -> UIViewController
}

typealias NZPhotoLibraryPresenterContract
    = NZPhotoLibraryViewControllerToPresenterContract & NZPhotoLibraryInteractorToPresenterContract
