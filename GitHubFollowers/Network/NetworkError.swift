//
//  NetworkError.swift
//  GitHubFollowers
//
//  Created by Hakan Or on 13.03.2024.
//

import Foundation

enum NetworkError: String, Error {
    case invalidUsername = "This username created an invalid request."
    case unableToComplete = "Unable to complete your request."
    case invalidResponse = "Invalid response from the server."
    case invalidData = "The data received from the server was invalid."
    case invalidURL = "Invalid url."
}
