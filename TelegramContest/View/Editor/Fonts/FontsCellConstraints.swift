//
//  FontsCellConstraints.swift
//  TelegramContest
//
//  Created by Aurocheg on 25.10.22.
//

import UIKit

final class FontsCellConstraints: UIView {
    public func addConstraintsToFontButton(_ fontButton: UIButton, view: UICollectionViewCell) {
        fontButton.translatesAutoresizingMaskIntoConstraints = false
        
        fontButton.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        fontButton.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        fontButton.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        fontButton.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
}
