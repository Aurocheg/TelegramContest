//
//  ColorPickerController.swift
//  TelegramContest
//
//  Created by Aurocheg on 16.10.22.
//

import UIKit

final class ColorPickerController: UIViewController {
    private let colorPickerView = ColorPickerView()
    
    // MARK: - Global Variables
    var tag = 0
    var color = UIColor.gray
    
    // MARK: - UI Elements
    private var closeButton: UIButton {
        colorPickerView.closeButton
    }
    
    private var gridColorsCollectionView: UICollectionView {
        colorPickerView.gridColorsCollectionView
    }
    
    override func loadView() {
        view = colorPickerView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // MARK: - Connections
        gridColorsCollectionView.dataSource = self
        gridColorsCollectionView.delegate = self
        
        // MARK: - Register
        gridColorsCollectionView.register(GridCollectionCell.self, forCellWithReuseIdentifier: "gridCollectionCell")
        
        // MARK: - Targets
        closeButton.addTarget(self, action: #selector(closeButtonTapped(_:)), for: .touchUpInside)
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
        
        return UIColor(red: CGFloat((rgbValue & 0xFF0000 >> 16) / 255),
                       green: CGFloat((rgbValue & 0x00FF00 >> 8) / 255),
                       blue: CGFloat((rgbValue & 0x0000FF) / 255),
                       alpha: CGFloat(1.0))
    }
    
    // MARK: - @objc
    @objc func closeButtonTapped(_ sender: UIButton) {
        if sender == closeButton {
            dismiss(animated: true)
        }
    }
}

// MARK: - UICollectionViewDelegate
extension ColorPickerController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 16
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "gridCollectionCell", for: indexPath)
        cell.backgroundColor = .clear
        cell.tag = tag
        tag = tag + 1
        return cell
    }
}

// MARK: - UICollectionViewDataSource
extension ColorPickerController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        var colorPalette: Array<String>
        
        let path = Bundle.main.path(forResource: "colorPalette", ofType: "plist")
        let pListArray = NSArray(contentsOfFile: path!)
        
        if let colorPalettePlistFile = pListArray {
            colorPalette = colorPalettePlistFile as! [String]
            
            let cell = collectionView.cellForItem(at: indexPath)! as UICollectionViewCell
            let hexString = colorPalette[cell.tag]
            color = hexStringToUIColor(hexString)
            self.view.backgroundColor = color
        }
    }
}
