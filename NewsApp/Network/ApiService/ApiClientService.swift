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



