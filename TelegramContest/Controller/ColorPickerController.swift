//
//  ColorPickerController.swift
//  TelegramContest
//
//  Created by Aurocheg on 16.10.22.
//

import UIKit

final class ColorPickerController: UIViewController {
    private let colorPickerView = ColorPickerView()
    
    var tag = 0
    var color = UIColor.gray
    
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
        
        gridColorsCollectionView.delegate = self
        gridColorsCollectionView.dataSource = self
        
        // MARK: - Register
        gridColorsCollectionView.register(GridCollectionCell.self, forCellWithReuseIdentifier: "gridCollectionCell")
        
        // MARK: - Targets
        closeButton.addTarget(self, action: #selector(closeButtonTapped(_:)), for: .touchUpInside)
        segmentedControl.addTarget(self, action: #selector(segmentedControlChanged(_:)), for: .valueChanged)
        
        // MARK: - Dispatch
        let spectrumView = SpectrumView.self
        spectrumView.onColorDidChange = {[weak self] color in
            DispatchQueue.main.async {
                self!.currentColorView.backgroundColor = color
            }
        }
    }
    
    // MARK: - Methods
    private func hexStringToUIColor(_ hex: String) -> UIColor {
        var cString = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if cString.hasPrefix("#") {
            cString.remove(at: cString.startIndex)
        }
        
        if cString.count != 6 {
            return UIColor.gray
        }
        
        var rgbValue: UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
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

extension ColorPickerController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        120
    }
}

extension ColorPickerController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "gridCollectionCell", for: indexPath) as? GridCollectionCell else {
            return UICollectionViewCell()
        }
        
        var colorPalette: Array<String>
        let path = Bundle.main.path(forResource: "colorPalette", ofType: "plist")
        let plistArray = NSArray(contentsOfFile: path!)
        
        cell.tag = tag
        
        if let colorPalettePlistFile = plistArray {
            colorPalette = colorPalettePlistFile as! [String]
            
            let hexString = colorPalette[cell.tag]
            color = hexStringToUIColor(hexString)
        }
        
        cell.backgroundColor = color
        tag += 1
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        var colorPalette: Array<String>
        
        let path = Bundle.main.path(forResource: "colorPalette", ofType: "plist")
        let plistArray = NSArray(contentsOfFile: path!)
        
        if let colorPalettePlistFile = plistArray {
            colorPalette = colorPalettePlistFile as! [String]
            
            let cell = collectionView.cellForItem(at: indexPath) as! GridCollectionCell
            
            let hexString = colorPalette[cell.tag]
            color = hexStringToUIColor(hexString)
            currentColorView.backgroundColor = color
            
        }
    }
}
