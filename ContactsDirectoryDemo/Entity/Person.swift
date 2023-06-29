//
//  People.swift
//  NZImageDemo
//
//  Created by Zambre Nilesh Appasaheb on 24/06/23.
//
import CommonCode
struct PersonEntity: DataEntity {
    
    let createdAt: String?
    let avatar: String?
    let firstName: String?
    let lastName: String?
    let email: String?
    let jobtitle: String?
    let favouriteColor: String?
    let id: String?
    
    func toDomainModel() throws -> PersonModel{
        return PersonModel(createdAt: createdAt,
                           avatar: avatar,
                           firstName: firstName,
                           lastName: lastName,
                           email: email,
                           jobtitle: jobtitle,
                           favouriteColor: favouriteColor,
                           id: id);
    }

}
