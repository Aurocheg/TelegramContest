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
    case opacity
}

final class ColorPickerController: UIViewController {
    private let colorPickerView = ColorPickerView()
    static var brushColorDidChange: ((_ color: UIColor) -> ())?
    
    // MARK: - Variables for Grid
    private var tag = 0
    private var color = UIColor.gray
    
    // MARK: - Variables for color collection cell
    private let userColors = UserDefaults.standard.object(forKey: "userColors") as? Array<String> ?? []
    
    // MARK: - Variables for Sliders
    private var redColor: CGFloat = 1.0
    private var greenColor: CGFloat = 0.568
    private var blueColor: CGFloat = 1.0
    private var opacityPercent: CGFloat = 1.0
    
    // MARK: - Top Elements
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
    public var currentColorView: UIView {
        colorPickerView.currentColorView
    }
    
    private var colorsCollectionView: UICollectionView {
        colorPickerView.colorsCollectionView
    }
    
    // MARK: - View Life Cycle
    override func loadView() {
        view = colorPickerView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.layer.cornerRadius = 13.0
        
        // MARK: - Connections
        gridColorsCollectionView.delegate = self
        gridColorsCollectionView.dataSource = self
        colorsCollectionView.delegate = self
        colorsCollectionView.dataSource = self
        
        redTF.delegate = self
        greenTF.delegate = self
        blueTF.delegate = self
        hexTF.delegate = self
        opacityTF.delegate = self
        
        // MARK: - Register
        gridColorsCollectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "gridCollectionCell")
        colorsCollectionView.register(ColorsCollectionCell.self, forCellWithReuseIdentifier: "colorsCollectionCell")
        
        // MARK: - Targets
        closeButton.addTarget(self, action: #selector(closeButtonTapped(_:)), for: .touchUpInside)
        
        segmentedControl.addTarget(self, action: #selector(segmentedControlChanged(_:)), for: .valueChanged)
        
        redSlider.addTarget(self, action: #selector(sliderValueChanged(_:)), for: .valueChanged)
        greenSlider.addTarget(self, action: #selector(sliderValueChanged(_:)), for: .valueChanged)
        blueSlider.addTarget(self, action: #selector(sliderValueChanged(_:)), for: .valueChanged)
        opacitySlider.addTarget(self, action: #selector(sliderValueChanged(_:)), for: .valueChanged)
        
        redTF.addTarget(self, action: #selector(TFValueChanged(_:)), for: .editingChanged)
        greenTF.addTarget(self, action: #selector(TFValueChanged(_:)), for: .editingChanged)
        blueTF.addTarget(self, action: #selector(TFValueChanged(_:)), for: .editingChanged)
        opacityTF.addTarget(self, action: #selector(TFValueChanged(_:)), for: .editingChanged)
        hexTF.addTarget(self, action: #selector(TFValueChanged(_:)), for: .editingChanged)
        
        // MARK: - Dispatch for changing color of current color view when touching Spectrum View
        let spectrumView = SpectrumView.self
        spectrumView.onColorDidChange = {[weak self] color in
            DispatchQueue.main.async {
                self!.initOpacity()
                self!.currentColorView.backgroundColor = color
                ColorPickerController.brushColorDidChange?(color)
                color.getRed(&self!.redColor, green: &self!.greenColor, blue: &self!.blueColor, alpha: &self!.opacityPercent)
                self!.setBackgroundGradient(to: self!.opacitySlider, type: .opacity)
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let currentColor = UIColor(red: redColor, green: greenColor, blue: blueColor, alpha: 1.0)
        
        setBackgroundGradient(to: redSlider, type: .red)
        setBackgroundGradient(to: greenSlider, type: .green)
        setBackgroundGradient(to: blueSlider, type: .blue)
        setBackgroundGradient(to: opacitySlider, type: .opacity)
        
        redTF.text = "255"
        greenTF.text = "145"
        blueTF.text = "255"
        hexTF.text = currentColor.toHexString().uppercased()
        opacityTF.text = "\(Int(opacityPercent * 100))%"
        
        currentColorView.backgroundColor = currentColor
    }
    
    // MARK: - Methods
    private func setBackgroundGradient(to slider: UISlider, type: RgbSliderType) {
        let leftColor: CGColor
        let rightColor: CGColor
        
        let sliderRadius = slider.layer.cornerRadius
        let sliderSize = slider.bounds.size
        
        switch type {
        case .red:
            leftColor = UIColor(red: 0.0, green: greenColor, blue: blueColor, alpha: 1.0).cgColor
            rightColor = UIColor(red: redColor, green: greenColor, blue: blueColor, alpha: 1.0).cgColor
        case .green:
            leftColor = UIColor(red: redColor, green: 0.0, blue: blueColor, alpha: 1.0).cgColor
            rightColor = UIColor(red: redColor, green: greenColor, blue: blueColor, alpha: 1.0).cgColor
        case .blue:
            leftColor = UIColor(red: redColor, green: greenColor, blue: 0.0, alpha: 1.0).cgColor
            rightColor = UIColor(red: redColor, green: greenColor, blue: blueColor, alpha: 1.0).cgColor
        case .opacity:
            leftColor = UIColor(red: redColor, green: greenColor, blue: blueColor, alpha: 0.3).cgColor
            rightColor = UIColor(red: redColor, green: greenColor, blue: blueColor, alpha: 1.0).cgColor
        }
        
        let gradientLayer = CAGradientLayer.createSliderGradient(colors: [leftColor, rightColor], cornerRadius: sliderRadius, size: sliderSize)
    
        UIGraphicsBeginImageContextWithOptions(sliderSize, true, 1.0)
        guard let context = UIGraphicsGetCurrentContext() else { return }
        gradientLayer.render(in: context)

        let image = UIGraphicsGetImageFromCurrentImageContext()?.resizableImage(withCapInsets: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)).withRoundedCorners(radius: sliderRadius)
        
        UIGraphicsEndImageContext()
        slider.setMinimumTrackImage(image, for: .normal)
        slider.setMaximumTrackImage(image, for: .normal)
    }
    
    private func readDataFromPlist(cellTag: Int, indexPath: IndexPath) {
        var colorPalette: Array<String>
        
        let path = Bundle.main.path(forResource: "colorPalette", ofType: "plist")
        let plistArray = NSArray(contentsOfFile: path!)
        
        if let colorPalettePlistFile = plistArray {
            colorPalette = colorPalettePlistFile as! [String]
            let hexString = colorPalette[cellTag].hexStringToUIColor()
            color = hexString
        }
    }
    
    private func initOpacity() {
        opacityPercent = 1.0
        opacitySlider.value = Float(opacityPercent * 100)
        opacityTF.text = "\(Int(opacityPercent * 100))%"
    }
    
    // MARK: - @objc
    @objc func closeButtonTapped(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    @objc func segmentedControlChanged(_ sender: UISegmentedControl) {
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
            break
        }
    }
    
    @objc func sliderValueChanged(_ sender: UISlider) {
        let sliderValue = round(sender.value)
        
        switch sender {
        case redSlider:
            redColor = CGFloat(sliderValue / 255.0)
            redTF.text = String(Int(sliderValue))
        case greenSlider:
            greenColor = CGFloat(sliderValue / 255.0)
            greenTF.text = String(Int(sliderValue))
        case blueSlider:
            blueColor = CGFloat(sliderValue / 255.0)
            blueTF.text = String(Int(sliderValue))
        case opacitySlider:
            opacityPercent = CGFloat(sliderValue / 100.0)
            opacityTF.text = "\(Int(sliderValue))%"
        default:
            break
        }
        
        let currentColor = UIColor(red: redColor, green: greenColor, blue: blueColor, alpha: opacityPercent)
        currentColorView.backgroundColor = currentColor
        ColorPickerController.brushColorDidChange?(currentColor)
        
        var hexString = currentColor.toHexString().uppercased()
        hexString.remove(at: hexString.startIndex)
        hexTF.text = hexString
        
        setBackgroundGradient(to: redSlider, type: .red)
        setBackgroundGradient(to: greenSlider, type: .green)
        setBackgroundGradient(to: blueSlider, type: .blue)
        setBackgroundGradient(to: opacitySlider, type: .opacity)
    }
    
    @objc func TFValueChanged(_ sender: UITextField) {
        let textFieldValue = Float(sender.text!) ?? 0.0
        
        switch sender {
        case redTF:
            redColor = CGFloat(textFieldValue / 255.0)
            redSlider.value = textFieldValue
        case greenTF:
            greenColor = CGFloat(textFieldValue / 255.0)
            greenSlider.value = textFieldValue
        case blueTF:
            blueColor = CGFloat(textFieldValue / 255.0)
            blueSlider.value = textFieldValue
        case opacityTF:
            opacityPercent = CGFloat(textFieldValue / 100)
            opacitySlider.value = textFieldValue
        default:
            break
        }
        
        let currentColor = UIColor(red: redColor, green: greenColor, blue: blueColor, alpha: opacityPercent)
        currentColorView.backgroundColor = currentColor
        ColorPickerController.brushColorDidChange?(currentColor)

        var hexString = currentColor.toHexString().uppercased()
        hexString.remove(at: hexString.startIndex)
        hexTF.text = hexString
        
        setBackgroundGradient(to: redSlider, type: .red)
        setBackgroundGradient(to: greenSlider, type: .green)
        setBackgroundGradient(to: blueSlider, type: .blue)
        setBackgroundGradient(to: opacitySlider, type: .opacity)
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
        switch collectionView {
        case gridColorsCollectionView:
            return 120
        case colorsCollectionView:
            return userColors.count
        default:
            return 0
        }
    }
}

// MARK: - UICollectionViewDataSource
extension ColorPickerController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        case gridColorsCollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "gridCollectionCell", for: indexPath)
            cell.tag = tag
            readDataFromPlist(cellTag: cell.tag, indexPath: indexPath)
            
            cell.backgroundColor = color
            tag += 1
            
            return cell
        case colorsCollectionView:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "colorsCollectionCell", for: indexPath) as? ColorsCollectionCell else {
                return UICollectionViewCell()
            }
            let color = userColors[indexPath.row]
            cell.colorView.backgroundColor = color.hexStringToUIColor()
            return cell
        default:
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)!
        
        cell.layer.borderWidth = 3.0
        cell.layer.borderColor = UIColor.white.cgColor

        initOpacity()
        
        readDataFromPlist(cellTag: cell.tag, indexPath: indexPath)
        color.getRed(&redColor, green: &greenColor, blue: &blueColor, alpha: &opacityPercent)
        currentColorView.backgroundColor = color
        ColorPickerController.brushColorDidChange?(color)
        
        setBackgroundGradient(to: opacitySlider, type: .opacity)
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)!
        
        cell.layer.borderColor = UIColor.clear.cgColor
        cell.layer.borderWidth = 0.0
    }
}
