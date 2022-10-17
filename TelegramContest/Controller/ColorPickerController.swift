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
    
    private var segmentedControl: UISegmentedControl {
        colorPickerView.segmentedControl
    }
    
    private var gridColorsCollectionView: UICollectionView {
        colorPickerView.gridColorsCollectionView
    }
    
    private var spectrumView: UIView {
        colorPickerView.spectrumView
    }
    
    private var slidersView: UIView {
        colorPickerView.slidersView
    }
    
    private var currentColorView: UIView {
        colorPickerView.currentColorView
    }
    
    override func loadView() {
        view = colorPickerView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // MARK: - Register
        gridColorsCollectionView.register(GridCollectionCell.self, forCellWithReuseIdentifier: "gridCollectionCell")
        
        // MARK: - Targets
        closeButton.addTarget(self, action: #selector(closeButtonTapped(_:)), for: .touchUpInside)
        segmentedControl.addTarget(self, action: #selector(segmentedControlChanged(_:)), for: .valueChanged)
        
        // MARK: - Dispatc
        let spectrumView = SpectrumView.self
        spectrumView.onColorDidChange = {[weak self] color in
            DispatchQueue.main.async {
                self!.currentColorView.backgroundColor = color
            }
        }
    }
    
    // MARK: - @objc
    @objc func closeButtonTapped(_ sender: UIButton) {
        if sender == closeButton {
            dismiss(animated: true)
        }
    }
    
    @objc func segmentedControlChanged(_ sender: UISegmentedControl) {
        if sender == segmentedControl {
            switch segmentedControl.selectedSegmentIndex {
            case 0:
                gridColorsCollectionView.isHidden = false
                spectrumView.isHidden = true
                slidersView.isHidden = true
            case 1:
                gridColorsCollectionView.isHidden = true
                spectrumView.isHidden = false
                slidersView.isHidden = true
            case 2:
                gridColorsCollectionView.isHidden = true
                spectrumView.isHidden = true
                slidersView.isHidden = false
            default:
                print("error")
            }
        }
    }
}
