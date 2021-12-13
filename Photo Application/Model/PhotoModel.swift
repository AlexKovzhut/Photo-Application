//
//  PhotoModel.swift
//  Photo Application
//
//  Created by Alexander Kovzhut on 13.12.2021.
//

struct PhotoModel {
    let photoID: String
    let photowWidth: Int
    let photoHeight: Int
    let dateOfCreation: String
    let numbersOfDownloads: Int
    let numbersOfLikes: Int
    let numberOfViews: Int
    let descriptionForPhoto: String
    let url: String
    let photographedOn: String
    let photographedPlace: String
    let author: String
    
    var numbersOfDownloadsString: String {
        return String(numbersOfDownloads)
    }
    
    var numbersOfLikesString: String {
        return String(numbersOfLikes)
    }
}

