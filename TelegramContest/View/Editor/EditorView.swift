//
//  EditorView.swift
//  TelegramContest
//
//  Created by Aurocheg on 14.10.22.
//

import UIKit

// MARK: - ShapeType
enum ShapeType {
    case rectangle
    case ellipse
}

final class EditorView: UIView {
    // MARK: - Constraints
    private let editorConstraints = EditorConstraints()
    
    // MARK: - Top Elements
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
    
    // MARK: - Image
    public let mainCanvasView = UIView()
    public let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        return imageView
    }()
    public let canvasView = UIView()

    // MARK: - Tools
    public let toolsView = UIView()
    
    public let colorPickerButton = Button(image: UIImage(named: "colorPicker"), background: .no)
    
    public let addButton = Button(image: UIImage(named: "add"), background: .dark)
    
    public let brushesCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 17.0, height: 93.0)
        layout.minimumLineSpacing = 27.0
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.transform = CGAffineTransform(translationX: 0, y: 27.0)
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
    
    // MARK: - Size
    public let sizeView: UIView = {
        let view = UIView()
        view.isHidden = true
        return view
    }()
    
    public let sizeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.transform = CGAffineTransform(translationX: -130.0, y: 0.0)
        imageView.contentMode = .scaleToFill
        
        return imageView
    }()
    
    public var brushSizeView: UIView = {
        let view = UIView()
        view.frame = CGRect(x: 1.0, y: 53, width: 31.0, height: 10.0)
        view.backgroundColor = .white
        return view
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
    
    // MARK: - Text
    public let textMainView: UIView = {
        let view = UIView()
        view.isHidden = true
        return view
    }()
    
    public let textView: UITextView = {
        let textView = UITextView()

        textView.showsHorizontalScrollIndicator = false
        textView.showsVerticalScrollIndicator = false
        textView.isScrollEnabled = false
        
        textView.font = .systemFont(ofSize: 48.0)
        textView.backgroundColor = .clear
        textView.autocorrectionType = .no
        
        textView.becomeFirstResponder()
        
        return textView
    }()
    
    public let textSizeSliderView = SizeSliderView()
    public let textSizeSlider: UISlider = {
        let slider = UISlider()
        let size = CGSize(width: 28.0, height: 28.0)
        
        let thumbView = UIView()
        thumbView.backgroundColor = .white
        let thumb = slider.thumbImage(radius: 28.0, thumbView: thumbView, size: size)
        
        slider.minimumValue = 1.0
        slider.value = 10.0
        slider.maximumValue = 40.0
        slider.setThumbImage(thumb, for: .normal)
        slider.setMinimumTrackImage(UIImage(), for: .normal)
        slider.setMaximumTrackImage(UIImage(), for: .normal)
        return slider
    }()
    
    public let weightButton = Button(image: UIImage(named: "default"), background: .no)
    
    public let alignmentButton = Button(image: UIImage(named: "textLeft"), background: .no)
    
    public let fontsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.estimatedItemSize = CGSize(width: 49.0, height: 30.0)
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 12.0
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        
        return collectionView
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
        // MARK: - Top
        addSubview(undoButton)
        addSubview(clearAllButton)
        
        // MARK: - Image
        addSubview(mainCanvasView)
        mainCanvasView.addSubview(imageView)
        
        // MARK: - Tools
        addSubview(toolsView)
        toolsView.addSubview(colorPickerButton)
        toolsView.addSubview(brushesCollectionView)
        toolsView.addSubview(addButton)
        toolsView.addSubview(cancelButton)
        toolsView.addSubview(segmentedControl)
        toolsView.addSubview(downloadButton)

        // MARK: - Size
        addSubview(sizeView)
        sizeView.addSubview(sizeImageView)
        sizeImageView.addSubview(brushSizeView)
        sizeView.addSubview(sizeBackButton)
        sizeView.addSubview(sizeSliderView)
        sizeView.addSubview(sizeSlider)
        sizeView.addSubview(sizeActionButton)
        
        // MARK: - Text
        addSubview(textMainView)
        textMainView.addSubview(weightButton)
        textMainView.addSubview(alignmentButton)
        textMainView.addSubview(fontsCollectionView)
    }
    
    // MARK: - Init Constraints Method
    private func initConstraints() {
        // MARK: - Top
        editorConstraints.addConstraintsToTopButton(undoButton, view: self, position: .left)
        editorConstraints.addConstraintsToTopButton(clearAllButton, view: self, position: .right)
        
        // MARK: - Image
        editorConstraints.addConstraintsToMainCanvas(mainCanvasView, view: self, parent: clearAllButton)
        editorConstraints.addConstraintsToCanvas(imageView, view: mainCanvasView)
                
        // MARK: - Tools
        editorConstraints.addConstraintsToToolsView(toolsView, view: self)
        editorConstraints.addConstraintsToBottomButton(colorPickerButton, view: toolsView, parent: cancelButton, bottomConstant: -16.0, position: .left)
        editorConstraints.addConstraintsToBrushesCollection(brushesCollectionView, parent: colorPickerButton, segmentedControl: segmentedControl, view: toolsView)
        editorConstraints.addConstraintsToBottomButton(addButton, view: toolsView, parent: downloadButton, bottomConstant: -16.0, position: .right)
        editorConstraints.addConstraintsToBottomButton(cancelButton, view: toolsView, bottomConstant: 0.0, position: .left)
        editorConstraints.addConstraintsToSegmentedControl(segmentedControl, view: toolsView)
        editorConstraints.addConstraintsToBottomButton(downloadButton, view: toolsView, bottomConstant: 0.0, position: .right)
        
        // MARK: - Size
        editorConstraints.addConstraintsToSizeView(sizeView, view: self)
        editorConstraints.addConstraintsToSizeImage(sizeImageView, sizeView: sizeView)
        editorConstraints.addConstraintsToSizeBack(sizeBackButton, sizeView: sizeView)
        editorConstraints.addConstraintsToSizeSlider(sizeSlider, sizeView: sizeView, parent: sizeBackButton)
        editorConstraints.addConstraintsToSizeSliderView(sizeSliderView, sizeSlider: sizeSlider)
        editorConstraints.addConstraintsToSizeActionButton(sizeActionButton, sizeView: sizeView, slider: sizeSlider)
        
        // MARK: - Text
        editorConstraints.addConstraintsToTextMainView(textMainView: textMainView, view: self, parent: colorPickerButton, segmentedControl: segmentedControl)
        editorConstraints.addConstraintsToToolButton(weightButton, textMainView: textMainView)
        editorConstraints.addConstraintsToToolButton(alignmentButton, textMainView: textMainView, parent: weightButton)
        editorConstraints.addConstraintsToFontsCollection(fontsCollectionView, textMainView: textMainView, parent: alignmentButton)
    }
    
    // MARK: - Create Shape Method
    public func createStandardShape(imageView: UIImageView, size: CGSize, type: ShapeType) {
        let renderer = UIGraphicsImageRenderer(size: size)
        
        let image = renderer.image {ctx in
            let shape = CGRect(x: 0, y: 0, width: size.width, height: size.height)
            
            ctx.cgContext.setFillColor(UIColor.clear.cgColor)
            ctx.cgContext.setStrokeColor(UIColor.white.cgColor)
            ctx.cgContext.setLineWidth(1.0)
            
            switch type {
                case .rectangle: ctx.cgContext.addRect(shape)
                case .ellipse: ctx.cgContext.addEllipse(in: shape)
            }
            
            ctx.cgContext.drawPath(using: .fillStroke)
        }
        
        imageView.image = image
    }
}
