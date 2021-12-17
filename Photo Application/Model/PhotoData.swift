//
//  PhotoData.swift
//  Photo Application
//
//  Created by Alexander Kovzhut on 13.12.2021.
//

import Foundation

struct PhotoData: Codable {
    let id: String
    let width: Int
    let height: Int
    let created_at: String
    let downloads: Int?
    let likes: Int?
    let views: Int?
    let description: String?
    let urls: URLS
    let exif: Exif?
    let location: Location?
    let user: User
}

struct Exif: Codable {
    let model: String
}

struct Location: Codable {
    let name: String
}

struct User: Codable {
    let name: String
}

struct URLS: Codable {
    let raw: String
    let full: String
    let regular: String
    let small: String
    let thumb: String
}
