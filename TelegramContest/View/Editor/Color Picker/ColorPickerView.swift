//
//  ColorPickerView.swift
//  TelegramContest
//
//  Created by Aurocheg on 15.10.22.
//

import UIKit

final class ColorPickerView: UIView {
    // MARK: - Constraints
    private let colorPickerConstraints = ColorPickerConstraints()
    private let slidersConstraints = SlidersConstraints()
    
    // MARK: - Top Elements
    public let eyeDropperButton = Button(image: UIImage(named: "eyeDropper"), background: .no)
    
    private let mainTitleLabel = Label(text: "Colors", size: 17.0, weight: .semibold)
    
    public let closeButton = Button(image: UIImage(named: "cancel"), background: .dark)
    
    public let segmentedControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl(items: ["Grid", "Spectrum", "Sliders"])
        segmentedControl.selectedSegmentIndex = 0
        return segmentedControl
    }()
    
    // MARK: - Grid
    public let gridColorsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 30.0, height: 30.0)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.layer.cornerRadius = 10.0
        
        return collectionView
    }()
    
    // MARK: - Spectrum
    public let spectrumView = SpectrumView()
    
    // MARK: - Sliders
    public let slidersView = SlidersView()
    
    // MARK: - Opacity
    private let opacityLabel = Label(text: "OPACITY", size: 13.0, weight: .semibold, color: UIColor(red: 0.922, green: 0.922, blue: 0.961, alpha: 0.6))
    public let opacitySlider = ColorSlider(minValue: 0.0, maxValue: 100.0)
    public let opacityTF = ColorTF()
    
    // MARK: - Colors
    private let separatingLineView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0.282, green: 0.282, blue: 0.29, alpha: 1)
        return view
    }()
    
    public let currentColorView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 10
        view.backgroundColor = .systemPurple
        return view
    }()
    
    public let colorsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return collectionView
    }()
    
    // MARK: - Init Method
    init() {
        super.init(frame: .zero)
        
        backgroundColor = .systemGray5
        
        initViews()
        initConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Init Views Method
    private func initViews() {
        // MARK: - Top
        addSubview(eyeDropperButton)
        addSubview(mainTitleLabel)
        addSubview(closeButton)
        addSubview(segmentedControl)
        
        // MARK: - Grid
//        addSubview(gridColorsCollectionView)
//
//        // MARK: - Spectrum
//        addSubview(spectrumView)
//
//        // MARK: - Sliders
        addSubview(slidersView)

        // MARK: - Opacity
        addSubview(opacityLabel)
        addSubview(opacitySlider)
        addSubview(opacityTF)

        // MARK: - Separator
        addSubview(separatingLineView)

        // MARK: - Colors
        addSubview(currentColorView)
        addSubview(colorsCollectionView)
    }
    
    // MARK: - Init Constraints Method
    private func initConstraints() {
        // MARK: - Top
        colorPickerConstraints.addConstraintsToToolButton(eyeDropperButton, view: self, position: .left, size: CGSize(width: 23.0, height: 23.0))
        colorPickerConstraints.addConstraintsToMainTitle(mainTitleLabel, view: self)
        colorPickerConstraints.addConstraintsToToolButton(closeButton, view: self, position: .right)
        colorPickerConstraints.addConstraintsToSegmentedControl(segmentedControl, view: self, parent: mainTitleLabel)
        
        // MARK: - Sliders
        colorPickerConstraints.addConstraintsToSlidersView(slidersView, view: self, parent: segmentedControl)
        
        // MARK: - Opacity
        slidersConstraints.addConstraintsToSliderLabel(opacityLabel, view: self, parent: slidersView, topConstant: 20.0, leftConstant: 20.0)
        slidersConstraints.addConstraintsToSlider(opacitySlider, view: self, parent: opacityLabel, leftConstant: 16.0)
        slidersConstraints.addConstraintsToSliderTF(opacityTF, view: self, parent: opacityLabel, rightConstant: -16.0)
        
        // MARK: - Separator
        colorPickerConstraints.addConstraintsToSeparator(separatingLineView, view: self, parent: opacitySlider)
        
        // MARK: - Colors
        colorPickerConstraints.addConstraintsToCurrentColor(currentColorView, view: self, parent: separatingLineView)
    }
}
