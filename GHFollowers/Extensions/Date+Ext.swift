//
//  Date+Ext.swift
//  GHFollowers
//
//  Created by Piyush Mandaliya on 2022-05-19.
//

import Foundation

extension Date {
    
    func convertToMonthYearFormat() -> String {
        return formatted(.dateTime.month().year())
    }
}
