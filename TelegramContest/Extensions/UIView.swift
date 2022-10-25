//
//  UIView.swift
//  TelegramContest
//
//  Created by Aurocheg on 25.10.22.
//

import UIKit

extension UIView {
    func takeScreenshot() -> UIImage {
        UIGraphicsBeginImageContextWithOptions(self.bounds.size, false, UIScreen.main.scale)
        drawHierarchy(in: self.bounds, afterScreenUpdates: true)

        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        if (image != nil) {
            return image!
        }
        return UIImage()
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

