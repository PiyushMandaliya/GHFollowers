//
//  UIView+Ext.swift
//  GHFollowers
//
//  Created by Piyush Mandaliya on 2022-05-25.
//

import UIKit

extension UIView {
    
    func addSubviews(_ views: UIView...){
        for view in views {
            addSubview(view)
        }
    }
    
    func pintToEdges(for superView: UIView) {
        translatesAutoresizingMaskIntoConstraints   =   false
        
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: superView.topAnchor),
            leadingAnchor.constraint(equalTo: superView.leadingAnchor),
            trailingAnchor.constraint(equalTo: superView.trailingAnchor),
            bottomAnchor.constraint(equalTo: superView.bottomAnchor)
        ])
    }
}
