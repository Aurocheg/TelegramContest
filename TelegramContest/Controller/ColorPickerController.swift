//
//  ColorPickerController.swift
//  TelegramContest
//
//  Created by Aurocheg on 16.10.22.
//

import UIKit

final class ColorPickerController: UIViewController {
    private let colorPickerView = ColorPickerView()
    
    // MARK: - UI Elements
    private var closeButton: UIButton {
        colorPickerView.closeButton
    }
    
    override func loadView() {
        view = colorPickerView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // MARK: - Targets
        closeButton.addTarget(self, action: #selector(closeButtonTapped(_:)), for: .touchUpInside)
    }
    
    // MARK: - @objc
    @objc func closeButtonTapped(_ sender: UIButton) {
        if sender == closeButton {
            dismiss(animated: true)
        }
    }
}
