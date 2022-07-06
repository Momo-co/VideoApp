//
//  VideoModel.swift
//  VideoApp
//
//  Created by Suman Gurung on 06/07/2022.
//

import Foundation

struct VideoModel: Decodable, Identifiable {
    let id: String
    let name: String
    let location: String
    let videoUrl: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case location
        case videoUrl
    }
}
