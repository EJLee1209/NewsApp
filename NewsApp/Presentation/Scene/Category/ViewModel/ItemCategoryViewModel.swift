//
//  ItemCategoryViewModel.swift
//  NewsApp
//
//  Created by 이은재 on 1/20/24.
//

import Foundation

struct ItemCategoryViewModel {
    
    private let category: HeadLineCategory
    
    var title: String {
        category.rawValue
    }
    
    var imageName: String {
        category.rawValue
    }
    
    init(category: HeadLineCategory) {
        self.category = category
    }
    
}
