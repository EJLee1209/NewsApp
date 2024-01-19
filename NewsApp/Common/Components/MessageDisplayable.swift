//
//  MessageDisplayable.swift
//  NewsApp
//
//  Created by 이은재 on 1/19/24.
//

import UIKit

protocol MessageDisplayable {}

extension MessageDisplayable where Self: UIViewController {
    func presentAlert(title: String, message: String) {
        let alert = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )
        
        let okAction = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okAction)
        
        self.present(alert, animated: true)
    }
}
