//
//  NZPhotoLibraryMapper.swift
//  NZImageDemo
//
//  Created by Nilesh Zambre on 23/12/21.
//  Copyright © 2021 Nilesh Zambre. All rights reserved.
//
import Foundation
class NZPhotoLibraryMapper: NZPhotoLibraryMapperContract {
    func mapToViewModel(models: [PhotoModel]) -> [PhotoViewModel] {
        return models.map { model -> PhotoViewModel in
            PhotoViewModel(title: model.title, imageUrl: model.imageUrl)
        }
    }
}
