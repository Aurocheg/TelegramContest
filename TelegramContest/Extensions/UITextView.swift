//
//  UITextView.swift
//  TelegramContest
//
//  Created by Aurocheg on 31.10.22.
//

import UIKit

final class TextView: UITextView {
    var lastLocation = CGPoint(x: 0, y: 0)
    
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        
        self.showsHorizontalScrollIndicator = false
        self.showsVerticalScrollIndicator = false
        self.isScrollEnabled = false
        
        self.backgroundColor = .clear
        self.autocorrectionType = .no
        
        self.becomeFirstResponder()
        
        let panRecognizer = UIPanGestureRecognizer(target: self, action: #selector(detectPan))
        self.gestureRecognizers = [panRecognizer]
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func detectPan(_ recognizer: UIPanGestureRecognizer) {
        let translation = recognizer.translation(in: self.superview)
        self.center = CGPoint(x: lastLocation.x + translation.x, y: lastLocation.y + translation.y)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.superview?.bringSubviewToFront(self)
        
        lastLocation = self.center
    }
}
