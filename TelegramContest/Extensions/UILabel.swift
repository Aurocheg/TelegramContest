//
//  UILabel.swift
//  TelegramContest
//
//  Created by Aurocheg on 15.10.22.
//

import Foundation
import UIKit

extension UILabel {
    func createLabel(text: String, size: CGFloat, weight: UIFont.Weight, color: UIColor? = nil) -> UILabel {
        let label = UILabel()
        
        label.font = .systemFont(ofSize: size, weight: weight)
        label.text = text
        
        if let color = color {
            label.textColor = color
        } else {
            label.textColor = .white
        }
        
        return label
    }
}
