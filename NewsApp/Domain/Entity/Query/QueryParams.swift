//
//  QueryParams.swift
//  NewsApp
//
//  Created by 이은재 on 1/19/24.
//

protocol QueryParams {}

extension QueryParams {
    func toDict() -> [String: String] {
        var dict = [String: String]()
        _ = Mirror(reflecting: self).children.map {
            guard let label = $0.label else { return }
            dict[label] = $0.value as? String
        }
        
        return dict
    }
}
