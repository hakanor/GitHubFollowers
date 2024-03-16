//
//  Requestable.swift
//  GitHubFollowers
//
//  Created by Hakan Or on 16.03.2024.
//

protocol Requestable {
    associatedtype Response: Codable // İstekten dönecek cevap türü
    
    var scheme: String { get }
    var host: String { get }
    var path: String { get }
    
    var method: HTTPMethod { get } // HTTP methodu
    
    var queryParameters: [String: String] { get }
    var bodyParameters: Encodable? { get }
}

extension Requestable {
    var scheme: String {
        "https"
    }
    
    var host: String {
        "api.github.com"
    }
    
    var queryParameters: [String: String] {
        [:]
    }
    
    var bodyParameters: Encodable? {
        nil
    }
}
