//
//  VideoViewModel.swift
//  VideoApp
//
//  Created by Suman Gurung on 06/07/2022.
//

import Foundation

class VideoViewModel: ObservableObject {
    
    @Published var videos = [VideoModel]()
    @Published var buttonPressed: Bool = false
    
    private let videoService: VideoServicing
    private let urlString: String
    
    init(videoService: VideoServicing, urlString: String) {
        self.videoService = videoService
        self.urlString = urlString
    }
    
    func getVideoData() {
        videoService.getVideoData(urlString: urlString, type: VideoModel.self) { [weak self] result in
            switch result {
            case .success(let videos):
                DispatchQueue.main.async {
                    self?.videos = videos
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self?.videos = []
                }
                print(error)
            }
        }
    }
}
