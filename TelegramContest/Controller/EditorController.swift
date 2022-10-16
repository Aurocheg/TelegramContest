//
//  EditorController.swift
//  TelegramContest
//
//  Created by Aurocheg on 14.10.22.
//

import UIKit

final class EditorController: UIViewController {
    private let editorView = EditorView()
    
    // MARK: - Transfer Data
    public var galleryImage: UIImage! = nil
    
    // MARK: - Transition
    private let transition = PanelTransition()
    
    // MARK: - UI Elements
    private var imageView: UIImageView {
        editorView.imageView
    }
    
    private var colorPickerButton: UIButton {
        editorView.colorPickerButton
    }
    
    // MARK: - Life Cycle
    override func loadView() {
        view = editorView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView.image = galleryImage
        
        // MARK: - Targets
        colorPickerButton.addTarget(self, action: #selector(colorPickerButtonTapped(_:)), for: .touchUpInside)
    }
    
    // MARK: - @objc
    @objc func colorPickerButtonTapped(_ sender: UIButton) {
        if sender == colorPickerButton {
            let colorPickerController = ColorPickerController()
            colorPickerController.transitioningDelegate = transition
            colorPickerController.modalPresentationStyle = .custom
            
            present(colorPickerController, animated: true)
        }
    }
}
