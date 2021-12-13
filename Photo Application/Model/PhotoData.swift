//
//  PhotoData.swift
//  Photo Application
//
//  Created by Alexander Kovzhut on 13.12.2021.
//

struct PhotoData: Decodable {
    let id: String
    let width: Int
    let height: Int
    let created_at: String
    let downloads: Int
    let likes: Int
    let views: Int
    let description: String
    let urls: URLS
    let exif: Exif
    let location: Location
    let user: User
}

struct Exif: Decodable {
    let model: String
}

struct Location: Decodable {
    let name: String
}

struct User: Decodable {
    let name: String
}

struct URLS: Decodable {
    let raw: String
    let full: String
    let regular: String
    let small: String
    let thumb: String
}
