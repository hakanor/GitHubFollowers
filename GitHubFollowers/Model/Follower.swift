//
//  Follower.swift
//  GitHubFollowers
//
//  Created by Hakan Or on 13.03.2024.
//

import Foundation

struct Follower: Codable, Hashable {
    var login: String
    var avatarUrl: String
}
