//
//  NetworkService.swift
//  Photo Application
//
//  Created by Alexander Kovzhut on 13.12.2021.
//
//https://api.unsplash.com/photos/random?client_id=F8qFf42dxGvig_oG30JrkfG9XqFct5qeAm6Nvv_D6KY
//https://api.unsplash.com/search/photos?page=1&query=office&client_id=F8qFf42dxGvig_oG30JrkfG9XqFct5qeAm6Nvv_D6KY

import Foundation

class NetworkService {
    static let shared = NetworkService()
    
    let urlString = "https://api.unsplash.com/photos/random?client_id=F8qFf42dxGvig_oG30JrkfG9XqFct5qeAm6Nvv_D6KY"
    
    func fetchPhotos() {
        
    }
    
    private func parseJSON(_ photoData: Data) -> PhotoModel? {
        let decodedData = try! JSONDecoder().decode(PhotoData.self, from: photoData)

        let photoID = decodedData.id
        let dateOfCreation = decodedData.created_at
        let numbersOfDownloads = decodedData.downloads
        let numbersOfLikes = decodedData.likes
        let numberOfViews = decodedData.views
        let descriptionForPhoto = decodedData.description
        let url = decodedData.urls.full
        let photographedOn = decodedData.exif.model
        let photographedPlace = decodedData.location.name
        let author = decodedData.user.name

            let photo = PhotoModel(
                photoID: photoID,
                dateOfCreation: dateOfCreation,
                numbersOfDownloads: numbersOfDownloads,
                numbersOfLikes: numbersOfLikes,
                numberOfViews: numberOfViews,
                descriptionForPhoto: descriptionForPhoto ?? "One of the best moments",
                url: url,
                photographedOn: photographedOn ?? "Marvelous thing",
                photographedPlace: photographedPlace  ?? "Somewhere in universe",
                author: author
            )

            return photo
        }
}

