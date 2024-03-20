//
//  GetUser.swift
//  GitHubFollowers
//
//  Created by Hakan Or on 20.03.2024.
//

struct GetUserRequest: Requestable {
    typealias Response = User
    
    var path: String {
        return "/users/\(username)"
    }
    
    let method: HTTPMethod = .get
    
    let username: String
    
    init(username: String) {
        self.username = username
    }
}
