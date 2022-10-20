//
//  BrushCollectionCell.swift
//  TelegramContest
//
//  Created by Aurocheg on 19.10.22.
//

import UIKit

final class BrushCollectionCell: UICollectionViewCell {
    // MARK: - Constraints
    private let brushCellConstraints = BrushCellConstraints()
    
    // MARK: - Init UI Elements
    public let brushImageView: UIImageView = {
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
        addSubview(brushImageView)
    }
    
    // MARK: - Init Constraints
    private func initConstraints() {
        brushCellConstraints.addConstraintsToImage(brushImageView, view: self)
    }
}
