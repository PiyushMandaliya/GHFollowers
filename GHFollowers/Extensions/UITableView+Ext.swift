//
//  UITableView+Ext.swift
//  GHFollowers
//
//  Created by Piyush Mandaliya on 2022-05-25.
//

import UIKit

extension UITableView {
    
    func reloadDataOnMainThread() {
        DispatchQueue.main.async {
            self.reloadData()
        }
    }
    
    func removeExcessCells() {
        tableFooterView     = UIView(frame: .zero)
    }
}
