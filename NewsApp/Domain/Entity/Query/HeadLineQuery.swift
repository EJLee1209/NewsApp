//
//  HeadLineQuery.swift
//  NewsApp
//
//  Created by 이은재 on 1/19/24.
//

struct HeadLineQuery: QueryParams {
    let category: String?
    let country: String?
    let apiKey: String = EndPoint.apiKey
}
