//
//  FontsCollectionCell.swift
//  TelegramContest
//
//  Created by Aurocheg on 25.10.22.
//

import UIKit

final class FontsCollectionCell: UICollectionViewCell {
    // MARK: - Constraints
    private let fontsCellConstraints = FontsCellConstraints()
    
    // MARK: - UI Elements
    public let fontButton = FontButton(margins: UIEdgeInsets(top: 0.0, left: 8.0, bottom: 0.0, right: 8.0))
    
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
        addSubview(fontButton)
    }
    
    // MARK: - Init Constraints Method
    private func initConstraints() {
        fontsCellConstraints.addConstraintsToFontButton(fontButton, view: self)
    }
}
