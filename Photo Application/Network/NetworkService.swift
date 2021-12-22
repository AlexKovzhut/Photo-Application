//
//  NetworkService.swift
//  Photo Application
//
//  Created by Alexander Kovzhut on 13.12.2021.
//

import UIKit
import SDWebImage

enum ServiceError: Error {
    case networkError(URLResponse?)
    case parsingError
}

fileprivate struct APIResponce: Codable {
    let results: [PhotoData]
}

class NetworkService {
    static let shared = NetworkService()
    
    private var imageCache = NSCache<NSString, UIImage>()
    private let accessKey = "F8qFf42dxGvig_oG30JrkfG9XqFct5qeAm6Nvv_D6KY" //ACCESS KEY FOR API REQUEST
    
    private func components() -> URLComponents {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.unsplash.com"
        
        return components
    }
    
    private func request(url: URL) -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("Client-ID \(accessKey)", forHTTPHeaderField: "Authorization")
        
        return request
    }
    
    func fetchPhotos(query: String, complition: @escaping ([PhotoData]?, Error?) -> (Void)) {
        var components = components()
        components.path = "/search/photos"
        components.queryItems = [
            URLQueryItem(name: "query", value: query)
        ]
        
        let request = request(url: components.url!)
        
        let task = URLSession.shared.dataTask(with: request) { data, responce, error in
            if let error = error {
                complition(nil, error)
                return
            }
            
            guard let httpResponce = responce as? HTTPURLResponse,
                  (200...299).contains(httpResponce.statusCode) else {
                      complition(nil, ServiceError.networkError(responce))
                      return
                  }
            
            guard let data = data else {
                complition(nil, ServiceError.parsingError)
                return
            }

            
            do {
                let responce = try JSONDecoder().decode(APIResponce.self, from: data)
                complition(responce.results, nil)
            } catch let error {
                complition(nil, error)
            }
        }
        task.resume()
    }
    
    func image(photo: PhotoData, complition: @escaping (Data?, Error?) -> (Void)) {
        
        let session = URLSession(configuration: .default)
        let task = session.downloadTask(with: URL(string: photo.urls.regular)!) { localURL, responce, error in
            if let error = error {
                complition(nil, error)
                return
            }
            
            guard let httpResponce = responce as? HTTPURLResponse,
                  (200...299).contains(httpResponce.statusCode) else {
                      complition(nil, ServiceError.networkError(responce))
                      return
                  }
            
            guard let localURL = localURL else {
                complition(nil, ServiceError.parsingError)
                return
            }
            
            do {
                let data = try Data(contentsOf: localURL)
                complition(data, nil)
            } catch let error {
                complition(nil, error)
            }
        }
        task.resume()
    }
    
    func downloadImage(url: URL, completion: @escaping(UIImage?) -> Void) {
        if let cachedImage = imageCache.object(forKey: url.absoluteString as NSString) {
            completion(cachedImage)
        } else {
            let request = URLRequest(
                url: url,
                cachePolicy: URLRequest.CachePolicy.returnCacheDataElseLoad,
                timeoutInterval: 10
            )
            let dataTask = URLSession.shared.dataTask(with: request) { data, _, _ in
                guard let image = UIImage(data: data!) else { return }
                self.imageCache.setObject(image, forKey: url.absoluteString as NSString)
                
                DispatchQueue.main.async {
                    completion(image)
                }
            }
            dataTask.resume()
        }
    }
}

