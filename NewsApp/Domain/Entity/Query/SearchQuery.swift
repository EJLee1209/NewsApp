//
//  Query.swift
//  NewsApp
//
//  Created by 이은재 on 1/19/24.
//

struct SearchQuery: QueryParams {
    let q: String
    let searchIn: String?
    let sortBy: String?
    let apiKey: String = EndPoint.apiKey
}







