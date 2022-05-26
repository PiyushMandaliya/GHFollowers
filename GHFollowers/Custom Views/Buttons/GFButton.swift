//
//  GFButton.swift
//  GHFollowers
//
//  Created by Piyush Mandaliya on 2022-05-05.
//

import UIKit

class GFButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(backgroundColor: UIColor, title: String, image: UIImage) {
        self.init(frame: .zero)
        set(color: backgroundColor, title: title, image: image)
    }
    
    private func configure() {
        configuration               = .tinted()
        configuration?.cornerStyle  =   .medium
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    func set(color: UIColor, title: String, image: UIImage) {
        configuration?.baseBackgroundColor  = color
        configuration?.baseForegroundColor  = color
        configuration?.title                = title
        
        configuration?.image                = image
        configuration?.imagePadding         = 6
        configuration?.imagePlacement       = .leading
    }
}
