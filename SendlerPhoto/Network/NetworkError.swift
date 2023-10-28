//
//  NetworkError.swift
//  SendlerPhoto
//
//  Created by Vlad Kugan on 28.10.23.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case noData
    case invalidResponse
    case imageConversionFailed
    case invalidResponseCode
}
