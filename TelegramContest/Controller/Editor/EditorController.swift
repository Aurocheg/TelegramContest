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
    
    // MARK: - Transfer Data
    public var galleryImage: UIImage! = nil
    
    // MARK: - Transition
    private let transition = PanelTransition()
    
    // MARK: - UI Elements
    public var undoButton: UIButton {
        editorView.undoButton
    }
    
    private var clearAllButton: UIButton {
        editorView.clearAllButton
    }

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
    private var downloadButton: UIButton {
        editorView.downloadButton
    }
    
    private var sizeView: UIView {
        editorView.sizeView
    }
    private var sizeActionButton: UIButton {
        editorView.sizeActionButton
    }
    private var sizeBackButton: UIButton {
        editorView.sizeBackButton
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
        
        brushesCollectionView.transform = CGAffineTransform(translationX: 0, y: 27.0)
        
        // MARK: - Canvas
        canvasView.backgroundColor = UIColor(patternImage: galleryImage)
        view.addSubview(canvasView)
        editorConstraints.addConstraintsToCanvas(canvasView, view: view, parent: clearAllButton)
                                
        // MARK: - Size Menu
        sizeInteraction = UIContextMenuInteraction(delegate: self)
        sizeActionButton.addInteraction(sizeInteraction!)
        
        shapesInteraction = UIContextMenuInteraction(delegate: self)
        addButton.addInteraction(shapesInteraction!)
        
        // MARK: - Connections
        brushesCollectionView.delegate = self
        brushesCollectionView.dataSource = self
        
        // MARK: - Register
        brushesCollectionView.register(BrushCollectionCell.self, forCellWithReuseIdentifier: brushesCellID)

        // MARK: - Targets
        undoButton.addTarget(self, action: #selector(undoButtonTapped), for: .touchUpInside)
        clearAllButton.addTarget(self, action: #selector(clearAllButtonTapped), for: .touchUpInside)
        colorPickerButton.addTarget(self, action: #selector(colorPickerButtonTapped), for: .touchUpInside)
        cancelButton.addTarget(self, action: #selector(cancelButtonTapped), for: .touchUpInside)
        sizeBackButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        
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
                } else {
                    self!.undoButton.isEnabled = false
                    self!.clearAllButton.isEnabled = false
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
    
    @objc func backButtonTapped() {
        sizeView.isHidden = true
        toolsView.isHidden = false
    }
}

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

extension EditorController: UICollectionViewDelegate {
    
}

// MARK: - UICollectionViewDataSource
extension EditorController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        brushes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: brushesCellID, for: indexPath) as? BrushCollectionCell else {
            return UICollectionViewCell()
        }
        cell.brushImageView.image = brushes[indexPath.row].brush
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)!
        UIView.animate(withDuration: 0.2) {
            cell.transform = CGAffineTransform(translationX: 0, y: -12.0)
        }
        
        toolsView.isHidden = true
        sizeView.isHidden = false
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)!
        UIView.animate(withDuration: 0.2) {
            cell.transform = CGAffineTransform(translationX: 0, y: 0.0)
        }
    }
}
