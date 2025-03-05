//
//  TrailerController.swift
//  MovieApp
//
//  Created by Mikayil on 22.02.25.
//

import UIKit
import YouTubeiOSPlayerHelper

class TrailerController: UIViewController {
    
    var videoKey: String?
    
    private lazy var webView: YTPlayerView = {
        let v = YTPlayerView()
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
        loadVideo()
    }
    
    private func setupUI() {
        view.backgroundColor = .black
        view.addSubview(webView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            webView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            webView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            webView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            webView.heightAnchor.constraint(equalToConstant: 300)
        ])
    }
    
    private func loadVideo() {
        guard let videoKey = videoKey else {
            print("❌ Video açılmadı: videoKey = nil")
            return
        }
        print("✅ Video açılır: \(videoKey)")
        webView.load(withVideoId: videoKey)
    }
}

