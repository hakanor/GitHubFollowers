//
//  NetworkProvider.swift
//  GitHubFollowers
//
//  Created by Hakan Or on 15.03.2024.
//

import Foundation

final class NetworkProvider: NetworkProvidable {
    
    static let shared = NetworkProvider()
    
    private let session: URLSession
    private let requestAdapter: RequestAdapter
    
    init(session: URLSession = .shared , requestAdapter: RequestAdapter = RequestAdapter()) {
        self.session = session
        self.requestAdapter = requestAdapter
    }
    
    func execute<T: Requestable>(_ request: T) async throws -> T.Response  {
        
        #warning("invalidResponse")
        let urlRequest = try RequestAdapter().adapt(request)
        
        let (data, response) = try await session.data(for: urlRequest)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw NetworkError.invalidResponse
        }
        
        let result = try await handleResponse(T.Response.self, data: data)
        
        return result
        
    }
    
    func handleResponse<T:Codable>(_ type: T.Type, data: Data) async throws -> T {
        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let result = try decoder.decode(T.self, from: data)
            return result
        } catch {
            throw NetworkError.invalidData
        }
    }
    
    func fetch(_ url: String) async throws -> Data {
        
        guard let url = URL(string: url) else { throw NetworkError.invalidURL }
        let (data, response) = try await session.data(from: url)
                
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw NetworkError.invalidResponse
        }
        
        return data
    }
}



