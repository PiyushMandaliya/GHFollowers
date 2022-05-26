//
//  GFAvatarImageView.swift
//  GHFollowers
//
//  Created by Piyush Mandaliya on 2022-05-11.
//

import UIKit

class GFAvatarImageView: UIImageView {

    let placeholderImage    = Images.placeHolder
    let cache               = NetworkManager.shared.cache
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        layer.cornerRadius      = 10
        clipsToBounds           = true
        image                   = placeholderImage
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    func downloadImage(fromURL urlString: String) {
        Task {
            image = await NetworkManager.shared.downloadImage(from: urlString) ?? placeholderImage
        }
    }
}
