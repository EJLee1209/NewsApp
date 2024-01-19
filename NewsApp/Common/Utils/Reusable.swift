//
//  Reusable.swift
//  NewsApp
//
//  Created by 이은재 on 1/19/24.
//

protocol Reusable {}

extension Reusable {
    static var identifier: String { String(describing: self) }
}
