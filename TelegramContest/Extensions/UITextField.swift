//
//  UITextField.swift
//  TelegramContest
//
//  Created by Aurocheg on 15.10.22.
//

import Foundation
import UIKit

extension UITextField {
    func createTF(textSize: CGFloat = 17.0, textColor: UIColor = .white, weight: UIFont.Weight = .semibold, currentText: String = "0") -> UITextField {
        let tf = UITextField()
        
        tf.font = .systemFont(ofSize: textSize, weight: weight)
        tf.textColor = textColor
        tf.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.5)
        tf.layer.cornerRadius = 8.0
        tf.text = text
        
        return tf
    }
}
