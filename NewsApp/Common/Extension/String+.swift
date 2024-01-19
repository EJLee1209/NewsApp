//
//  String+.swift
//  NewsApp
//
//  Created by 이은재 on 1/19/24.
//

import Foundation
extension String {
    func convertToPrettyDateString() -> String {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        inputFormatter.locale = Locale(identifier: "en_US_POSIX")

        if let date = inputFormatter.date(from: self) {
            let outputFormatter = DateFormatter()
            outputFormatter.locale = Locale(identifier: "ko_KR")
            outputFormatter.dateFormat = "yyyy년 M월 d일 a h시 mm분"
            
            let outputDateString = outputFormatter.string(from: date)
            return outputDateString
        } else {
            return ""
        }
    }
}
