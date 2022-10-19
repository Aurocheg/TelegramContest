//
//  SpectrumView.swift
//  TelegramContest
//
//  Created by Aurocheg on 16.10.22.
//

import UIKit

final class SpectrumView: UIView {
    static var onColorDidChange: ((_ color: UIColor) -> ())?

    private let saturationExponentTop: Float = 0.05
    private let saturationExponentBottom: Float = 0.0

    private let grayPaletteHeightFactor: CGFloat = 0.05
    private var rectGrayPalette = CGRect.zero
    private var rectMainPalette = CGRect.zero
    
    private var elementSize: CGFloat = 1.0 {
        didSet {
            setNeedsDisplay()
        }
    }
    
    // MARK: - Init Method
    init() {
        super.init(frame: .zero)

        initViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Init Views Method
    private func initViews() {
        self.clipsToBounds = true
        let touchGesture = UILongPressGestureRecognizer(target: self, action: #selector(self.touchedColor(gestureRecognizer:)))
        touchGesture.minimumPressDuration = 0
        touchGesture.allowableMovement = CGFloat.greatestFiniteMagnitude
        self.addGestureRecognizer(touchGesture)
    }
    
    override func draw(_ rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()

        rectGrayPalette = CGRect(x: 0, y: 0, width: rect.width, height: rect.height * grayPaletteHeightFactor)
        rectMainPalette = CGRect(x: 0, y: rectGrayPalette.maxY, width: rect.width, height: rect.height - rectGrayPalette.height)

        // MARK: - Gray palette
        for y in stride(from: CGFloat(0), to: rectGrayPalette.height, by: elementSize) {
            for x in stride(from: (0 as CGFloat), to: rectGrayPalette.width, by: elementSize) {
                let hue = x / rectGrayPalette.width

                let color = UIColor(white: hue, alpha: 1.0).cgColor

                context!.setFillColor(color)
                context!.fill(CGRect(x: x, y: y, width: elementSize, height: elementSize))
            }
        }

        // MARK: - Main palette
        for y in stride(from: CGFloat(0), to: rectMainPalette.height, by: elementSize) {
            var saturation = y < rectMainPalette.height / 2.0 ? CGFloat(2 * y) / rectMainPalette.height : 2.0 * CGFloat(rectMainPalette.height - y) / rectMainPalette.height
            saturation = CGFloat(powf(Float(saturation), y < rectMainPalette.height / 2.0 ? saturationExponentTop : saturationExponentBottom))
            let brightness = y < rectMainPalette.height / 2.0 ? CGFloat(1.0) : 2.0 * CGFloat(rectMainPalette.height - y) / rectMainPalette.height

            for x in stride(from: (0 as CGFloat), to: rectMainPalette.width, by: elementSize) {
                let hue = x / rectMainPalette.width

                let color = UIColor(hue: hue, saturation: saturation, brightness: brightness, alpha: 1.0).cgColor

                context!.setFillColor(color)
                context!.fill(CGRect(x: x, y: y + rectMainPalette.origin.y,
                                     width: elementSize, height: elementSize))
            }
        }
    }

    func getColorAtPoint(point: CGPoint) -> UIColor {
        var roundedPoint = CGPoint(x: elementSize * CGFloat(Int(point.x / elementSize)),
                                   y: elementSize * CGFloat(Int(point.y / elementSize)))

        let hue = roundedPoint.x / self.bounds.width

        // MARK: - Main palette
        if rectMainPalette.contains(point) {
            // offset point, because rectMainPalette.origin.y is not 0
            roundedPoint.y -= rectMainPalette.origin.y

            var saturation = roundedPoint.y < rectMainPalette.height / 2.0 ? CGFloat(2 * roundedPoint.y) / rectMainPalette.height
                : 2.0 * CGFloat(rectMainPalette.height - roundedPoint.y) / rectMainPalette.height

            saturation = CGFloat(powf(Float(saturation), roundedPoint.y < rectMainPalette.height / 2.0 ? saturationExponentTop : saturationExponentBottom))
            let brightness = roundedPoint.y < rectMainPalette.height / 2.0 ? CGFloat(1.0) : 2.0 * CGFloat(rectMainPalette.height - roundedPoint.y) / rectMainPalette.height

            return UIColor(hue: hue, saturation: saturation, brightness: brightness, alpha: 1.0)
        }
        else {
            return UIColor(white: hue, alpha: 1.0)
        }
    }


    @objc func touchedColor(gestureRecognizer: UILongPressGestureRecognizer) {
        let point = gestureRecognizer.location(in: self)
        let color = getColorAtPoint(point: point)

        SpectrumView.onColorDidChange?(color)
      }
}
