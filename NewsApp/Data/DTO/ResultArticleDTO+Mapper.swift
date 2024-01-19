//
//  ResultArticleDTO+Mapper.swift
//  NewsApp
//
//  Created by 이은재 on 1/19/24.
//

import Foundation

extension ResultArticleDTO {
    func toDomain() -> [Article] {
        articles.map {
            Article(
                sourceName: $0.source.name,
                author: $0.author,
                title: $0.title,
                description: $0.description,
                url: $0.url,
                urlToImage: $0.urlToImage,
                publishedAt: $0.publishedAt?.convertToPrettyDateString(),
                content: $0.content
            )
        }
    }
}

