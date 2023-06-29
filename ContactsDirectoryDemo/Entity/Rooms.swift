//
//  People.swift
//  NZImageDemo
//
//  Created by Zambre Nilesh Appasaheb on 24/06/23.
//
import CommonCode
struct RoomEntity: DataEntity {
    let id: String
    let createdAt: String
    let maxOccupancy: Int
    let isOccupied: Bool
    
    func toDomainModel() throws -> RoomModel{
        return RoomModel(id: id, createdAt: createdAt,  maxOccupancy: maxOccupancy, isOccupied: isOccupied);
    }

}
