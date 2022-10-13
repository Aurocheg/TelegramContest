//
//  GalleryView.swift
//  TelegramContest
//
//  Created by Aurocheg on 12.10.22.
//

import UIKit

final class GalleryView: UIView {
    // MARK: - Constraints
    private let galleryConstraints = GalleryConstraints()
    
    // MARK: - UI Elements
    public let galleryCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        let cellWidth = UIScreen.main.bounds.width / 3 - 7
        
        layout.estimatedItemSize = CGSize(width: cellWidth, height: 129.0)
        layout.minimumLineSpacing = 1.0
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)

        return collectionView
    }()
    
    // MARK: - Init Method
    init() {
        super.init(frame: .zero)
        
        initViews()
        initConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Init Views Method
    private func initViews() {
        addSubview(galleryCollectionView)
    }
    
    // MARK: - Init Constraints Method
    private func initConstraints() {
        galleryConstraints.addConstraintsToGalleryCollection(galleryCollectionView, view: self)
    }
}
