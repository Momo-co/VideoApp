//
//  VideoViewModel.swift
//  VideoApp
//
//  Created by Suman Gurung on 06/07/2022.
//

import Foundation
import SwiftUI
import AVKit
import AVFoundation

class VideoViewModel: ObservableObject {
    
    @Published var videos = [VideoModel]()
    @Published var buttonPressed: Bool = false
    
    private let videoService: VideoServicing
    private let urlString: String
    private var player: AVPlayer
    
    init(videoService: VideoServicing, urlString: String, player: AVPlayer) {
        self.videoService = videoService
        self.urlString = urlString
        self.player = player
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
    
    func addAVPlayer(urlString: String) -> AVPlayer {
        guard let url = URL(string: urlString) else {
            return player
        }
        player = AVPlayer(url: url)
        return player
    }
}
