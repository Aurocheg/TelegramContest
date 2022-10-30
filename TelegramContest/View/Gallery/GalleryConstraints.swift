//
//  GalleryConstraints.swift
//  TelegramContest
//
//  Created by Aurocheg on 12.10.22.
//

import UIKit

final class GalleryConstraints: UIView {
    public func addConstraintsToGalleryCollection(_ galleryCollectionView: UICollectionView, view: UIView) {
        galleryCollectionView.translatesAutoresizingMaskIntoConstraints = false
        
        galleryCollectionView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        galleryCollectionView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        galleryCollectionView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        galleryCollectionView.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
    }
}
