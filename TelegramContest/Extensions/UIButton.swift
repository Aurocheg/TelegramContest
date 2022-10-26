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

final class FontButton: UIButton {
    init(margins: UIEdgeInsets) {
        super.init(frame: .zero)
        
        self.layer.borderColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.33).cgColor
        self.layer.borderWidth = 0.33
        self.layer.cornerRadius = 9.0
        self.titleLabel?.font = .systemFont(ofSize: 13.0)
        self.titleEdgeInsets = margins
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var intrinsicContentSize: CGSize {
        get {
            let baseSize = super.intrinsicContentSize
            return CGSize(width: baseSize.width + titleEdgeInsets.left + titleEdgeInsets.right,
                          height: baseSize.height + titleEdgeInsets.top + titleEdgeInsets.bottom)
        }
    }
}
