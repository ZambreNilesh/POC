//
//  PhotoModel.swift
//  NZImageDemo
//
//  Created by Nilesh Zambre on 24/12/22.
//  Copyright © 2021 Nilesh Zambre. All rights reserved.
//
//
//  People.swift
//  NZImageDemo
//
//  Created by Zambre Nilesh Appasaheb on 24/06/23.
//
import CommonCode
struct PersonModel: DomainModel {
    let createdAt: String?
    let avatar: String?
    let firstName: String?
    let lastName: String?
    let email: String?
    let jobtitle: String?
    let favouriteColor: String?
    let id: String?
    
    static func == (lhs: PersonModel, rhs: PersonModel) -> Bool {
        return lhs.id == rhs.id &&
            lhs.createdAt == rhs.createdAt &&
            lhs.avatar == rhs.avatar &&
            lhs.firstName == rhs.firstName &&
            lhs.lastName == rhs.lastName &&
            lhs.email == rhs.email &&
            lhs.jobtitle == rhs.jobtitle &&
        lhs.favouriteColor == rhs.favouriteColor;
    }

}
