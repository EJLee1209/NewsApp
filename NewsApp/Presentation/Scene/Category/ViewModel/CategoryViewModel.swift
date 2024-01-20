//
//  CategoryViewModel.swift
//  NewsApp
//
//  Created by 이은재 on 1/20/24.
//

struct CategoryViewModel {
    
    private var categories = HeadLineCategory.allCases
    
    var itemCategoriesCount: Int {
        categories.count
    }
    
    func makeItemCategoryViewModel(row: Int) -> ItemCategoryViewModel {
        ItemCategoryViewModel(category: categories[row])
    }
    
    func getSelectedCategory(row: Int) -> String {
        categories[row].rawValue
    }
}
