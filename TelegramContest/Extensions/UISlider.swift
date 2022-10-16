//
//  UISlider.swift
//  TelegramContest
//
//  Created by Aurocheg on 15.10.22.
//

import Foundation
import UIKit

final class ColorSlider: UISlider {
    init(minValue: Float, maxValue: Float) {
        super.init(frame: .zero)
        
        self.layer.cornerRadius = 18.0
        
        self.minimumValue = minValue
        self.maximumValue = maxValue
        
        let thumbView = UIView()
        thumbView.backgroundColor = .clear
        thumbView.layer.borderWidth = 0.4
        thumbView.layer.borderColor = UIColor.darkGray.cgColor
        
        let thumb = thumbImage(radius: 40.0, thumbView: thumbView)
        self.setThumbImage(thumb, for: .normal)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func thumbImage(radius: CGFloat, thumbView: UIView) -> UIImage {
        thumbView.frame = CGRect(x: 0, y: radius / 2, width: radius, height: radius)
        thumbView.layer.cornerRadius = radius / 2
        
        let renderer = UIGraphicsImageRenderer(bounds: thumbView.bounds)
        return renderer.image {rendererContext in
            thumbView.layer.render(in: rendererContext.cgContext)
        }
        
    }
}
