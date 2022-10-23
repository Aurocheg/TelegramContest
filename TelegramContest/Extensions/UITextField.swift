//
//  UITextField.swift
//  TelegramContest
//
//  Created by Aurocheg on 15.10.22.
//

import Foundation
import UIKit

final class ColorTF: UITextField {
    init(textSize: CGFloat = 17.0, textColor: UIColor = .white, weight: UIFont.Weight = .semibold, currentText: String = "0") {
        super.init(frame: .zero)
        
        self.font = .systemFont(ofSize: textSize, weight: weight)
        self.textColor = textColor
        self.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        self.layer.cornerRadius = 8.0
        self.textAlignment = .center
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
