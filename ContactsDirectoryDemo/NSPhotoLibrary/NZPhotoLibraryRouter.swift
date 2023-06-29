//
//  NZPhotoLibraryRouter.swift
//  NZImageDemo
//
//  Created by Nilesh Zambre on 23/12/21.
//  Copyright © 2021 Nilesh Zambre. All rights reserved.
//
import UIKit

class NZPhotoLibraryRouter: NZPhotoLibraryRouterContract {
    weak var currenctViewController: NZPhotoLibraryViewControllerContract?
    func popView() {
        guard let currenctViewController = currenctViewController as? UIViewController else {
            return
        }
        currenctViewController.navigationController?.popViewController(animated: true)
    }
}
