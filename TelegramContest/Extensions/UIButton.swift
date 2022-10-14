//
//  UIButton].swift
//  TelegramContest
//
//  Created by Aurocheg on 14.10.22.
//

import Foundation
import UIKit

enum ButtonBackground {
    case yes
    case no
}

extension UIButton {
    func createButton(size: CGSize = CGSize(width: 33.0, height: 33.0), image: UIImage? = nil, background: ButtonBackground) -> UIButton {
        let button = UIButton()
        button.titleLabel?.font = UIFont.systemFont(ofSize: 17.0)
        
        button.frame.size = size
        
        if let image = image {
            button.setBackgroundImage(image, for: .normal)
        }
        
        switch background {
        case .no:
            button.backgroundColor = .clear
        case .yes:
            let color = UIColor(red: 1, green: 1, blue: 1, alpha: 0.1)
            button.backgroundColor = color
            button.layer.cornerRadius = 15.0
        }
        
        return button
    }
}
