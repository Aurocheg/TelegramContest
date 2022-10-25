//
//  EditorView.swift
//  TelegramContest
//
//  Created by Aurocheg on 14.10.22.
//

import UIKit

final class EditorView: UIView {
    // MARK: - Constraints
    private let editorConstraints = EditorConstraints()
    
    // MARK: - Init UI Elements
    public let undoButton: UIButton = {
        let button = Button(image: UIImage(named: "undo"), background: .no)
        button.isUserInteractionEnabled = true
        button.isEnabled = false
        return button
    }()
    
    public let clearAllButton: UIButton = {
        let button = Button(background: .no)
        button.setTitle("Clear All", for: .normal)
        let color = UIColor(red: 1, green: 1, blue: 1, alpha: 0.4)
        button.setTitleColor(color, for: .disabled)
        button.isEnabled = false
        return button
    }()

    public let toolsView = UIView()
    public let colorPickerButton = Button(image: UIImage(named: "colorPicker"), background: .no)
    public let addButton = Button(image: UIImage(named: "add"), background: .dark)
    public let brushesCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 17.0, height: 93.0)
        layout.minimumLineSpacing = 27.0
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        
        return collectionView
    }()
    public let cancelButton = Button(image: UIImage(named: "cancel"), background: .no)
    public let segmentedControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl(items: ["Draw", "Text"])
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.backgroundColor = .black
        
        return segmentedControl
    }()
    public let downloadButton: UIButton = {
        let button = Button(image: UIImage(named: "download"), background: .no)
        button.isEnabled = false
        return button
    }()
    
    public let sizeView: UIView = {
        let view = UIView()
        view.isHidden = true
        return view
    }()
    public let sizeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        return imageView
    }()
    public let sizeBackButton = Button(image: UIImage(named: "back"), background: .no)
    public let sizeSliderView = SizeSliderView()
    public let sizeSlider: UISlider = {
        let slider = UISlider()
        let size = CGSize(width: 28.0, height: 28.0)
        
        let thumbView = UIView()
        thumbView.backgroundColor = .white
        let thumb = slider.thumbImage(radius: 28.0, thumbView: thumbView, size: size)
        
        slider.minimumValue = 1.0
        slider.maximumValue = 40.0
        slider.setThumbImage(thumb, for: .normal)
        slider.setMinimumTrackImage(UIImage(), for: .normal)
        slider.setMaximumTrackImage(UIImage(), for: .normal)
        return slider
    }()
    public let sizeActionButton: UIButton = {
        let button = UIButton()
        
        button.setTitle("Round", for: .normal)
        button.imageEdgeInsets = UIEdgeInsets(top: 0.0, left: 8.0, bottom: 0.0, right: 0.0)
        button.setImage(UIImage(named: "roundTip"), for: .normal)
        button.semanticContentAttribute = .forceRightToLeft
        
        return button
    }()

    // MARK: - Init Method
    init() {
        super.init(frame: .zero)
        
        backgroundColor = .black
        
        initViews()
        initConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Init Views Method
    private func initViews() {
        addSubview(undoButton)
        addSubview(clearAllButton)
                
        addSubview(toolsView)
        toolsView.addSubview(colorPickerButton)
        toolsView.addSubview(brushesCollectionView)
        toolsView.addSubview(addButton)
        toolsView.addSubview(cancelButton)
        toolsView.addSubview(segmentedControl)
        toolsView.addSubview(downloadButton)
        
        addSubview(sizeView)
        sizeView.addSubview(sizeImageView)
        sizeView.addSubview(sizeBackButton)
        sizeView.addSubview(sizeSliderView)
        sizeView.addSubview(sizeSlider)
        sizeView.addSubview(sizeActionButton)
    }
    
    // MARK: - Init Constraints Method
    private func initConstraints() {
        editorConstraints.addConstraintsToTopButton(undoButton, view: self, position: .left)
        editorConstraints.addConstraintsToTopButton(clearAllButton, view: self, position: .right)
                
        editorConstraints.addConstraintsToToolsView(toolsView, view: self)
        editorConstraints.addConstraintsToBottomButton(colorPickerButton, view: toolsView, parent: cancelButton, bottomConstant: -16.0, position: .left)
        editorConstraints.addConstraintsToBrushesCollection(brushesCollectionView, parent: colorPickerButton, segmentedControl: segmentedControl, view: toolsView)
        editorConstraints.addConstraintsToBottomButton(addButton, view: toolsView, parent: downloadButton, bottomConstant: -16.0, position: .right)
        editorConstraints.addConstraintsToBottomButton(cancelButton, view: toolsView, bottomConstant: 0.0, position: .left)
        editorConstraints.addConstraintsToSegmentedControl(segmentedControl, view: toolsView)
        editorConstraints.addConstraintsToBottomButton(downloadButton, view: toolsView, bottomConstant: 0.0, position: .right)
        
        editorConstraints.addConstraintsToSizeView(sizeView, view: self)
        editorConstraints.addConstraintsToSizeImage(sizeImageView, sizeView: sizeView)
        editorConstraints.addConstraintsToSizeBack(sizeBackButton, sizeView: sizeView)
        editorConstraints.addConstraintsToSizeSlider(sizeSlider, sizeView: sizeView, parent: sizeBackButton)
        editorConstraints.addConstraintsToSizeSliderView(sizeSliderView, sizeSlider: sizeSlider)
        editorConstraints.addConstraintsToSizeActionButton(sizeActionButton, sizeView: sizeView, slider: sizeSlider)
    }
}
