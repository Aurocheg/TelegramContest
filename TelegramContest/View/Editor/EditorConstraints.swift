//
//  EditorConstraints.swift
//  TelegramContest
//
//  Created by Aurocheg on 14.10.22.
//  я долбаеб (Чикита) made with love (63 TP)

import UIKit

enum ButtonsPosition {
    case left
    case right
}

final class EditorConstraints: UIView {
    public func addConstraintsToTopButton(_ button: UIButton, view: UIView, position: ButtonsPosition) {
        button.translatesAutoresizingMaskIntoConstraints = false
                
        switch position {
        case .left:
            button.topAnchor.constraint(equalTo: view.topAnchor, constant: 67.0).isActive = true
            button.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16.0).isActive = true
            button.widthAnchor.constraint(equalToConstant: 16.0).isActive = true
            button.heightAnchor.constraint(equalToConstant: 16.0).isActive = true
        case .right:
            button.topAnchor.constraint(equalTo: view.topAnchor, constant: 64.0).isActive = true
            button.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -12.0).isActive = true
            button.widthAnchor.constraint(equalToConstant: 64.0).isActive = true
            button.heightAnchor.constraint(equalToConstant: 22.0).isActive = true
        }        
    }
    
    public func addConstraintsToCanvas(_ canvasView: UIView, view: UIView, parent: UIButton) {
        canvasView.translatesAutoresizingMaskIntoConstraints = false
        
        canvasView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        canvasView.topAnchor.constraint(equalTo: parent.bottomAnchor, constant: 42.0).isActive = true
        canvasView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        canvasView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.59).isActive = true
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
        collectionView.heightAnchor.constraint(equalToConstant: 93.0).isActive = true
    }
    
    public func addConstraintsToSegmentedControl(_ segmentedControl: UISegmentedControl, view: UIView) {
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        
        segmentedControl.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        segmentedControl.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -44.5).isActive = true
        segmentedControl.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7).isActive = true
        segmentedControl.heightAnchor.constraint(equalToConstant: 28.0).isActive = true
    }
}
