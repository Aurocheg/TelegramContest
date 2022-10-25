//
//  ColorsCellConstraints.swift
//  TelegramContest
//
//  Created by Aurocheg on 23.10.22.
//

import UIKit

final class ColorsCellConstraints: UIView {
    public func addConstraintsToColor(_ colorView: UIView, view: UICollectionViewCell) {
        colorView.translatesAutoresizingMaskIntoConstraints = false
        
        colorView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        colorView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        colorView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        colorView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
}
