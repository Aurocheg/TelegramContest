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
    private var toolbar: UIToolbar {
        editorView.toolbar
    }
    
    private var imageView: UIImageView {
        editorView.imageView
    }
    
    override func loadView() {
        view = editorView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView.image = galleryImage
        
        var leftBarButtonItem = UIBarButtonItem()
        let rightBarButtonItem = UIBarButtonItem(title: "Clear All", style: .plain, target: self, action: nil)
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        
        if let image = UIImage(named: "undo") {
            leftBarButtonItem = UIBarButtonItem(image: image, style: .plain, target: self, action: nil)
        }
        
        toolbar.setItems([leftBarButtonItem, flexibleSpace, rightBarButtonItem], animated: true)
    }
}
