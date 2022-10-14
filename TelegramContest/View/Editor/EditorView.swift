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
        let button = UIButton()
        let size = CGSize(width: 16.0, height: 16.0)
        
        if let image = UIImage(named: "undo") {
            return button.createButton(size: size, image: image, background: .no)
        }
        
        return button
    }()
    
    public let clearAllButton: UIButton = {
        var button = UIButton()
        let size = CGSize(width: 64.0, height: 22.0)
        button = button.createButton(size: size, background: .no)
        button.tintColor = .white
        button.setTitle("Clear All", for: .normal)
        return button
    }()
    
    public let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        return imageView
    }()
    
    public let colorPickerButton: UIButton = {
        let button = UIButton()
        let size = CGSize(width: 30.0, height: 30.0)
        
        return button.createButton(size: size, image: UIImage(named: "colorPicker"), background: .no)
    }()
    
    public let addButton: UIButton = {
        let button = UIButton()
        return button.createButton(image: UIImage(named: "add"), background: .yes)
    }()
    
    public let brushesCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 17.0, height: 93.0)
        layout.minimumLineSpacing = 27.0
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        
        return collectionView
    }()
    
    public let cancelButton: UIButton = {
        let button = UIButton()
        return button.createButton(image: UIImage(named: "cancel"), background: .no)
    }()
    
    public let segmentedControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl(items: ["Draw", "Text"])
        segmentedControl.selectedSegmentIndex = 0
        
        return segmentedControl
    }()
    
    public let downloadButton: UIButton = {
        let button = UIButton()
        return button.createButton(image: UIImage(named: "download"), background: .no)
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
        
        addSubview(imageView)
        
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
        
        editorConstraints.addConstraintsToImage(imageView, view: self, parent: clearAllButton)
        
        editorConstraints.addConstraintsToBottomButton(colorPickerButton, view: self, parent: imageView, topConstant: 72.0, position: .left)
        editorConstraints.addConstraintsToBrushesCollection(brushesCollectionView, parent: colorPickerButton, imageView: imageView, view: self)
        editorConstraints.addConstraintsToBottomButton(addButton, view: self, parent: imageView, topConstant: 72.0, position: .right)
        
        editorConstraints.addConstraintsToBottomButton(cancelButton, view: self, parent: colorPickerButton, topConstant: 16.0, position: .left)
        editorConstraints.addConstraintsToSegmentedControl(segmentedControl, view: self, collectionView: brushesCollectionView, parent: cancelButton)
        editorConstraints.addConstraintsToBottomButton(downloadButton, view: self, parent: addButton, topConstant: 16.0, position: .right)
    }
    
}
