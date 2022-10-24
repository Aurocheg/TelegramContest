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
        
        let thumbView = UIView()
        thumbView.backgroundColor = .clear
        thumbView.layer.borderWidth = 3.0
        thumbView.layer.borderColor = UIColor.black.cgColor
        
        let thumb = thumbImage(radius: 29.0, thumbView: thumbView, size: CGSize(width: 29.0, height: 29.0))
        self.setThumbImage(thumb, for: .normal)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func trackRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(origin: bounds.origin, size: CGSize(width: bounds.width, height: trackHeight))
    }
}

final class SizeSliderView: UIView {
    private let leftRadius: CGFloat = 2.0
    private let rightRadius: CGFloat = 10.0
    private var cMask = CAShapeLayer()
    
    var pct: Float = 0.0 {
        didSet {
            let p = pct as NSNumber
            CATransaction.begin()
            CATransaction.setDisableActions(true)
            gradientLayer.locations = [
                0.0, p, p, 1.0
            ]
        }
    }
    
    override class var layerClass: AnyClass { return CAGradientLayer.self }
    private var gradientLayer: CAGradientLayer {
        self.layer as! CAGradientLayer
    }
    
    init() {
        super.init(frame: .zero)
        
        let colors = [
            UIColor.red.cgColor,
            UIColor.red.cgColor,
            UIColor(red: 1, green: 1, blue: 1, alpha: 0.3).cgColor,
            UIColor(red: 1, green: 1, blue: 1, alpha: 0.3).cgColor
        ]
        gradientLayer.colors = colors
        gradientLayer.locations = [0.0, 0.0, 0.0, 1.0]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let r = bounds
        let leftCenter = CGPoint(x: r.minX + leftRadius, y: r.midY)
        let rightCenter = CGPoint(x: r.maxX - rightRadius, y: r.midY)
        let bez = UIBezierPath()
        bez.addArc(withCenter: leftCenter, radius: leftRadius, startAngle: .pi * 0.5, endAngle: .pi * 1.5, clockwise: true)
        bez.addArc(withCenter: rightCenter, radius: rightRadius, startAngle: .pi * 1.5, endAngle: .pi * 0.5, clockwise: true)
        bez.close()
        cMask.path = bez.cgPath
        layer.mask = cMask
    }
}
