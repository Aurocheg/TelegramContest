//
//  ColorPickerController.swift
//  TelegramContest
//
//  Created by Aurocheg on 16.10.22.
//

import UIKit

enum RgbSliderType {
    case red
    case green
    case blue
}

final class ColorPickerController: UIViewController {
    private let colorPickerView = ColorPickerView()
    
    // MARK: - Variables
    var tag = 0
    var color = UIColor.gray
    
    var redColor: Float = 0.0
    var greenColor: Float = 0.0
    var blueColor: Float = 0.0
    var opacityPercent: Float = 1.0
    
    // MARK: - Top
    private var closeButton: UIButton {
        colorPickerView.closeButton
    }
    
    private var segmentedControl: UISegmentedControl {
        colorPickerView.segmentedControl
    }
    
    // MARK: - Color Tools
    private var gridColorsCollectionView: UICollectionView {
        colorPickerView.gridColorsCollectionView
    }
    
    private var spectrumView: UIView {
        colorPickerView.spectrumView
    }
    
    private var slidersView: UIView {
        colorPickerView.slidersView
    }
    
    // MARK: - Color Sliders
    private var redSlider: UISlider {
        colorPickerView.redSlider
    }
    
    private var greenSlider: UISlider {
        colorPickerView.greenSlider
    }
    
    private var blueSlider: UISlider {
        colorPickerView.blueSlider
    }
    
    // MARK: - Color Text Fields
    private var redTF: UITextField {
        colorPickerView.redTF
    }
    
    private var greenTF: UITextField {
        colorPickerView.greenTF
    }
    
    private var blueTF: UITextField {
        colorPickerView.blueTF
    }
    
    private var hexTF: UITextField {
        colorPickerView.hexColorTF
    }
    
    // MARK: - Opacity
    private var opacitySlider: UISlider {
        colorPickerView.opacitySlider
    }
    
    private var opacityTF: UITextField {
        colorPickerView.opacityTF
    }
    
    // MARK: - Current Color
    private var currentColorView: UIView {
        colorPickerView.currentColorView
    }
    
    // MARK: - View Life Cycle
    override func loadView() {
        view = colorPickerView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // MARK: - Connections
        gridColorsCollectionView.delegate = self
        gridColorsCollectionView.dataSource = self
        
        redTF.delegate = self
        greenTF.delegate = self
        blueTF.delegate = self
        hexTF.delegate = self
        opacityTF.delegate = self
        
        // MARK: - Register
        gridColorsCollectionView.register(GridCollectionCell.self, forCellWithReuseIdentifier: "gridCollectionCell")
        
        // MARK: - Targets
        closeButton.addTarget(self, action: #selector(closeButtonTapped(_:)), for: .touchUpInside)
        
        segmentedControl.addTarget(self, action: #selector(segmentedControlChanged(_:)), for: .valueChanged)
        
        redSlider.addTarget(self, action: #selector(colorSliderValueChanged(_:)), for: .valueChanged)
        greenSlider.addTarget(self, action: #selector(colorSliderValueChanged(_:)), for: .valueChanged)
        blueSlider.addTarget(self, action: #selector(colorSliderValueChanged(_:)), for: .valueChanged)
        opacitySlider.addTarget(self, action: #selector(colorSliderValueChanged(_:)), for: .valueChanged)
        
        redTF.addTarget(self, action: #selector(colorTFValueChanged(_:)), for: .editingChanged)
        greenTF.addTarget(self, action: #selector(colorTFValueChanged(_:)), for: .editingChanged)
        blueTF.addTarget(self, action: #selector(colorTFValueChanged(_:)), for: .editingChanged)
        opacityTF.addTarget(self, action: #selector(colorTFValueChanged(_:)), for: .editingChanged)
        hexTF.addTarget(self, action: #selector(colorTFValueChanged(_:)), for: .editingChanged)
        
        // MARK: - Dispatch
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
    
    @objc func colorSliderValueChanged(_ sender: UISlider) {
        let sliderValue = round(sender.value)
        
        switch sender {
        case redSlider:
            redColor = sliderValue
            redTF.text = String(Int(sliderValue))
        case greenSlider:
            greenColor = sliderValue
            greenTF.text = String(Int(sliderValue))
        case blueSlider:
            blueColor = sliderValue
            blueTF.text = String(Int(sliderValue))
        case opacitySlider:
            opacityPercent = sliderValue / 100
            opacityTF.text = "\(Int(sliderValue))%"
        default:
            break
        }
        
        let currentColor = UIColor(red: CGFloat(redColor) / 255.0,
                                   green: CGFloat(greenColor) / 255.0,
                                   blue: CGFloat(blueColor) / 255.0,
                                   alpha: CGFloat(opacityPercent))
        
        currentColorView.backgroundColor = currentColor
        hexTF.text = currentColor.toHexString().uppercased()
        
        setBackgroundGradient(to: redSlider, type: .red)
        setBackgroundGradient(to: greenSlider, type: .green)
        setBackgroundGradient(to: blueSlider, type: .blue)
    }
    
    @objc func colorTFValueChanged(_ sender: UITextField) {
        let textFieldValue = Float(sender.text!) ?? 0.0
        
        switch sender {
        case redTF:
            redColor = textFieldValue
            redSlider.value = textFieldValue
        case greenTF:
            greenColor = textFieldValue
            greenSlider.value = textFieldValue
        case blueTF:
            blueColor = textFieldValue
            blueSlider.value = textFieldValue
        case opacityTF:
            opacityPercent = textFieldValue / 100
            opacitySlider.value = textFieldValue
        default:
            break
        }
        
        currentColorView.backgroundColor = UIColor(red: CGFloat(redColor) / 255.0,
                                                   green: CGFloat(greenColor) / 255.0,
                                                   blue: CGFloat(blueColor) / 255.0,
                                                   alpha: CGFloat(opacityPercent))
        setBackgroundGradient(to: redSlider, type: .red)
        setBackgroundGradient(to: greenSlider, type: .green)
        setBackgroundGradient(to: blueSlider, type: .blue)
    }
}

// MARK: - ColorPickerController
extension ColorPickerController {
    func setBackgroundGradient(to slider: UISlider, type: RgbSliderType) {
        let leftColor: CGColor
        let rightColor: CGColor
        
        switch type {
        case .red:
            leftColor = UIColor(red: 0.0,
                                green: CGFloat(greenColor) / 255.0,
                                blue: CGFloat(blueColor) / 255.0,
                                alpha: CGFloat(opacityPercent)).cgColor
            rightColor = UIColor(red: CGFloat(redColor) / 255.0,
                                green: CGFloat(greenColor) / 255.0,
                                blue: CGFloat(blueColor) / 255.0,
                                alpha: CGFloat(opacityPercent)).cgColor
        case .green:
            leftColor = UIColor(red: CGFloat(redColor) / 255.0,
                                green: 0.0,
                                blue: CGFloat(blueColor) / 255.0,
                                alpha: CGFloat(opacityPercent)).cgColor
            rightColor = UIColor(red: CGFloat(redColor) / 255.0,
                                green: CGFloat(greenColor) / 255.0,
                                blue: CGFloat(blueColor) / 255.0,
                                alpha: CGFloat(opacityPercent)).cgColor
        case .blue:
            leftColor = UIColor(red: CGFloat(redColor) / 255.0,
                                green: CGFloat(greenColor) / 255.0,
                                blue: 0.0,
                                alpha: CGFloat(opacityPercent)).cgColor
            rightColor = UIColor(red: CGFloat(redColor) / 255.0,
                                green: CGFloat(greenColor) / 255.0,
                                blue: CGFloat(blueColor) / 255.0,
                                alpha: CGFloat(opacityPercent)).cgColor
        }
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.cornerRadius = slider.layer.cornerRadius
        gradientLayer.colors = [leftColor, rightColor]
        gradientLayer.frame.size = slider.bounds.size
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 1.0)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
        
        UIGraphicsBeginImageContextWithOptions(CGSize(width: slider.frame.width, height: slider.frame.height), true, 1.0)
        guard let context = UIGraphicsGetCurrentContext() else { return }
        gradientLayer.render(in: context)

        let image = UIGraphicsGetImageFromCurrentImageContext()?.resizableImage(withCapInsets: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
        UIGraphicsEndImageContext()
        slider.setMinimumTrackImage(image, for: .normal)
        slider.setMaximumTrackImage(image, for: .normal)
    }
    
    func hexStringToUIColor(_ hex: String) -> UIColor {
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
}

// MARK: - UITextFieldDelegate
extension ColorPickerController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

// MARK: - UICollectionViewDelegate
extension ColorPickerController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        120
    }
}

// MARK: - UICollectionViewDataSource
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
