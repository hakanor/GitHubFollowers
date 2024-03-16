//
//  GetFollowers.swift
//  GitHubFollowers
//
//  Created by Hakan Or on 16.03.2024.
//

struct GetFollowersRequest: Requestable {
    typealias Response = [Follower]
    
    var path: String {
        return "/users/\(username)/followers"
    }
    
    let method: HTTPMethod = .get
    
    var queryParameters: [String: String] {
        return ["per_page": "100", "page": "\(page)"]
    }
    
    let username: String
    let page: Int
    
    init(username: String, page: Int) {
        self.username = username
        self.page = page
    }
}
