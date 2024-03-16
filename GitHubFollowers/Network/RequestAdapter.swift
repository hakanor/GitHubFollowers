//
//  RequestAdapter.swift
//  GitHubFollowers
//
//  Created by Hakan Or on 16.03.2024.
//

import Foundation

final class RequestAdapter {
    func adapt<T: Requestable>(_ request: T) throws -> URLRequest {
        var urlComponents = URLComponents()

        urlComponents.scheme = request.scheme
        urlComponents.host = request.host
        urlComponents.path = request.path

        if !request.queryParameters.isEmpty {
            urlComponents.queryItems = request.queryParameters.map { URLQueryItem(name: $0, value: $1) }
        }

        guard let url = urlComponents.url else {
            throw NetworkError.invalidURL
        }
        
        var urlRequest = URLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 60.0)
        urlRequest.httpMethod = request.method.rawValue
        urlRequest.allHTTPHeaderFields = [:]

        if let bodyParameters = request.bodyParameters,
           let encodedBodyParameters = try? JSONEncoder().encode(bodyParameters) {
            urlRequest.httpBody = encodedBodyParameters
        }

        return urlRequest
    }
}
