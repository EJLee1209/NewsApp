//
//  ApiError.swift
//  NewsApp
//
//  Created by 이은재 on 1/19/24.
//

import Foundation

enum ApiError {
    case clientError
    case serverError
    case errorInUrl
    case errorDecoding
    case unknownError
}

extension ApiError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .clientError:
            return NSLocalizedString("Client error", comment: "")
        case .serverError:
            return NSLocalizedString("Server error", comment: "")
        case .errorInUrl:
            return NSLocalizedString("Error in url", comment: "")
        case .errorDecoding:
            return NSLocalizedString("Decoding error", comment: "")
        case .unknownError:
            return NSLocalizedString("Unkown error", comment: "")
        }
    }
}
