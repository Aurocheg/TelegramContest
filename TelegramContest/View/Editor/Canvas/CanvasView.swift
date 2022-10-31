//
//  CanvasView.swift
//  TelegramContest
//
//  Created by Aurocheg on 22.10.22.
//

import UIKit


struct TouchPointsAndColor {
    var color: UIColor?
    var width: CGFloat?
    var opacity: CGFloat?
    var points: [CGPoint]?
    
    init(color: UIColor, points: [CGPoint]?) {
        self.color = color
        self.points = points
    }
}

final class CanvasView: UIView {
    static var onLineCreating: ((_ bool: Bool) -> ())?
    private var lines = [TouchPointsAndColor]()
    public var strokeWidth: CGFloat = 10.0
    public var strokeColor: UIColor = .white
    public var strokeOpacity: CGFloat = 1.0
    
    private let screenHeight = UIScreen.main.bounds.height
    
    init() {
        super.init(frame: .zero)
        
        backgroundColor = .clear
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)

        guard let context = UIGraphicsGetCurrentContext() else { return }
        
        lines.forEach { (line) in
            for (i, p) in (line.points?.enumerated())! {
                var point = p
                
                if screenHeight < 812 {
                    point.y -= 74.0
                } else {
                    point.y -= 130.0
                }
                
                if i == 0 {
                    context.move(to: point)
                } else {
                    context.addLine(to: point)
                }
                context.setStrokeColor(line.color?.withAlphaComponent(line.opacity ?? 1.0).cgColor ?? UIColor.black.cgColor)
                context.setLineWidth(line.width ?? 1.0)
                context.setTextDrawingMode(.stroke)
            }
            context.setLineCap(.round)
            context.strokePath()
            CanvasView.onLineCreating?(true)
        }
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        lines.append(TouchPointsAndColor(color: UIColor(), points: [CGPoint]()))
        CanvasView.onLineCreating?(true)
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first?.location(in: nil) else { return }

        guard var lastPoint = lines.popLast() else {return}

        lastPoint.points?.append(touch)
        lastPoint.color = strokeColor
        lastPoint.width = strokeWidth
        lastPoint.opacity = strokeOpacity
        
        lines.append(lastPoint)
        setNeedsDisplay()
        CanvasView.onLineCreating?(true)
    }
    
    public func clearCanvasView() {
        lines.removeAll()
        setNeedsDisplay()
        CanvasView.onLineCreating?(false)
    }

    public func undoDraw() {
        if lines.count > 0 {
            lines.removeLast()
            setNeedsDisplay()
            CanvasView.onLineCreating?(false)
        }
    }
}
