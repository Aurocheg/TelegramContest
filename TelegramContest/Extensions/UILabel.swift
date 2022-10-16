//
//  UILabel.swift
//  TelegramContest
//
//  Created by Aurocheg on 15.10.22.
//

import Foundation
import UIKit

final class Label: UILabel {
    init(text: String, size: CGFloat, weight: UIFont.Weight, color: UIColor? = nil) {
        super.init(frame: .zero)
        
        self.font = .systemFont(ofSize: size, weight: weight)
        self.text = text
        
        if let color = color {
            self.textColor = color
        } else {
            self.textColor = .white
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
