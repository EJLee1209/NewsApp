//
//  ResponseStatus.swift
//  NewsApp
//
//  Created by 이은재 on 1/19/24.
//

import Foundation

enum HttpResponseStatus {
    static let ok = 200...299
    static let clientError = 400...499
    static let serverError = 500...599
}
