//
//  EditorController.swift
//  TelegramContest
//
//  Created by Aurocheg on 14.10.22.
//

import UIKit

final class EditorController: UIViewController {
    // MARK: - Constraints
    private let editorConstraints = EditorConstraints()
    
    // MARK: - Views
    private let editorView = EditorView()
    private let canvasView = CanvasView()
    
    // MARK: - Model Init
    private let brushes = BrushesModel.getBrushes()
    private let brushesCellID = BrushesModel.cellID
    
    // MARK: - Variables
    
    // MARK: - Transfer Data
    public var galleryImage: UIImage! = nil
    
    // MARK: - Transition
    private let transition = PanelTransition()
    
    // MARK: - UI Elements
    private var undoButton: UIButton {
        editorView.undoButton
    }
    
    private var clearAllButton: UIButton {
        editorView.clearAllButton
    }

    private var colorPickerButton: UIButton {
        editorView.colorPickerButton
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
    
    // MARK: - View Life Cycle
    override func loadView() {
        view = editorView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // MARK: - Canvas
        canvasView.backgroundColor = UIColor(patternImage: galleryImage)
        view.addSubview(canvasView)
        editorConstraints.addConstraintsToCanvas(canvasView, view: view, parent: clearAllButton)

                                
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
        cell.brushImageView.image = UIImage(named: brushes[indexPath.row].brush)
        return cell
    }
}
