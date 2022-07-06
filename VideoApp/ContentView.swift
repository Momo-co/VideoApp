//
//  ContentView.swift
//  VideoApp
//
//  Created by Suman Gurung on 06/07/2022.
//

import SwiftUI
import AVKit

struct ContentView: View {
    @StateObject private var videoVM = VideoViewModel(videoService: VideoService(), urlString: Localization.urlAPIString)
    @State private var isPresented = false
    
    var body: some View {
        List() {
            ForEach(videoVM.videos) { video in
                Button(video.name) {
                    isPresented.toggle()
                }.fullScreenCover(isPresented: $isPresented) {
                    let player = AVPlayer(url: URL(string: video.videoUrl)!)
                    VideoPlayer(player: player).onAppear() {
                        player.play()
                    }.onDisappear() {
                        player.pause()
                    }
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
