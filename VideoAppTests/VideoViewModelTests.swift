//
//  VideoViewModelTests.swift
//  VideoAppTests
//
//  Created by Suman Gurung on 06/07/2022.
//

import XCTest
import Combine
@testable import VideoApp

class VideoViewModelTests: XCTestCase {
    
    var videoService: VideoServicing!
    var videoViewModel: VideoViewModel!
    var subscribers: Set<AnyCancellable>!

    override func setUpWithError() throws {
        videoService = MockVideoService()
        videoViewModel = VideoViewModel(videoService: videoService, urlString: "VideoStub")
        subscribers = Set<AnyCancellable>()
    }

    override func tearDownWithError() throws {
        videoService = nil
        videoViewModel = nil
        subscribers = nil
    }

    func testGetVideoData() throws {
        XCTAssertEqual(videoViewModel.videos.count, 0)
        var successVideos: [VideoModel] = []
        let expectation = XCTestExpectation(description: "Successfully Retrieved Videos")
        videoViewModel.$videos.dropFirst().sink { videos in
            successVideos = videos
            expectation.fulfill()
        }.store(in: &subscribers)
        videoViewModel.getVideoData()
        wait(for: [expectation], timeout: 4)
        XCTAssertEqual(successVideos.count, 4)
    }

}
