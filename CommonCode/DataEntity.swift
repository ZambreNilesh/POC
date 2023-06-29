//
//  DataEntity.swift
//  NZImageDemo
//
//  Created by Nilesh Zambre on 24/12/22.
//  Copyright © 2021 Nilesh Zambre. All rights reserved.
//
import Foundation

public typealias DataEntity = Codable & DomainTransformable
public protocol DomainTransformable {
    associatedtype DomainModel
    func toDomainModel() throws -> DomainModel
}

public extension Array where Element: DomainTransformable {
    func toDomainModel() throws -> [Element.DomainModel] {
        try map {try $0.toDomainModel()}
    }
}
