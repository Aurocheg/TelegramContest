//
//  EditorView.swift
//  TelegramContest
//
//  Created by Aurocheg on 14.10.22.
//

import UIKit

final class EditorView: UIView {
    // MARK: - Constraints
    private let editorConstraints = EditorConstraints()
    
    // MARK: - Init UI Elements
    public let toolbar: UIToolbar = {
        let toolBar = UIToolbar()
        
        toolBar.backgroundColor = .clear
        toolBar.tintColor = .white
        
        return toolBar
    }()
    
    public let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        return imageView
    }()
    
    // MARK: - Init Method
    init() {
        super.init(frame: .zero)
        
        backgroundColor = .black
        
        initViews()
        initConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Init Views Method
    private func initViews() {
        addSubview(toolbar)
        addSubview(imageView)
    }
    
    // MARK: - Init Constraints Method
    private func initConstraints() {
        editorConstraints.addConstraintsToToolbar(toolbar, view: self)
        editorConstraints.addConstraintsToImage(imageView, view: self, parent: toolbar)
    }
    
}
