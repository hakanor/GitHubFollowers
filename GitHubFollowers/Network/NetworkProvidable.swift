//
//  NetworkProvidable.swift
//  GitHubFollowers
//
//  Created by Hakan Or on 16.03.2024.
//

import Foundation

protocol NetworkProvidable {
    func execute<T: Requestable>(_ request: T) async throws -> T.Response
    func handleResponse<T:Codable>(_ type: T.Type, data: Data) async throws -> T
    func fetch(_ url: String) async throws -> Data
}
