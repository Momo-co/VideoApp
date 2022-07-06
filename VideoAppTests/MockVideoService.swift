//
//  MockVideoService.swift
//  VideoAppTests
//
//  Created by Suman Gurung on 06/07/2022.
//

import Foundation
@testable import VideoApp

class MockVideoService: VideoServicing {
    func getVideoData<A:Decodable>(urlString: String, type: A.Type,completion: @escaping (Result<[A], NetworkError>) -> ()) {
        if let url = Bundle(for: MockVideoService.self).url(forResource: urlString, withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode([A].self, from: data)
                completion(.success(jsonData))
            } catch {
                completion(.failure(NetworkError.parsingError(Localization.urlAPIString)))
            }
        }
    }
}
