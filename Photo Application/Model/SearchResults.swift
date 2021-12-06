//
//  SearchResults.swift
//  Photo Application
//
//  Created by Alexander Kovzhut on 07.12.2021.
//

struct SearchResults: Decodable {
    let total: Int
    let results: [UnsplashPhoto]
}

struct UnsplashPhoto: Decodable {
    let height: Int
    let width: Int
    let urls: [URLKing.RawValue: String]
    
    enum URLKing: String {
        case raw
        case full
        case regular
        case small
        case thumb
    }
}
