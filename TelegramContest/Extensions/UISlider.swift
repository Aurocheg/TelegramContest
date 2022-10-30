//
//  UISlider.swift
//  TelegramContest
//
//  Created by Aurocheg on 15.10.22.
//

import Foundation
import UIKit

enum SliderType {
    case color
    case opacity
}

extension UISlider {
    func thumbImage(radius: CGFloat, thumbView: UIView, size: CGSize) -> UIImage {
        thumbView.frame = CGRect(x: 0, y: radius / 2, width: size.width, height: size.height)
        thumbView.layer.cornerRadius = radius / 2
        
        let renderer = UIGraphicsImageRenderer(bounds: thumbView.bounds)
        return renderer.image {rendererContext in
            thumbView.layer.render(in: rendererContext.cgContext)
        }
    }
}

final class ColorSlider: UISlider {
    private var trackHeight: CGFloat = 36.0

    init(minValue: Float, maxValue: Float, type: SliderType = .color, value: Float) {
        super.init(frame: .zero)
        
        let thumbSize = CGSize(width: 29.0, height: 29.0)
                
        self.layer.cornerRadius = 18.0
        self.minimumValue = minValue
        self.maximumValue = maxValue
        self.value = value
        
        switch type {
        case .color: self.tintColor = .darkGray
        case .opacity:
            self.setMinimumTrackImage(UIImage(named: "opacityImage"), for: .normal)
            self.setMaximumTrackImage(UIImage(named: "opacityImage"), for: .normal)
        }
        
        let thumbViewNormal = UIView()
        thumbViewNormal.backgroundColor = .clear
        thumbViewNormal.layer.borderWidth = 3.0
        thumbViewNormal.layer.borderColor = UIColor.black.cgColor
        
        let thumbNormal = thumbImage(radius: 29.0, thumbView: thumbViewNormal, size: thumbSize)
        
        self.setThumbImage(thumbNormal, for: .normal)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func trackRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(origin: bounds.origin, size: CGSize(width: bounds.width, height: trackHeight))
    }
}
