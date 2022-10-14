//
//  GalleryCellConstraints.swift
//  TelegramContest
//
//  Created by Aurocheg on 13.10.22.
//

import UIKit

final class GalleryCellConstraints: UIView {
    public func addConstraintsToImage(_ imageView: UIImageView, view: UICollectionViewCell) {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        imageView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        imageView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        imageView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        imageView.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
    }
}
