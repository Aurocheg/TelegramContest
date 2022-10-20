//
//  EditorController.swift
//  TelegramContest
//
//  Created by Aurocheg on 14.10.22.
//

import UIKit

final class EditorController: UIViewController {
    private let editorView = EditorView()
    
    // MARK: - Model Init
    private let brushes = BrushesModel.getBrushes()
    private let brushesCellID = BrushesModel.cellID
    
    // MARK: - Transfer Data
    public var galleryImage: UIImage! = nil
    
    // MARK: - Transition
    private let transition = PanelTransition()
    
    // MARK: - UI Elements
    private var canvasView: UIView {
        editorView.canvasView
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
    
    // MARK: - Life Cycle
    override func loadView() {
        view = editorView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // MARK: - Connections
        brushesCollectionView.delegate = self
        brushesCollectionView.dataSource = self
        
        // MARK: - Register
        brushesCollectionView.register(BrushCollectionCell.self, forCellWithReuseIdentifier: brushesCellID)
        
        // MARK: - Transfer Image from Gallery to Editor
        canvasView.backgroundColor = UIColor(patternImage: galleryImage)
        
        // MARK: - Targets
        colorPickerButton.addTarget(self, action: #selector(colorPickerButtonTapped), for: .touchUpInside)
        cancelButton.addTarget(self, action: #selector(cancelButtonTapped), for: .touchUpInside)
    }
    
    // MARK: - @objc
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
