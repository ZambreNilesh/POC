//
//  NZPhotoLibraryConfiguartator.swift
//  NZImageDemo
//
//  Created by Nilesh Zambre on 23/12/21.
//  Copyright © 2021 Nilesh Zambre. All rights reserved.
//

import UIKit
struct NZPhotoLibraryConfiguarator: NZPhotoLibraryConfiguratorContract {
    func configure(configuration: NZPhotoLibraryConfigurationContract) -> UIViewController {
        let viewController = NZPhotoLibraryViewController.instantiate()
        let presenter = NZPhotoLibraryPresenter()
        let interactor = NZPhotoLibraryInteractor()
        let router = NZPhotoLibraryRouter()
        let mapper = NZPhotoLibraryMapper()
        
        // VC -> PR -> IN -> PR -> VC
        
        viewController.presenter = presenter
        presenter.router = router
        presenter.interactor = interactor
        interactor.presenter = presenter
        presenter.viewController = viewController
        presenter.mapper = mapper
        return viewController
    }
}
