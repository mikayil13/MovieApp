//
//  Image.swift
//  MovieApp
//
//  Created by Mikayil on 23.02.25.
//

import Foundation
import UIKit
import Kingfisher

extension UIImageView {
    func loadImage(url: String) {
        let fullPath = NetworkingHelper.shared.imageBaseURL + url
        guard let url = URL(string: fullPath) else { return }
        self.kf.setImage(with: url)
    }
}

