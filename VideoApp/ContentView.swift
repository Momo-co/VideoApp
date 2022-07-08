//
//  ContentView.swift
//  VideoApp
//
//  Created by Suman Gurung on 06/07/2022.
//

import SwiftUI
import AVKit

struct ContentView: View {
    @StateObject private var videoVM = VideoViewModel(videoService: VideoService(), urlString: Localization.urlAPIString, player: AVPlayer())
    @State private var isPresented = false
    
    var body: some View {
        List() {
            ForEach(videoVM.videos) { video in
                Button(video.name) {
                    isPresented.toggle()
                }.fullScreenCover(isPresented: $isPresented) {
                    VideoPlayer(player: videoVM.addAVPlayer(urlString: video.videoUrl)).onDisappear() {
                        videoVM.pauseVideo()
                    }
                }
                VStack (alignment: .leading, spacing: 10) {
                    Text(video.id)
                    Text(video.location)
                }
            }
        }
        .onAppear(perform: videoVM.getVideoData)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
