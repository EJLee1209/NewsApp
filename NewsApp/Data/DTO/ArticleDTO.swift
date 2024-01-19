//
//  ArticleDTO.swift
//  NewsApp
//
//  Created by 이은재 on 1/19/24.
//

import Foundation

struct ArticleDTO: Decodable {
    let source: SourceDTO
    let author: String?
    let title: String?
    let description: String?
    let url: String?
    let urlToImage: String?
    let publishedAt: String?
    let content: String?
}
