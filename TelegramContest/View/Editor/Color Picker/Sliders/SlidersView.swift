//
//  SlidersView.swift
//  TelegramContest
//
//  Created by Aurocheg on 16.10.22.
//

import UIKit

final class SlidersView: UIView {    
    // MARK: - Constraints
    private let slidersConstraints = SlidersConstraints()
    
    // MARK: - Red
    private let redLabel = Label(text: "RED", size: 13.0, weight: .semibold, color: UIColor(red: 0.922, green: 0.922, blue: 0.961, alpha: 0.6))
    public let redSlider = ColorSlider(minValue: 0.0, maxValue: 255.0)
    public let redTF = ColorTF()
    
    // MARK: - Green
    private let greenLabel = Label(text: "GREEN", size: 13.0, weight: .semibold, color: UIColor(red: 0.922, green: 0.922, blue: 0.961, alpha: 0.6))
    public let greenSlider = ColorSlider(minValue: 0.0, maxValue: 255.0)
    public let greenTF = ColorTF()
    
    // MARK: - Blue
    private let blueLabel = Label(text: "BLUE", size: 13.0, weight: .semibold, color: UIColor(red: 0.922, green: 0.922, blue: 0.961, alpha: 0.6))
    public let blueSlider = ColorSlider(minValue: 0.0, maxValue: 255.0)
    public let blueTF = ColorTF()
    
    // MARK: - Hex
    private let hexColorLabel = Label(text: "Display P3 Hex Color #", size: 17.0, weight: .regular)
    public let hexColorTF = ColorTF()
    
    // MARK: - Init Method
    init() {
        super.init(frame: .zero)
        
        initViews()
        initConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Init Views Method
    private func initViews() {
        // MARK: - Red
        addSubview(redLabel)
        addSubview(redSlider)
        addSubview(redTF)
        
        // MARK: - Green
        addSubview(greenLabel)
        addSubview(greenSlider)
        addSubview(greenTF)
        
        // MARK: - Blue
        addSubview(blueLabel)
        addSubview(blueSlider)
        addSubview(blueTF)
        
        // MARK: - Hex
        addSubview(hexColorTF)
        addSubview(hexColorLabel)
    }
    
    // MARK: - Init Constraints Method
    private func initConstraints() {
        // MARK: - Red
        slidersConstraints.addConstraintsToSliderLabel(redLabel, view: self)
        slidersConstraints.addConstraintsToSlider(redSlider, view: self, parent: redLabel)
        slidersConstraints.addConstraintsToSliderTF(redTF, view: self, parent: redLabel)
        
        // MARK: - Green
        slidersConstraints.addConstraintsToSliderLabel(greenLabel, view: self, parent: redSlider)
        slidersConstraints.addConstraintsToSlider(greenSlider, view: self, parent: greenLabel)
        slidersConstraints.addConstraintsToSliderTF(greenTF, view: self, parent: greenLabel)

        // MARK: - Blue
        slidersConstraints.addConstraintsToSliderLabel(blueLabel, view: self, parent: greenSlider)
        slidersConstraints.addConstraintsToSlider(blueSlider, view: self, parent: blueLabel)
        slidersConstraints.addConstraintsToSliderTF(blueTF, view: self, parent: blueLabel)
        
        // MARK: - Hex
        slidersConstraints.addConstraintsToSliderTF(hexColorTF, view: self, parent: blueSlider, topConstant: 28.0)
        slidersConstraints.addConstraintsToHexLabel(hexColorLabel, parent: hexColorTF, slider: blueSlider)
    }
}
