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
    
    // MARK: - Top Elements
    public let eyeDropperButton: UIButton = {
        let button = UIButton()
        return button.createButton(image: UIImage(named: "eyeDropper"), background: .no)
    }()
    
    private let mainTitleLabel: UILabel = {
        let label = UILabel()
        return label.createLabel(text: "Colors", size: 17.0, weight: .semibold)
    }()
    
    public let closeButton: UIButton = {
        let button = UIButton()
        let size = CGSize(width: 30.0, height: 30.0)
        return button.createButton(size: size, image: UIImage(named: "cancel"), background: .yes)
    }()
    
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
    
    // MARK: - Slider
    private let redLabel: UILabel = {
        let label = UILabel()
        return label.createLabel(text: "RED", size: 13.0, weight: .semibold)
    }()
    
    public let redSlider: UISlider = {
        let slider = UISlider()
        return slider.createSlider(minValue: 0.0, maxValue: 255.0)
    }()
    
    public let redTF: UITextField = {
        let tf = UITextField()
        return tf.createTF(currentText: "255")
    }()
    
    private let greenLabel: UILabel = {
        let label = UILabel()
        return label.createLabel(text: "GREEN", size: 13.0, weight: .semibold)
    }()
    
    public let greenSlider: UISlider = {
        let slider = UISlider()
        return slider.createSlider(minValue: 0.0, maxValue: 255.0)
    }()
    
    public let greenTF: UITextField = {
        let tf = UITextField()
        return tf.createTF(currentText: "145")
    }()
    
    private let blueLabel: UILabel = {
        let label = UILabel()
        return label.createLabel(text: "BLUE", size: 13.0, weight: .semibold)
    }()
    
    public let blueSlider: UISlider = {
        let slider = UISlider()
        return slider.createSlider(minValue: 0.0, maxValue: 255.0)
    }()
    
    public let blueTF: UITextField = {
        let tf = UITextField()
        return tf.createTF(currentText: "255")
    }()
    
    private let hexColorLabel: UILabel = {
        let label = UILabel()
        return label.createLabel(text: "Display P3 Hex Color #", size: 17.0, weight: .regular)
    }()
    
    public let hexColorTF: UITextField = {
        let tf = UITextField()
        return tf.createTF(currentText: "FF91FF")
    }()
    
    // MARK: - Opacity
    private let opacityLabel: UILabel = {
        let label = UILabel()
        return label.createLabel(text: "OPACITY", size: 13.0, weight: .semibold)
    }()
    
    public let opacitySlider: UISlider = {
        let slider = UISlider()
        return slider.createSlider(minValue: 0.0, maxValue: 100.0)
    }()
    
    public let opacityTF: UITextField = {
        let tf = UITextField()
        return tf.createTF(currentText: "100%")
    }()
    
    // MARK: - Colors
    private let separatingLineView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0.282, green: 0.282, blue: 0.29, alpha: 1)
        return view
    }()
    
    public let currentColorView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 10.0
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
        
        backgroundColor = .systemGray6
        
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
        
        // MARK: - RED
//        addSubview(redLabel)
//        addSubview(redSlider)
//        addSubview(redTF)
//
//        // MARK: - GREEN
//        addSubview(greenLabel)
//        addSubview(greenSlider)
//        addSubview(greenTF)
//
//        // MARK: - BLUE
//        addSubview(blueLabel)
//        addSubview(blueSlider)
//        addSubview(blueTF)
        
        // MARK: Hex
//        addSubview(hexColorLabel)
//        addSubview(hexColorTF)
//
//        // MARK: - Opacity
//        addSubview(opacityLabel)
//        addSubview(opacitySlider)
//        addSubview(opacityTF)
//
//        // MARK: - Separator
//        addSubview(separatingLineView)
//
//        // MARK: - Colors
//        addSubview(currentColorView)
//        addSubview(colorsCollectionView)
    }
    
    // MARK: - Init Constraints Method
    private func initConstraints() {
        // MARK: - Top
        colorPickerConstraints.addConstraintsToToolButton(eyeDropperButton, view: self, position: .left, size: CGSize(width: 23.0, height: 23.0))
        colorPickerConstraints.addConstraintsToMainTitle(mainTitleLabel, view: self)
        colorPickerConstraints.addConstraintsToToolButton(closeButton, view: self, position: .right)
        colorPickerConstraints.addConstraintsToSegmentedControl(segmentedControl, view: self, parent: mainTitleLabel)
    }
}
