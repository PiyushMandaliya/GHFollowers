//
//  GFError.swift
//  GHFollowers
//
//  Created by Piyush Mandaliya on 2022-05-17.
//

import Foundation

enum GFError: String, Error {
    
    case invalidURL = "Unable to complete your request. Please the URL."
    case invalidUsername    = "This is username created an invalid request. Please try again."
    case unableToComplete   = "Unable to complete your request. Please check your internet connection."
    case invalidResponse    = "Invalid response from the server. Please try again."
    case invalidData        = "The data receive from the server is invalid. Please try again"
    case unableToFavorite   = "There was a error favoriting this user. Please try again."
    case alreadyInFavorite  = "User already exist in you favorite list."
}
