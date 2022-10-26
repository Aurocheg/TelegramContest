//
//  EditorController.swift
//  TelegramContest
//
//  Created by Aurocheg on 14.10.22.
//

import UIKit

final class EditorController: UIViewController {
    // MARK: - Variables
    private var isLineExisting = false
    
    // MARK: - Constraints
    private let editorConstraints = EditorConstraints()
    
    // MARK: - Views
    private let editorView = EditorView()
    private let canvasView = CanvasView()
    
    // MARK: - Model Init
    private let brushesModel = BrushesModel()
    private var brushes: [BrushesModel] {
        brushesModel.getBrushes()
    }
    private let brushesCellID = BrushesModel.cellID
    
    private let fonts = FontsModel.getFonts()
    private let fontsCellID = FontsModel.cellID
    
    // MARK: - Transfer Data
    public var galleryImage: UIImage! = nil
    
    // MARK: - Transition
    private let transition = PanelTransition()
    
    // MARK: - Top Elements
    public var undoButton: UIButton {
        editorView.undoButton
    }
    
    private var clearAllButton: UIButton {
        editorView.clearAllButton
    }
    
    // MARK: - Canvas
    private var mainCanvasView: UIView {
        editorView.mainCanvasView
    }
    
    private var imageView: UIImageView {
        editorView.imageView
    }

    // MARK: - Tools Elements
    private var toolsView: UIView {
        editorView.toolsView
    }
    
    private var colorPickerButton: UIButton {
        editorView.colorPickerButton
    }
    
    private var addButton: UIButton {
        editorView.addButton
    }
    
    private var brushesCollectionView: UICollectionView {
        editorView.brushesCollectionView
    }
    
    private var cancelButton: UIButton {
        editorView.cancelButton
    }
    
    private var segmentedControl: UISegmentedControl {
        editorView.segmentedControl
    }
    
    private var downloadButton: UIButton {
        editorView.downloadButton
    }
    
    // MARK: - Size Elements
    private var sizeView: UIView {
        editorView.sizeView
    }
    
    private var sizeImageView: UIImageView {
        editorView.sizeImageView
    }
    
    private var sizeActionButton: UIButton {
        editorView.sizeActionButton
    }
    
    private var sizeBackButton: UIButton {
        editorView.sizeBackButton
    }
    
    private var sizeSlider: UISlider {
        editorView.sizeSlider
    }
    
    // MARK: - Text Elements
    private var textMainView: UIView {
        editorView.textMainView
    }
    
    private var textView: UITextView {
        editorView.textView
    }
    
    private var textSizeSlider: UISlider {
        editorView.textSizeSlider
    }
    
    private var textSizeSliderView: UIView {
        editorView.textSizeSliderView
    }
    
    private var weightButton: UIButton {
        editorView.weightButton
    }
    
    private var alignmentButton: UIButton {
        editorView.alignmentButton
    }
    
    private var fontsCollectionView: UICollectionView {
        editorView.fontsCollectionView
    }
    
    // MARK: - Interactions
    private var sizeInteraction: UIContextMenuInteraction? = nil
    private var shapesInteraction: UIContextMenuInteraction? = nil
    
    // MARK: - View Life Cycle
    override func loadView() {
        view = editorView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = true
        
        // MARK: - Transforms
        brushesCollectionView.transform = CGAffineTransform(translationX: 0, y: 27.0)
        sizeImageView.transform = CGAffineTransform(translationX: -130.0, y: 0.0)
        
        // MARK: - Canvas
        canvasView.isUserInteractionEnabled = false
        imageView.image = galleryImage
        mainCanvasView.addSubview(canvasView)
        editorConstraints.addConstraintsToCanvas(canvasView, view: mainCanvasView)
        
        sizeSlider.value = Float(canvasView.strokeWidth)
                                
        // MARK: - Size Menu
        sizeInteraction = UIContextMenuInteraction(delegate: self)
        sizeActionButton.addInteraction(sizeInteraction!)
        
        shapesInteraction = UIContextMenuInteraction(delegate: self)
        addButton.addInteraction(shapesInteraction!)
        
        // MARK: - Connections
        brushesCollectionView.dataSource = self
        brushesCollectionView.delegate = self
        textView.delegate = self
        fontsCollectionView.dataSource = self
        fontsCollectionView.delegate = self
        
        // MARK: - Register
        brushesCollectionView.register(BrushCollectionCell.self, forCellWithReuseIdentifier: brushesCellID)
        fontsCollectionView.register(FontsCollectionCell.self, forCellWithReuseIdentifier: fontsCellID)

        // MARK: - Targets
        undoButton.addTarget(self, action: #selector(undoButtonTapped), for: .touchUpInside)
        clearAllButton.addTarget(self, action: #selector(clearAllButtonTapped), for: .touchUpInside)
        colorPickerButton.addTarget(self, action: #selector(colorPickerButtonTapped), for: .touchUpInside)
        cancelButton.addTarget(self, action: #selector(cancelButtonTapped), for: .touchUpInside)
        segmentedControl.addTarget(self, action: #selector(segmentedControlValueChanged), for: .valueChanged)
        downloadButton.addTarget(self, action: #selector(downloadButtonTapped), for: .touchUpInside)
        sizeBackButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        sizeSlider.addTarget(self, action: #selector(sizeSliderChanged), for: .valueChanged)
        
        let colorPickerController = ColorPickerController.self
        colorPickerController.brushColorDidChange = {[weak self] color in
            DispatchQueue.main.async {
                self!.canvasView.strokeColor = color
            }
        }
        
        let canvasView = CanvasView.self
        canvasView.onLineCreating = {[weak self] bool in
            DispatchQueue.main.async {
                self!.isLineExisting = bool
                
                if self!.isLineExisting {
                    self!.undoButton.isEnabled = true
                    self!.clearAllButton.isEnabled = true
                    self!.downloadButton.isEnabled = true
                } else {
                    self!.undoButton.isEnabled = false
                    self!.clearAllButton.isEnabled = false
                    self?.downloadButton.isEnabled = false
                }
            }
        }
    }
    
    // MARK: - @objc
    @objc func undoButtonTapped() {
        canvasView.undoDraw()
    }
    
    @objc func clearAllButtonTapped() {
        canvasView.clearCanvasView()
    }
    
    @objc func colorPickerButtonTapped() {
        let colorPickerController = ColorPickerController()
        colorPickerController.transitioningDelegate = transition
        colorPickerController.modalPresentationStyle = .custom
        
        present(colorPickerController, animated: true)
    }
    
    @objc func cancelButtonTapped() {
        dismiss(animated: true)
    }
    
    @objc func segmentedControlValueChanged() {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            brushesCollectionView.isHidden = false
            textMainView.isHidden = true
        case 1:
            brushesCollectionView.isHidden = true
            textMainView.isHidden = false
            canvasView.addSubview(textView)
            canvasView.addSubview(textSizeSlider)
            canvasView.addSubview(textSizeSliderView)
            editorConstraints.addConstraintsToTextView(textView, canvasView: canvasView)
        default:
            break
        }
    }
    
    @objc func downloadButtonTapped() {
        let image = mainCanvasView.takeScreenshot()
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(imageSaved(_:didFinishSavingWithError:contextType:)), nil)
    }
    
    @objc func imageSaved(_ image: UIImage, didFinishSavingWithError error: Error?, contextType: UnsafeRawPointer) {
        if let error = error {
            let ac = UIAlertController(title: "Save error", message: error.localizedDescription, preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            present(ac, animated: true)
        } else {
            let ac = UIAlertController(title: "Saved!", message: "Your altered image has been saved to your photos.", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            present(ac, animated: true)
        }
    }
    
    @objc func backButtonTapped() {
        UIView.animate(withDuration: 0.3) {
            self.sizeImageView.transform = CGAffineTransform(translationX: -130.0, y: 0.0)
        }

        sizeView.isHidden = true
        toolsView.isHidden = false
    }
    
    @objc func sizeSliderChanged() {
        canvasView.strokeWidth = CGFloat(sizeSlider.value)
    }
}


// MARK: - UIContextMenuInteractionDelegate
extension EditorController: UIContextMenuInteractionDelegate {
    func contextMenuInteraction(_ interaction: UIContextMenuInteraction, configurationForMenuAtLocation location: CGPoint) -> UIContextMenuConfiguration? {
        switch interaction {
        case sizeInteraction:
            let round = UIAction(title: "Round", image: UIImage(named: "roundTip")) {_ in
              // Perform action
            }

            let arrow = UIAction(title: "Arrow", image: UIImage(named: "arrowTip")) {action in
              // Perform action
            }

            return UIContextMenuConfiguration(actionProvider:  {_ in
                UIMenu(title: "", children: [round, arrow])
            })
        case shapesInteraction:
            let rectangle = UIAction(title: "Rectangle", image: UIImage(named: "shapeRectangle")) {action in
                
            }
            let ellipse = UIAction(title: "Ellipse", image: UIImage(named: "shapeEllipse")) {action in
                
            }
            let bubble = UIAction(title: "Bubble", image: UIImage(named: "shapeBubble")) {action in
                
            }
            let star = UIAction(title: "Star", image: UIImage(named: "shapeStar")) {action in
                
            }
            let arrow = UIAction(title: "Arrow", image: UIImage(named: "shapeArrow")) {action in
                
            }
            return UIContextMenuConfiguration(actionProvider: {_ in
                UIMenu(title: "", children: [rectangle, ellipse, bubble, star, arrow])
            })
        default:
            return UIContextMenuConfiguration(actionProvider: {_ in
                UIMenu()
            })
        }
    }
}

// MARK: - UICollectionViewDelegate
extension EditorController: UICollectionViewDelegate {
    
}

// MARK: - UICollectionViewDataSource
extension EditorController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case brushesCollectionView:
            return brushes.count
        case fontsCollectionView:
            return fonts.count
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        case brushesCollectionView:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: brushesCellID, for: indexPath) as? BrushCollectionCell else {
                return UICollectionViewCell()
            }
            cell.brushImageView.image = brushes[indexPath.row].brush
            
            return cell
        case fontsCollectionView:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: fontsCellID, for: indexPath) as? FontsCollectionCell else {
                return UICollectionViewCell()
            }
            let font = fonts[indexPath.row]
            cell.fontButton.setTitle(font.fontName, for: .normal)
            return cell
        default:
            return UICollectionViewCell()
        }

    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch collectionView {
        case brushesCollectionView:
            guard let cell = collectionView.cellForItem(at: indexPath) as? BrushCollectionCell else { return }
            UIView.animate(withDuration: 0.2) {
                cell.transform = CGAffineTransform(translationX: 0, y: -12.0)
            }
            
            if !(indexPath.row > 2) {
                sizeImageView.image = cell.brushImageView.image
                UIView.animate(withDuration: 0.3) {
                    self.sizeImageView.transform = CGAffineTransform(translationX: 0.0, y: 0.0)
                }
                toolsView.isHidden = true
                sizeView.isHidden = false
            }
        default:
            break
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)!
        UIView.animate(withDuration: 0.2) {
            cell.transform = CGAffineTransform(translationX: 0, y: 0.0)
        }
    }
}

// MARK: - UITextViewDelegate
extension EditorController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        let fixedWidth = textView.frame.size.width
        textView.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude))
        let newSize = textView.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude))
        var newFrame = textView.frame
        newFrame.size = CGSize(width: max(newSize.width, fixedWidth), height: newSize.height)
        textView.frame = newFrame
    }
}
