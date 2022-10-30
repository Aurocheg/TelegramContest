//
//  EditorConstraints.swift
//  TelegramContest
//
//  Created by Aurocheg on 14.10.22.

import UIKit

enum ButtonsPosition {
    case left
    case right
}

final class EditorConstraints: UIView {
    private let screenHeight = UIScreen.main.bounds.height
    
    // MARK: - Top
    public func addConstraintsToTopButton(_ button: UIButton, view: UIView, position: ButtonsPosition) {
        button.translatesAutoresizingMaskIntoConstraints = false
                
        switch position {
        case .left:
            if screenHeight < 812.0 {
                button.topAnchor.constraint(equalTo: view.topAnchor, constant: 39.0).isActive = true
            } else {
                button.topAnchor.constraint(equalTo: view.topAnchor, constant: 67.0).isActive = true
            }
            button.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16.0).isActive = true
            button.widthAnchor.constraint(equalToConstant: 16.0).isActive = true
            button.heightAnchor.constraint(equalToConstant: 16.0).isActive = true
        case .right:
            if screenHeight < 812.0 {
                button.topAnchor.constraint(equalTo: view.topAnchor, constant: 36.0).isActive = true
            } else {
                button.topAnchor.constraint(equalTo: view.topAnchor, constant: 64.0).isActive = true
            }
            button.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -12.0).isActive = true
            button.widthAnchor.constraint(equalToConstant: 64.0).isActive = true
            button.heightAnchor.constraint(equalToConstant: 22.0).isActive = true
        }        
    }
    
    public func addConstraintsToMainCanvas(_ mainCanvasView: UIView, view: UIView, parent: UIButton) {
        mainCanvasView.translatesAutoresizingMaskIntoConstraints = false
        
        mainCanvasView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        
        if screenHeight < 812.0 {
            mainCanvasView.topAnchor.constraint(equalTo: parent.bottomAnchor, constant: 20.0).isActive = true
        } else {
            mainCanvasView.topAnchor.constraint(equalTo: parent.bottomAnchor, constant: 42.0).isActive = true
        }
        
        mainCanvasView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        mainCanvasView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.61).isActive = true
    }
    
    public func addConstraintsToCanvas(_ canvasView: UIView, view: UIView) {
        canvasView.translatesAutoresizingMaskIntoConstraints = false
        
        canvasView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        canvasView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        canvasView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        canvasView.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
    }
    
    // MARK: - Tools
    public func addConstraintsToToolsView(_ toolsView: UIView, view: UIView) {
        toolsView.translatesAutoresizingMaskIntoConstraints = false
        
        toolsView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        toolsView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -44.5).isActive = true
        toolsView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        toolsView.heightAnchor.constraint(equalToConstant: 110.0).isActive = true
    }
    
    public func addConstraintsToBottomButton(_ button: UIButton, view: UIView, parent: AnyObject? = nil, bottomConstant: CGFloat, position: ButtonsPosition) {
        button.translatesAutoresizingMaskIntoConstraints = false
        
        if let parent = parent {
            button.bottomAnchor.constraint(equalTo: parent.topAnchor, constant: bottomConstant).isActive = true
        } else {
            button.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: bottomConstant).isActive = true
        }
        
        switch position {
        case .left:
            button.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 9.5).isActive = true
        case .right:
            button.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -8.0).isActive = true
        }
        
        button.widthAnchor.constraint(equalToConstant: 33.0).isActive = true
        button.heightAnchor.constraint(equalToConstant: 33.0).isActive = true
    }
    
    public func addConstraintsToBrushesCollection(_ collectionView: UICollectionView, parent: AnyObject, segmentedControl: UISegmentedControl, view: UIView) {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        collectionView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: segmentedControl.topAnchor).isActive = true
        collectionView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.61).isActive = true
        collectionView.heightAnchor.constraint(equalToConstant: 123.0).isActive = true
    }
    
    // MARK: - Segmented Control
    public func addConstraintsToSegmentedControl(_ segmentedControl: UISegmentedControl, view: UIView) {
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        
        segmentedControl.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        segmentedControl.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        segmentedControl.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7).isActive = true
        segmentedControl.heightAnchor.constraint(equalToConstant: 28.0).isActive = true
    }
    
    // MARK: - Size
    public func addConstraintsToSizeView(_ sizeView: UIView, view: UIView) {
        sizeView.translatesAutoresizingMaskIntoConstraints = false
        
        sizeView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 8.0).isActive = true
        sizeView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -42.0).isActive = true
        sizeView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -16.0).isActive = true
        sizeView.heightAnchor.constraint(equalToConstant: 140.0).isActive = true
    }
    
    public func addConstraintsToSizeImage(_ sizeImageView: UIImageView, sizeView: UIView) {
        sizeImageView.translatesAutoresizingMaskIntoConstraints = false
        
        sizeImageView.centerXAnchor.constraint(equalTo: sizeView.centerXAnchor).isActive = true
        sizeImageView.topAnchor.constraint(equalTo: sizeView.topAnchor).isActive = true
        sizeImageView.widthAnchor.constraint(equalToConstant: 34.0).isActive = true
        sizeImageView.heightAnchor.constraint(equalToConstant: 107.0).isActive = true
    }
    
    public func addConstraintsToSizeBack(_ sizeBackButton: UIButton, sizeView: UIView) {
        sizeBackButton.translatesAutoresizingMaskIntoConstraints = false
        
        sizeBackButton.leftAnchor.constraint(equalTo: sizeView.leftAnchor).isActive = true
        sizeBackButton.bottomAnchor.constraint(equalTo: sizeView.bottomAnchor).isActive = true
        sizeBackButton.widthAnchor.constraint(equalToConstant: 33.0).isActive = true
        sizeBackButton.heightAnchor.constraint(equalToConstant: 33.0).isActive = true
    }
    
    public func addConstraintsToSizeSlider(_ sizeSlider: UISlider, sizeView: UIView, parent: UIButton) {
        sizeSlider.translatesAutoresizingMaskIntoConstraints = false
    
        sizeSlider.centerYAnchor.constraint(equalTo: parent.centerYAnchor).isActive = true
        sizeSlider.leftAnchor.constraint(equalTo: parent.rightAnchor, constant: 16.5).isActive = true
        sizeSlider.widthAnchor.constraint(equalTo: sizeView.widthAnchor, multiplier: 0.61).isActive = true
    }
    
    public func addConstraintsToSizeSliderView(_ sizeSliderView: UIView, sizeSlider: UISlider) {
        sizeSliderView.translatesAutoresizingMaskIntoConstraints = false
        
        sizeSliderView.leftAnchor.constraint(equalTo: sizeSlider.leftAnchor).isActive = true
        sizeSliderView.topAnchor.constraint(equalTo: sizeSlider.topAnchor).isActive = true
        sizeSliderView.widthAnchor.constraint(equalTo: sizeSlider.widthAnchor).isActive = true
        sizeSliderView.heightAnchor.constraint(equalTo: sizeSlider.heightAnchor).isActive = true
    }
    
    public func addConstraintsToSizeActionButton(_ actionButton: UIButton, sizeView: UIView, slider: UISlider) {
        actionButton.translatesAutoresizingMaskIntoConstraints = false
        
        actionButton.rightAnchor.constraint(equalTo: sizeView.rightAnchor).isActive = true
        actionButton.centerYAnchor.constraint(equalTo: slider.centerYAnchor).isActive = true
        actionButton.heightAnchor.constraint(equalToConstant: 22.0).isActive = true
    }
    
    // MARK: - Text
    public func addConstraintsToTextMainView(textMainView: UIView, view: UIView, parent: UIButton, segmentedControl: UISegmentedControl) {
        textMainView.translatesAutoresizingMaskIntoConstraints = false
        
        textMainView.centerYAnchor.constraint(equalTo: parent.centerYAnchor).isActive = true
        textMainView.leftAnchor.constraint(equalTo: segmentedControl.leftAnchor).isActive = true
        textMainView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7974).isActive = true
        textMainView.heightAnchor.constraint(equalToConstant: 30.5).isActive = true
    }
    
    public func addConstraintsToTextView(_ textView: UITextView, canvasView: UIView) {
        textView.translatesAutoresizingMaskIntoConstraints = false
        
        textView.centerXAnchor.constraint(equalTo: canvasView.centerXAnchor).isActive = true
        textView.centerYAnchor.constraint(equalTo: canvasView.centerYAnchor).isActive = true
        textView.widthAnchor.constraint(equalToConstant: 300.0).isActive = true
    }
    
    public func addConstraintsToTextSizeSlider(_ textSizeSlider: UISlider, canvasView: UIView, textView: UITextView) {
        textSizeSlider.translatesAutoresizingMaskIntoConstraints = false
        
//        textSizeSlider.transform = CGAffineTransform(rotationAngle: -.pi / 2)
        
        textSizeSlider.leftAnchor.constraint(equalTo: canvasView.leftAnchor, constant: 0).isActive = true
        textSizeSlider.centerYAnchor.constraint(equalTo: textView.centerYAnchor).isActive = true
        textSizeSlider.widthAnchor.constraint(equalToConstant: 240.0).isActive = true
//        textSizeSlider.heightAnchor.constraint(equalToConstant: 16.0).isActive = true
    }
    
    public func addConstraintsToTextSizeSliderView(_ textSizeSliderView: UIView, textSizeSlider: UISlider) {
        textSizeSliderView.translatesAutoresizingMaskIntoConstraints = false
        
//        textSizeSliderView.transform = CGAffineTransform(rotationAngle: -.pi / 2)
        
        textSizeSliderView.leftAnchor.constraint(equalTo: textSizeSlider.leftAnchor).isActive = true
        textSizeSliderView.topAnchor.constraint(equalTo: textSizeSlider.topAnchor).isActive = true
        textSizeSliderView.widthAnchor.constraint(equalTo: textSizeSlider.widthAnchor).isActive = true
        textSizeSliderView.heightAnchor.constraint(equalTo: textSizeSlider.heightAnchor).isActive = true
    }
    
    public func addConstraintsToToolButton(_ toolButton: UIButton, textMainView: UIView, parent: UIButton? = nil) {
        toolButton.translatesAutoresizingMaskIntoConstraints = false
        
        if let parent = parent {
            toolButton.leftAnchor.constraint(equalTo: parent.rightAnchor, constant: 14.0).isActive = true
        } else {
            toolButton.leftAnchor.constraint(equalTo: textMainView.leftAnchor).isActive = true
        }
        
        toolButton.centerYAnchor.constraint(equalTo: textMainView.centerYAnchor).isActive = true
        toolButton.widthAnchor.constraint(equalToConstant: 30.0).isActive = true
        toolButton.heightAnchor.constraint(equalToConstant: 30.0).isActive = true
    }
    
    public func addConstraintsToFontsCollection(_ fontsCollectionView: UICollectionView, textMainView: UIView, parent: UIButton) {
        fontsCollectionView.translatesAutoresizingMaskIntoConstraints = false
        
        fontsCollectionView.leftAnchor.constraint(equalTo: parent.rightAnchor).isActive = true
        fontsCollectionView.topAnchor.constraint(equalTo: textMainView.topAnchor).isActive = true
        fontsCollectionView.widthAnchor.constraint(equalTo: textMainView.widthAnchor, multiplier: 0.73).isActive = true
        fontsCollectionView.heightAnchor.constraint(equalTo: textMainView.heightAnchor).isActive = true
    }
}
