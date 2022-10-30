//
//  AccessView.swift
//  TelegramContest
//
//  Created by Aurocheg on 12.10.22.
//

import UIKit
import Lottie

final class AccessView: UIView {
    // MARK: - Constraints
    private let accessConstraints = AccessConstraints()
    
    // MARK: - UI Elements
    private let accessContainerView = UIView()
    
    public let animationView: LottieAnimationView = {
        let animationView = LottieAnimationView()
        animationView.loopMode = .loop
        return animationView
    }()
    
    private let accessLabel: UILabel = {
        let label = UILabel()
        
        label.text = "Access Your Photos and Videos"
        label.font = .systemFont(ofSize: 20.0, weight: .semibold)
        
        return label
    }()
    
    public let accessButton: UIButton = {
        let button = UIButton()
        
        button.setTitle("Access", for: .normal)
        button.titleLabel?.textColor = .white
        button.backgroundColor = .systemBlue
        
        button.layer.cornerRadius = 10.0
        
        return button
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
        addSubview(accessContainerView)
        accessContainerView.addSubview(animationView)
        accessContainerView.addSubview(accessLabel)
        accessContainerView.addSubview(accessButton)
    }
    
    // MARK: - Init Constraints Method
    private func initConstraints() {
        accessConstraints.addConstraintsToContainer(accessContainerView, view: self)
        accessConstraints.addConstraintsToAnimationView(animationView, containerView: accessContainerView)
        accessConstraints.addConstraintsToLabel(accessLabel, containerView: accessContainerView, parent: animationView)
        accessConstraints.addConstraintsToButton(accessButton, containerView: accessContainerView, parent: accessLabel)
    }
}
