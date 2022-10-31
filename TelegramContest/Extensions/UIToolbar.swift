//
//  Toolbar.swift
//  TelegramContest
//
//  Created by Aurocheg on 31.10.22.
//

import UIKit

final class Toolbar: UIToolbar {    
    init() {
        super.init(frame: .zero)
        self.tintColor = .white
        self.setBackgroundImage(UIImage(), forToolbarPosition: .top, barMetrics: .default)
        self.backgroundColor = .clear
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
