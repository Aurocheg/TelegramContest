//
//  UIButton].swift
//  TelegramContest
//
//  Created by Aurocheg on 14.10.22.
//

import Foundation
import UIKit

final class Button: UIButton {
    enum ButtonBackground {
        case dark
        case no
    }
    
    init(image: UIImage? = nil, background: ButtonBackground) {
        super.init(frame: .zero)
        
        self.titleLabel?.font = .systemFont(ofSize: 17.0)

        if let image = image {
            self.setBackgroundImage(image, for: .normal)
        }
        
        switch background {
        case .no:
            self.backgroundColor = .clear
        case .dark:
            self.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.1)
            self.layer.cornerRadius = 15.0
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
