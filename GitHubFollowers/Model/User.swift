//
//  User.swift
//  GitHubFollowers
//
//  Created by Hakan Or on 13.03.2024.
//

import Foundation

struct User {
    var login: String
    var avatarUrl: String
    var name: String?
    var location: String?
    var bio: String?
    var publisRepos: Int
    var publicGists: Int
    var htmlUrl: String
    var following: Int
    var followers: Int
    var createdAt: String
}
