//
//  GalleryCollectionCell.swift
//  TelegramContest
//
//  Created by Aurocheg on 13.10.22.
//

import UIKit

final class GalleryCollectionCell: UICollectionViewCell {
    // MARK: - Constraints
    private let galleryCellConstraints = GalleryCellConstraints()
    
    // MARK: - Init UI Elements
    public let galleryImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        return imageView
    }()
    
    // MARK: - Init Method
    override init(frame: CGRect) {
        super.init(frame: frame)
                               
        initViews()
        initConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Init Views Method
    private func initViews() {
        addSubview(galleryImageView)
    }
    
    // MARK: - Init Constraints Method
    private func initConstraints() {
        galleryCellConstraints.addConstraintsToImage(galleryImageView, view: self)
    }
}
