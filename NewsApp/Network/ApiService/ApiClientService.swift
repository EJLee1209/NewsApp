//
//  ApiClientService.swift
//  NewsApp
//
//  Created by 이은재 on 1/19/24.
//

import Foundation

protocol ApiClientService {
    func request<T: Decodable>(
        endPoint: String,
        query: [String: String]?,
        decodeType: T.Type
    ) async throws -> T
}

struct ApiClientServiceImpl: ApiClientService {
    private(set) var session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func request<T: Decodable>(
        endPoint: String,
        query: [String : String]?,
        decodeType: T.Type
    ) async throws -> T {
        guard var urlComponents = URLComponents(string: endPoint) else {
            throw ApiError.errorInUrl
        }
        
        urlComponents.queryItems = query?.map {
            URLQueryItem(name: $0.key, value: $0.value)
        }
        
        guard let requestURL = urlComponents.url else {
            throw ApiError.unknownError
        }
        
        print("DEBUG: \(requestURL.absoluteString)")
        
        let request = URLRequest(url: requestURL)
        let (data, response) = try await session.data(for: request)
        
        return try validateResponse(data: data, response: response)
    }
    
    private func validateResponse<T: Decodable>(
        data: Data,
        response: URLResponse
    ) throws -> T {
        guard let httpResponse = response as? HTTPURLResponse else {
            throw ApiError.unknownError
        }
        
        switch httpResponse.statusCode {
        case HttpResponseStatus.ok:
            return try decodeModel(data: data)
        case HttpResponseStatus.clientError:
            throw ApiError.clientError
        case HttpResponseStatus.serverError:
            throw ApiError.serverError
        default:
            throw ApiError.unknownError
        }
    }
    
    private func decodeModel<T: Decodable>(
        data: Data
    ) throws -> T {
        try JSONDecoder().decode(T.self, from: data)
    }
    
}


