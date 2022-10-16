//
//  ColorPickerConstraints.swift
//  TelegramContest
//
//  Created by Aurocheg on 15.10.22.
//

import UIKit

enum ToolButtonPosition {
    case left
    case right
}

final class ColorPickerConstraints: UIView {
    public func addConstraintsToToolButton(_ toolButton: UIButton, view: UIView, position: ToolButtonPosition, size: CGSize = CGSize(width: 30.0, height: 30.0)) {
        toolButton.translatesAutoresizingMaskIntoConstraints = false
        
        toolButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 14.0).isActive = true
        
        switch position {
        case .left: toolButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16.0).isActive = true
        case .right: toolButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16.0).isActive = true
        }
        
        toolButton.widthAnchor.constraint(equalToConstant: size.width).isActive = true
        toolButton.heightAnchor.constraint(equalToConstant: size.height).isActive = true
    }
    
    public func addConstraintsToMainTitle(_ label: UILabel, view: UIView) {
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        label.topAnchor.constraint(equalTo: view.topAnchor, constant: 18.0).isActive = true
    }
    
    public func addConstraintsToSegmentedControl(_ segmentedControl: UISegmentedControl, view: UIView, parent: AnyObject) {
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        
        segmentedControl.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 18.0).isActive = true
        segmentedControl.topAnchor.constraint(equalTo: parent.bottomAnchor, constant: 20.0).isActive = true
        segmentedControl.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -36.0).isActive = true
        segmentedControl.heightAnchor.constraint(equalToConstant: 28.0).isActive = true
    }
    
    public func addConstraintsToGridColors(_ gridColorsCollectionView: UICollectionView, view: UIView, parent: AnyObject) {
        gridColorsCollectionView.translatesAutoresizingMaskIntoConstraints = false
        
        gridColorsCollectionView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16.0).isActive = true
        gridColorsCollectionView.topAnchor.constraint(equalTo: parent.bottomAnchor, constant: 20.0).isActive = true
        gridColorsCollectionView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -32.0).isActive = true
        gridColorsCollectionView.heightAnchor.constraint(equalToConstant: 296.0).isActive = true
    }
    
    public func addConstraintsToSlidersView(_ slidersView: UIView, view: UIView, parent: UISegmentedControl) {
        slidersView.translatesAutoresizingMaskIntoConstraints = false
        
        slidersView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20.0).isActive = true
        slidersView.topAnchor.constraint(equalTo: parent.bottomAnchor, constant: 20.0).isActive = true
        slidersView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -40.0).isActive = true
        slidersView.heightAnchor.constraint(equalToConstant: 300.0).isActive = true
    }
    
    public func addConstraintsToSeparator(_ separatorView: UIView, view: UIView, parent: UISlider) {
        separatorView.translatesAutoresizingMaskIntoConstraints = false
        
        separatorView.topAnchor.constraint(equalTo: parent.bottomAnchor, constant: 24.0).isActive = true
        separatorView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16.0).isActive = true
        separatorView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -32.0).isActive = true
        separatorView.heightAnchor.constraint(equalToConstant: 1.0).isActive = true
    }
    
    public func addConstraintsToCurrentColor(_ currentColorView: UIView, view: UIView, parent: AnyObject) {
        currentColorView.translatesAutoresizingMaskIntoConstraints = false
        
        currentColorView.topAnchor.constraint(equalTo: parent.bottomAnchor, constant: 22.0).isActive = true
        currentColorView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16.0).isActive = true
        currentColorView.widthAnchor.constraint(equalToConstant: 82.0).isActive = true
        currentColorView.heightAnchor.constraint(equalToConstant: 82.0).isActive = true
    }
}
