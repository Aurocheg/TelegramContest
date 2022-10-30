//
//  AccessController.swift
//  TelegramContest
//
//  Created by Aurocheg on 12.10.22.
//

import UIKit
import Lottie

final class AccessController: UIViewController {
    // MARK: - Main View
    private let accessView = AccessView()
    
    // MARK: - UI Elements
    private var animationView: LottieAnimationView {
        accessView.animationView
    }
    
    private var accessButton: UIButton {
        accessView.accessButton
    }
    
    override func loadView() {
        view = accessView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // MARK: - Enable Animations
        let path = Bundle.main.path(forResource: "duck", ofType: "json")
        animationView.animation = LottieAnimation.filepath(path!)
        animationView.play()
        
        // MARK: - Targets
        accessButton.addTarget(self, action: #selector(accessButtonTapped), for: .touchUpInside)
    }
    
    // MARK: - @objc
    @objc func accessButtonTapped() {
        let galleryController = GalleryController()
        galleryController.modalPresentationStyle = .overFullScreen
        present(galleryController, animated: true)
    }
}
