//
//  UISlider.swift
//  TelegramContest
//
//  Created by Aurocheg on 15.10.22.
//

import Foundation
import UIKit

final class ColorSlider: UISlider {
    private var trackHeight: CGFloat = 36.0

    init(minValue: Float, maxValue: Float) {
        super.init(frame: .zero)
        
        self.layer.cornerRadius = 18.0
        
        self.minimumValue = minValue
        self.maximumValue = maxValue
        
        let thumbView = UIView()
        thumbView.backgroundColor = .clear
        thumbView.layer.borderWidth = 3.0
        thumbView.layer.borderColor = UIColor.black.cgColor
        
        let thumb = thumbImage(radius: 29.0, thumbView: thumbView)
        self.setThumbImage(thumb, for: .normal)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func trackRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(origin: bounds.origin, size: CGSize(width: bounds.width, height: trackHeight))
    }
    
    private func thumbImage(radius: CGFloat, thumbView: UIView) -> UIImage {
        thumbView.frame = CGRect(x: 0, y: radius / 2, width: 29.0, height: 29.0)
        thumbView.layer.cornerRadius = radius / 2
        
        let renderer = UIGraphicsImageRenderer(bounds: thumbView.bounds)
        return renderer.image {rendererContext in
            thumbView.layer.render(in: rendererContext.cgContext)
        }
        
    }
}
