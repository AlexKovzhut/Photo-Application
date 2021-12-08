//
//  NetworkService.swift
//  Photo Application
//
//  Created by Alexander Kovzhut on 07.12.2021.
//

import Foundation

class NetworkService {
    func request(searchTerm: String, complition: @escaping (Data?, Error?) -> Void) {
        let parameters = self.prepareParameters(searchTerm: searchTerm)
        let url = self.url(parameterts: parameters)
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = prepareHeader()
        request.httpMethod = "get"
        let task = createDataTask(from: request, complition: complition)
        task.resume()
    }
    
    private func prepareHeader() -> [String: String]? {
        var headers = [String: String]()
        headers["Authorization"] = "Client-ID J0s-ScBgmK8nGW77vjGxL1ETMGJyVWC3FmQcXdd3X1w" //Secret key
        headers["Authorization"] = "Client-ID F8qFf42dxGvig_oG30JrkfG9XqFct5qeAm6Nvv_D6KY" //Access Key
        
        return headers
    }
    
    private func prepareParameters(searchTerm: String?) -> [String: String] {
        var parameters = [String: String]()
        parameters["query"] = searchTerm
        parameters["page"] = String(1)
        parameters["per_page"] = String(15)
        
        return parameters
    }
    
    private func url(parameterts: [String: String]) -> URL {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.unsplash.com"
        components.path = "/search/photos"
        components.queryItems = parameterts.map { URLQueryItem(name: $0, value: $1)}
        
        return components.url!
    }
    
    private func createDataTask(from request: URLRequest, complition: @escaping (Data?, Error?) -> Void) -> URLSessionDataTask {
        return URLSession.shared.dataTask(with: request) { data, responce, error in
            DispatchQueue.main.async {
                complition(data, error)
            }
        }
    }
}
