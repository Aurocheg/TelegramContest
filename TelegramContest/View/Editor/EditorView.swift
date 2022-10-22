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
        return button
    }()
    
    public let clearAllButton: UIButton = {
        let button = Button(background: .no)
        button.setTitle("Clear All", for: .normal)
        let color = UIColor(red: 1, green: 1, blue: 1, alpha: 0.4)
        button.setTitleColor(color, for: .disabled)
        return button
    }()
    

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
        
        return segmentedControl
    }()
    
    public let downloadButton: UIButton = {
        let button = Button(image: UIImage(named: "download"), background: .no)
        button.isEnabled = false
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
                        
        addSubview(colorPickerButton)
        addSubview(brushesCollectionView)
        addSubview(addButton)
        
        addSubview(cancelButton)
        addSubview(segmentedControl)
        addSubview(downloadButton)        
    }
    
    // MARK: - Init Constraints Method
    private func initConstraints() {
        editorConstraints.addConstraintsToTopButton(undoButton, view: self, position: .left)
        editorConstraints.addConstraintsToTopButton(clearAllButton, view: self, position: .right)
                
        editorConstraints.addConstraintsToBottomButton(colorPickerButton, view: self, parent: cancelButton, bottomConstant: -16.0, position: .left)
        editorConstraints.addConstraintsToBrushesCollection(brushesCollectionView, parent: colorPickerButton, segmentedControl: segmentedControl, view: self)
        editorConstraints.addConstraintsToBottomButton(addButton, view: self, parent: downloadButton, bottomConstant: -16.0, position: .right)
        
        editorConstraints.addConstraintsToBottomButton(cancelButton, view: self, bottomConstant: -42.0, position: .left)
        editorConstraints.addConstraintsToSegmentedControl(segmentedControl, view: self)
        editorConstraints.addConstraintsToBottomButton(downloadButton, view: self, bottomConstant: -42.0, position: .right)
    }
    
}
