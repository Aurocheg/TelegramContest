//
//  UIBezierPath.swift
//  TelegramContest
//
//  Created by Aurocheg on 29.10.22.
//

import UIKit

extension UIBezierPath {
    static func createArrow(from start: CGPoint, to end: CGPoint, tailWidth: CGFloat, headWidth: CGFloat, headLength: CGFloat) -> UIBezierPath {
        let length = hypot(end.x - start.x, end.y - start.y)
        let tailLength = length - headLength
        
        func p(_ x: CGFloat, _ y: CGFloat) -> CGPoint { return CGPoint(x: x, y: y)}
        let points: [CGPoint] = [
            p(0, tailWidth / 2),
            p(tailLength, tailWidth / 2),
            p(tailLength, headLength / 2),
            p(length, 0),
            p(tailLength, -headWidth / 2),
            p(tailLength, -tailWidth / 2),
            p(0, -tailWidth / 2)
        ]
        
        let cosine = (end.x - start.x) / length
        let sine = (end.y - start.y) / length
        let transform = CGAffineTransform(a: cosine, b: sine, c: -sine, d: cosine, tx: start.x, ty: start.y)
        
        let path = CGMutablePath()
        path.addLines(between: points, transform: transform)
        path.closeSubpath()
        
        return self.init(cgPath: path)
    }
    
    static func createBubble(contentSize: CGSize) -> UIBezierPath {
        let triangleHeight: CGFloat = 15.0
        let borderWidth: CGFloat = 4.0
        let radius: CGFloat = 10.0
        let radius2: CGFloat = radius - borderWidth / 2
        
        let rect = CGRect(x: 0.0, y: 0.0, width: contentSize.width, height: contentSize.height).offsetBy(dx: radius, dy: radius + triangleHeight)
        let path = UIBezierPath()
        
        path.move(to: CGPoint(x: rect.maxX - triangleHeight * 2, y: rect.minY - radius2))
        path.addLine(to: CGPoint(x: rect.maxX - triangleHeight, y: rect.minY - radius2 - triangleHeight))
        
        path.addArc(withCenter: CGPoint(x: rect.maxX, y: rect.minY), radius: radius2, startAngle: -.pi / 2, endAngle: 0, clockwise: true)
        path.addArc(withCenter: CGPoint(x: rect.maxX, y: rect.maxX), radius: radius2, startAngle: 0, endAngle: .pi / 2, clockwise: true)
        path.addArc(withCenter: CGPoint(x: rect.minX, y: rect.maxY), radius: radius2, startAngle: .pi / 2, endAngle: .pi, clockwise: true)
        path.addArc(withCenter: CGPoint(x: rect.minX, y: rect.minY), radius: radius2, startAngle: .pi, endAngle: -.pi / 2, clockwise: true)
        path.close()
        
        return path
    }
    
    static func createStar(in rect: CGRect, corners: Int, smoothness: Double) -> UIBezierPath {
        guard corners >= 2 else {return UIBezierPath()}
        
        let center = CGPoint(x: rect.width / 2, y: rect.height / 2)
        
        var currentAngle = -CGFloat.pi / 2
        let angleAdjustment = .pi * 2 / Double(corners * 2)
        
        let innerX = center.x * smoothness
        let innerY = center.y * smoothness
        
        let path = UIBezierPath()
        
        path.move(to: CGPoint(x: center.x * cos(currentAngle), y: center.y * sin(currentAngle)))
        
        var bottomEdge: Double = 0
        
        for corner in 0..<corners * 2 {
            let sinAngle = sin(currentAngle)
            let cosAngle = cos(currentAngle)
            let bottom: Double
            
            if corner.isMultiple(of: 2) {
                bottom = center.y * sinAngle
                path.addLine(to: CGPoint(x: center.x * cosAngle, y: bottom))
            } else {
                bottom = innerY * sinAngle
                path.addLine(to: CGPoint(x: innerX * cosAngle, y: bottom))
            }
            
            if bottom > bottomEdge {
                bottomEdge = bottom
            }
            
            currentAngle += angleAdjustment
        }
        
        let unusedSpace = (rect.height / 2 - bottomEdge) / 2
        
        let transform = CGAffineTransform(translationX: center.x, y: center.y + unusedSpace)
        path.apply(transform)
        return path
    }
}
