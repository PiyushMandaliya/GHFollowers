//
//  User.swift
//  GHFollowers
//
//  Created by Piyush Mandaliya on 2022-05-06.
//

import Foundation


struct User: Codable {
    let login: String
    let avatarUrl: String
    var name: String?
    var location: String?
    var htmlUrl: String?
    var bio: String?
    let publicRepos: Int
    let publicGists: Int
    let followers: Int
    let following: Int
    let createdAt: Date
}
