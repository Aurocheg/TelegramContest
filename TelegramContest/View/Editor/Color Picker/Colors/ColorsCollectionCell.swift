//
//  ColorsCollectionCell.swift
//  TelegramContest
//
//  Created by Aurocheg on 23.10.22.
//

import UIKit

final class ColorsCollectionCell: UICollectionViewCell {
    // MARK: - Constraints
    private let colorsCellConstraints = ColorsCellConstraints()
    
    // MARK: - UI Elements
    public let colorView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 15.0
        return view
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
        addSubview(colorView)
    }
    
    // MARK: - Init Constraints Method
    private func initConstraints() {
        colorsCellConstraints.addConstraintsToColor(colorView, view: self)
    }
}
