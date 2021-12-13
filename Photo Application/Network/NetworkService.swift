//
//  NetworkService.swift
//  Photo Application
//
//  Created by Alexander Kovzhut on 13.12.2021.
//
//https://api.unsplash.com/photos/random?client_id=F8qFf42dxGvig_oG30JrkfG9XqFct5qeAm6Nvv_D6KY
//https://api.unsplash.com/search/photos?page=1&query=office&client_id=F8qFf42dxGvig_oG30JrkfG9XqFct5qeAm6Nvv_D6KY

import Foundation

enum ServiceError: Error {
    case network(statusCode: Int)
    case parsing
    case general(reason: String)
}

protocol PhotoServiceDelegate: AnyObject {
    func didFetchModel(_ service: NetworkService, _ model: PhotoModel)
    func didFailWithError(_ service: NetworkService, _ error: ServiceError)
}

class NetworkService {
    var delegate: PhotoServiceDelegate?
    
    let urlString = "https://api.unsplash.com/photos/random?client_id=F8qFf42dxGvig_oG30JrkfG9XqFct5qeAm6Nvv_D6KY"

    func fetchPhotos() {
        let urlString = "\(urlString)"
        performRequest(with: urlString)
        print(urlString)
    }
    
    func performRequest(with urlString: String) {
        let url = URL(string: urlString)!
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) {data, responce, error in
            guard let unwrapedData = data, let httpResponce = responce as? HTTPURLResponse else {
                    return
                }
                
            guard error == nil else {
                    DispatchQueue.main.async {
                        let generalError = ServiceError.general(reason: "Check network availability")
                        self.delegate?.didFailWithError(self, generalError)
                    }
                    return
                }
                
            guard (200...299).contains(httpResponce.statusCode) else {
                    DispatchQueue.main.async {
                        self.delegate?.didFailWithError(self, ServiceError.network(statusCode: httpResponce.statusCode))
                    }
                    return
                }

            guard let photo = self.parseJSON(unwrapedData) else { return }

                DispatchQueue.main.async {
                    self.delegate?.didFetchModel(self, photo)
                }
            }
        task.resume()
    }
    
    private func parseJSON(_ photoData: Data) -> PhotoModel? {
            guard let decodedData = try? JSONDecoder().decode(PhotoData.self, from: photoData) else {
                DispatchQueue.main.async {
                    self.delegate?.didFailWithError(self, ServiceError.parsing)
                }
                return nil
            }
        
        let photoID = decodedData.id
        let photowWidth = decodedData.width
        let photoHeight = decodedData.height
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
                photowWidth: photowWidth,
                photoHeight: photoHeight,
                dateOfCreation: dateOfCreation,
                numbersOfDownloads: numbersOfDownloads,
                numbersOfLikes: numbersOfLikes,
                numberOfViews: numberOfViews,
                descriptionForPhoto: descriptionForPhoto,
                url: url,
                photographedOn: photographedOn,
                photographedPlace: photographedPlace,
                author: author
            )

            return photo
        }
    
}

