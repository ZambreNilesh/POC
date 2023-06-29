//
//  PhotoModel.swift
//  NZImageDemo
//
//  Created by Nilesh Zambre on 24/12/22.
//  Copyright © 2021 Nilesh Zambre. All rights reserved.
//

struct RoomModel: DomainModel {
    let id: String
    let createdAt: String
    let maxOccupancy: Int
    let isOccupied: Bool
    init(id: String,
         createdAt: String,
         maxOccupancy: Int,
         isOccupied: Bool ) {
        self.id = id
        self.createdAt = createdAt
        self.maxOccupancy = maxOccupancy
        self.isOccupied = isOccupied
    }
    
    static func == (lhs: RoomModel, rhs: RoomModel) -> Bool {
        return lhs.id == rhs.id &&
            lhs.createdAt == rhs.createdAt &&
            lhs.maxOccupancy == rhs.maxOccupancy &&
            lhs.isOccupied == rhs.isOccupied
    }
}
