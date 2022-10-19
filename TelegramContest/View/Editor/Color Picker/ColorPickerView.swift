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
    
    private let toolsView = UIView()

    // MARK: - Grid
    public let gridColorsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let itemWidth = UIScreen.main.bounds.width * 0.07
        layout.itemSize = CGSize(width: 32.0, height: 30.0)
        layout.minimumLineSpacing = 0.0
        layout.minimumInteritemSpacing = 0.0
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.layer.cornerRadius = 10.0
        collectionView.isScrollEnabled = false
        collectionView.isHidden = false
        
        return collectionView
    }()
    
    // MARK: - Spectrum
    public let spectrumView: UIView = {
        let view = SpectrumView()
        view.isHidden = true
        view.layer.cornerRadius = 8.0
        return view
    }()
    
    // MARK: - Sliders
    public let slidersView: UIView = {
        let view = UIView()
        view.isHidden = true
        return view
    }()
    
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

    // MARK: - Opacity
    private let opacityLabel = Label(text: "OPACITY", size: 13.0, weight: .semibold, color: UIColor(red: 0.922, green: 0.922, blue: 0.961, alpha: 0.6))
    public let opacitySlider = ColorSlider(minValue: 1.0, maxValue: 100.0, type: .opacity)
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
        
        addSubview(toolsView)
        
        // MARK: - Grid
        toolsView.addSubview(gridColorsCollectionView)

        // MARK: - Spectrum
        toolsView.addSubview(spectrumView)

        // MARK: - Sliders
        toolsView.addSubview(slidersView)
        slidersView.addSubview(redLabel)
        slidersView.addSubview(redSlider)
        slidersView.addSubview(redTF)
        
        slidersView.addSubview(greenLabel)
        slidersView.addSubview(greenSlider)
        slidersView.addSubview(greenTF)
        
        slidersView.addSubview(blueLabel)
        slidersView.addSubview(blueSlider)
        slidersView.addSubview(blueTF)
        
        slidersView.addSubview(hexColorTF)
        slidersView.addSubview(hexColorLabel)

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
        
        colorPickerConstraints.addConstraintsToToolsView(toolsView, view: self, parent: segmentedControl)
        
        // MARK: - Grid
        colorPickerConstraints.addConstraintsToGridColors(gridColorsCollectionView, view: toolsView)
        
        // MARK: - Spectrum
        colorPickerConstraints.addConstraintsToSpectrumView(spectrumView, view: toolsView)
        
        // MARK: - Sliders
        colorPickerConstraints.addConstraintsToSlidersView(slidersView, view: toolsView)

        slidersConstraints.addConstraintsToSliderLabel(redLabel, view: slidersView)
        slidersConstraints.addConstraintsToSlider(redSlider, view: slidersView, parent: redLabel)
        slidersConstraints.addConstraintsToSliderTF(redTF, view: slidersView, parent: redLabel)

        slidersConstraints.addConstraintsToSliderLabel(greenLabel, view: slidersView, parent: redSlider)
        slidersConstraints.addConstraintsToSlider(greenSlider, view: slidersView, parent: greenLabel)
        slidersConstraints.addConstraintsToSliderTF(greenTF, view: slidersView, parent: greenLabel)

        slidersConstraints.addConstraintsToSliderLabel(blueLabel, view: slidersView, parent: greenSlider)
        slidersConstraints.addConstraintsToSlider(blueSlider, view: slidersView, parent: blueLabel)
        slidersConstraints.addConstraintsToSliderTF(blueTF, view: slidersView, parent: blueLabel)
        
        slidersConstraints.addConstraintsToSliderTF(hexColorTF, view: slidersView, parent: blueSlider, topConstant: 28.0)
        slidersConstraints.addConstraintsToHexLabel(hexColorLabel, parent: hexColorTF, slider: blueSlider)
        
        // MARK: - Opacity
        slidersConstraints.addConstraintsToSliderLabel(opacityLabel, view: self, parent: toolsView, topConstant: 20.0, leftConstant: 20.0)
        slidersConstraints.addConstraintsToSlider(opacitySlider, view: self, parent: opacityLabel, leftConstant: 16.0)
        slidersConstraints.addConstraintsToSliderTF(opacityTF, view: self, parent: opacityLabel, rightConstant: -16.0)
        
        // MARK: - Separator
        colorPickerConstraints.addConstraintsToSeparator(separatingLineView, view: self, parent: opacitySlider)
        
        // MARK: - Colors
        colorPickerConstraints.addConstraintsToCurrentColor(currentColorView, view: self, parent: separatingLineView)
    }
}
