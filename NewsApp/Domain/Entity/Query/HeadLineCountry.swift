//
//  HeadLineCountry.swift
//  NewsApp
//
//  Created by 이은재 on 1/19/24.
//

enum HeadLineCountry: String, CaseIterable {
    case kr
    case us
    case jp
}

extension HeadLineCountry: CustomStringConvertible {
    var description: String {
        switch self {
        case .kr:
            return "Korea"
        case .us:
            return "United States"
        case .jp:
            return "Japan"
        }
    }
    
}
