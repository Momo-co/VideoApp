//
//  VideoNameService.swift
//  VideoApp
//
//  Created by Suman Gurung on 06/07/2022.
//

import Foundation

enum NetworkError: Error, Equatable {
    case invalidUrl(String)
    case dataNotFound(String)
    case parsingError(String)
}

protocol VideoServicing {
    func getVideoData<A:Decodable>(urlString: String, type: A.Type,completion: @escaping (Result<[A], NetworkError>) -> ())
}

class VideoService: VideoServicing {
    func getVideoData<A:Decodable>(urlString: String, type: A.Type, completion: @escaping (Result<[A], NetworkError>) -> ()) {
        let urlSession = URLSession.shared
        
        guard let url = URL(string: urlString) else {
            completion(.failure(.invalidUrl(Localization.invalidURLMessage)))
            return
        }
        
        let dataTask = urlSession.dataTask(with: url) { data, urlResponse, error in
            guard let _data = data else {
                completion(.failure(.dataNotFound(Localization.dataNotFoundMessage)))
                return
            }
            
            let jsonDecoder = JSONDecoder()
            
            do {
                let videos = try jsonDecoder.decode([A].self, from: _data)
                completion(.success(videos))
            } catch {
                print(error)
                completion(.failure(.parsingError(Localization.parsingErrorMessage)))
            }
        }
        dataTask.resume()
    }
}
