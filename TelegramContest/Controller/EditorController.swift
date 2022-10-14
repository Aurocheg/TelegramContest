//
//  EditorController.swift
//  TelegramContest
//
//  Created by Aurocheg on 14.10.22.
//

import UIKit

final class EditorController: UIViewController {
    private let editorView = EditorView()
    
    // MARK: - Transfer Data
    public var galleryImage: UIImage! = nil
    
    // MARK: - UI Elements
    private var imageView: UIImageView {
        editorView.imageView
    }
    
    override func loadView() {
        view = editorView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView.image = galleryImage
    }
}
