//
//  EditorController.swift
//  TelegramContest
//
//  Created by Aurocheg on 14.10.22.
//

import UIKit

final class EditorController: UIViewController {
    // MARK: - Variables
    static var strokeWidthDidChange: ((_ strokeWidth: CGFloat) -> ())?
    
    private let screenWidth = UIScreen.main.bounds.size.width
    private let screenHeight = UIScreen.main.bounds.size.height
    
    private var isLineExisting = false
    private var alignmentClicksNumber = 0
    
    // MARK: - Constraints
    private let editorConstraints = EditorConstraints()
    
    // MARK: - Views
    private let editorView = EditorView()
    private let canvasView = CanvasView()
    
    // MARK: - Models Init
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
    
    private var brushSizeView: UIView {
        editorView.brushSizeView
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
        
        // MARK: - Canvas
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
        alignmentButton.addTarget(self, action: #selector(alignmentButtonTapped), for: .touchUpInside)
        
        // MARK: - Dispatch
        brushColorDidChange()
        strokeWidthDidChange()
        lineCreating()
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
            editorConstraints.addConstraintsToTextSizeSlider(textSizeSlider, canvasView: canvasView, textView: textView)
            editorConstraints.addConstraintsToTextSizeSliderView(textSizeSliderView, textSizeSlider: textSizeSlider)
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
        let sliderValue = CGFloat(sizeSlider.value)
        canvasView.strokeWidth = sliderValue
        EditorController.strokeWidthDidChange?(sliderValue)
    }
    
    @objc func alignmentButtonTapped() {
        alignmentClicksNumber += 1
        
        switch alignmentClicksNumber {
            case 1:
                alignmentButton.setBackgroundImage(UIImage(named: "textCenter"), for: .normal)
                textView.textAlignment = .center
            case 2:
                alignmentButton.setBackgroundImage(UIImage(named: "textRight"), for: .normal)
                textView.textAlignment = .right
            case 3:
                alignmentButton.setBackgroundImage(UIImage(named: "textLeft"), for: .normal)
                textView.textAlignment = .left
                alignmentClicksNumber = 0
            default: break
        }
    }
    
    // MARK: - Methods
    private func brushColorDidChange(brushSizeView: UIView? = nil) {
        let colorPickerController = ColorPickerController.self
        colorPickerController.brushColorDidChange = {[weak self] color in
            DispatchQueue.main.async {
                self!.canvasView.strokeColor = color
                self!.brushSizeView.backgroundColor = color
                
                if let brushSizeView = brushSizeView {
                    brushSizeView.backgroundColor = color
                }
            }
        }
    }
    
    private func strokeWidthDidChange(brushSizeView: UIView? = nil) {
        let editorController = EditorController.self
        editorController.strokeWidthDidChange = {[weak self] width in
            DispatchQueue.main.async {
                self!.brushSizeView.frame.size.height = width / 2.0
                
                if let brushSizeView = brushSizeView {
                    brushSizeView.frame.size.height = width / 5.0
                }
            }
        }
    }
    
    private func lineCreating() {
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
    
    private func initShapeImageView(frame: CGRect) -> UIImageView {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.frame = frame
        return imageView
    }
    
    private func initShapeLayer(layer: CAShapeLayer) {
        layer.strokeColor = UIColor.white.cgColor
        layer.fillColor = UIColor.clear.cgColor
        layer.lineWidth = 2.0
    }
}

// MARK: - UIContextMenuInteractionDelegate
extension EditorController: UIContextMenuInteractionDelegate {
    func contextMenuInteraction(_ interaction: UIContextMenuInteraction, configurationForMenuAtLocation location: CGPoint) -> UIContextMenuConfiguration? {
        switch interaction {
        case sizeInteraction:
            let round = UIAction(title: "Round", image: UIImage(named: "roundTip")) {_ in

            }

            let arrow = UIAction(title: "Arrow", image: UIImage(named: "arrowTip")) {action in

            }

            return UIContextMenuConfiguration(actionProvider:  {_ in
                UIMenu(title: "", children: [round, arrow])
            })
        case shapesInteraction:
            let imageSize = CGSize(width: 200.0, height: 200.0)
            let imageFrame = CGRect(x: 125.0, y: 150.0, width: imageSize.width, height: imageSize.height)

            let rectangle = UIAction(title: "Rectangle", image: UIImage(named: "shapeRectangle")) {_ in
                let imageView = self.initShapeImageView(frame: imageFrame)
                self.editorView.createStandardShape(imageView: imageView, size: imageSize, type: .rectangle)
                self.imageView.addSubview(imageView)
            }
            
            let ellipse = UIAction(title: "Ellipse", image: UIImage(named: "shapeEllipse")) {_ in
                let imageView = self.initShapeImageView(frame: imageFrame)
                self.editorView.createStandardShape(imageView: imageView, size: imageSize, type: .ellipse)
                self.imageView.addSubview(imageView)
            }
            
            let bubble = UIAction(title: "Bubble", image: UIImage(named: "shapeBubble")) {_ in
                let imageView = self.initShapeImageView(frame: imageFrame)

                let bubbleLayer = CAShapeLayer()
                bubbleLayer.path = UIBezierPath.createBubble(contentSize: imageView.bounds.size).cgPath
                self.initShapeLayer(layer: bubbleLayer)
                
                imageView.layer.addSublayer(bubbleLayer)
                self.imageView.addSubview(imageView)
            }
            
            let star = UIAction(title: "Star", image: UIImage(named: "shapeStar")) {_ in
                let imageView = self.initShapeImageView(frame: imageFrame)
                
                let starLayer = CAShapeLayer()
                starLayer.path = UIBezierPath.createStar(in: imageView.bounds, corners: 5, smoothness: 0.45).cgPath
                self.initShapeLayer(layer: starLayer)

                imageView.layer.addSublayer(starLayer)
                self.imageView.addSubview(imageView)
            }
            
            let arrow = UIAction(title: "Arrow", image: UIImage(named: "shapeArrow")) {_ in
                let imageView = self.initShapeImageView(frame: imageFrame)
                
                let arrowLayer = CAShapeLayer()
                arrowLayer.path = UIBezierPath.createArrow(from: CGPoint(x: 50.0, y: 100.0), to: CGPoint(x: 200.0, y: 50.0), tailWidth: 10.0, headWidth: 25.0, headLength: 40.0).cgPath
                self.initShapeLayer(layer: arrowLayer)

                imageView.layer.addSublayer(arrowLayer)
                self.imageView.addSubview(imageView)
            }
            return UIContextMenuConfiguration(actionProvider: {_ in
                UIMenu(title: "", children: [rectangle, ellipse, bubble, star, arrow])
            })
        default:
            return UIContextMenuConfiguration()
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
            // MARK: - BrushesCollectionView
            case brushesCollectionView:
                return brushes.count
            // MARK: - FontsCollectionView
            case fontsCollectionView:
                return fonts.count
            default:
                return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
            // MARK: - BrushesCollectionView
            case brushesCollectionView:
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: brushesCellID, for: indexPath) as? BrushCollectionCell else {
                    return UICollectionViewCell()
                }
                
                if indexPath.row < 4 {
                    let brushSizeView = UIView()
                    let strokeWidth = canvasView.strokeWidth
                    
                    brushSizeView.frame = CGRect(x: 1.0, y: 35, width: cell.frame.width - 2.0, height: strokeWidth)
                    brushSizeView.backgroundColor = .white
                    
                    strokeWidthDidChange(brushSizeView: brushSizeView)
                    brushColorDidChange(brushSizeView: brushSizeView)
                                        
                    cell.addSubview(brushSizeView)
                }
                
                cell.brushImageView.image = brushes[indexPath.row].brush
                            
                return cell
            // MARK: - Fonts Collection View
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
            // MARK: - BrushesCollectionView
            case brushesCollectionView:
                guard let cell = collectionView.cellForItem(at: indexPath) as? BrushCollectionCell else { return }
                UIView.animate(withDuration: 0.2) {
                    cell.transform = CGAffineTransform(translationX: 0, y: -12.0)
                }
                
                if indexPath.row < 4 {
                    sizeImageView.image = cell.brushImageView.image
                    
                    UIView.animate(withDuration: 0.3) {
                        self.sizeImageView.transform = CGAffineTransform(translationX: 0.0, y: 0.0)
                    }
                    
                    toolsView.isHidden = true
                    sizeView.isHidden = false
                }
            // MARK: - FontsCollectionView
            case fontsCollectionView:
                guard let cell = collectionView.cellForItem(at: indexPath) as? FontsCollectionCell else { return }
                UIView.animate(withDuration: 0.2) {
                    cell.layer.borderColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor
                }
            default:
                break
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        switch collectionView {
            // MARK: - BrushesCollectionView
            case brushesCollectionView:
                guard let cell = collectionView.cellForItem(at: indexPath) as? BrushCollectionCell else { return }
                UIView.animate(withDuration: 0.2) {
                    cell.transform = CGAffineTransform(translationX: 0, y: 0.0)
                }
            // MARK: - FontsCollectionView
            case fontsCollectionView:
                guard let cell = collectionView.cellForItem(at: indexPath) as? FontsCollectionCell else { return }
                UIView.animate(withDuration: 0.2) {
                    cell.layer.borderColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.33).cgColor
                }
            default:
                break
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
