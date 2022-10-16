//
//  UISlider.swift
//  TelegramContest
//
//  Created by Aurocheg on 15.10.22.
//

import Foundation
import UIKit

extension UISlider {
    func createSlider(minValue: Float, maxValue: Float) -> UISlider {
        let slider = UISlider()
        
        slider.minimumValue = minValue
        slider.maximumValue = maxValue
        
        let thumbView = UIView()
        thumbView.backgroundColor = .systemYellow
        thumbView.layer.borderWidth = 0.4
        thumbView.layer.borderColor = UIColor.darkGray.cgColor
        
        let thumb = thumbImage(radius: 20.0, thumbView: thumbView)
        slider.setThumbImage(thumb, for: .normal)
        
        return slider
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
