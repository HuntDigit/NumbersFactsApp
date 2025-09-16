//
//  NetworkService.swift
//  NumbersFactsApp
//
//  Created by Andrii Sabinin on 15.09.2025.
//

import Foundation

extension URLRequest {
    mutating func setHTTPMethod(_ method: HTTPMethod) {
        httpMethod = method.rawValue
    }
}

enum NetworkError: Error {
    case urlCreationFailed
    case badServerResponse
    // ...
}

enum RequestNumber {
    case number(Int64)
    case random
}

struct NetworkConfig {
    static let baseURL: String = "http://numbersapi.com/"
    static let timeout: TimeInterval = 30
    static let defaultHTTPHeaderFields = ["Content-Type": "application/json"]
    
    static func mathURL(request: RequestNumber) -> String {
        switch request {
        case let .number(value):
            return baseURL + "\(value)"
        case .random:
            return baseURL + "random/math"
        }
    }
}

enum HTTPMethod: String {
    case GET    = "GET"
    case POST   = "POST"
    
    // Just a sample for other methods
}

final class NetworkService {
    
    func fetchNumberMath(request: RequestNumber) async throws -> NumberDataModel {
        let endpoint = NetworkConfig.mathURL(request: request)
        guard let url = URL(string: endpoint) else {
            throw NetworkError.urlCreationFailed
        }
        
        let request = getRequestForURL(url)
        let (data, response) = try await URLSession.shared.data(for: request)
        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            throw NetworkError.badServerResponse
        }
        
        var model: NumberDataModel = try decodeData(data)
        model.id = UUID().uuidString
        return model
    }
    
    private func decodeData<T: Decodable>(_ data: Data) throws -> T {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return try decoder.decode(T.self, from: data)
    }
    
    private func getRequestForURL(_ url: URL) -> URLRequest {
        var request = URLRequest(url: url)
        request.timeoutInterval = NetworkConfig.timeout
        request.allHTTPHeaderFields = NetworkConfig.defaultHTTPHeaderFields
        request.setHTTPMethod(.GET)
        return request
    }
}
