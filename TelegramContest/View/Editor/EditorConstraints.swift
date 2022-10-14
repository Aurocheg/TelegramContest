//
//  EditorConstraints.swift
//  TelegramContest
//
//  Created by Aurocheg on 14.10.22.
//

import UIKit

final class EditorConstraints: UIView {
    public func addConstraintsToToolbar(_ toolBar: UIToolbar, view: UIView) {
        toolBar.translatesAutoresizingMaskIntoConstraints = false
        
        toolBar.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        toolBar.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        toolBar.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        toolBar.heightAnchor.constraint(equalToConstant: 44).isActive = true
    }
    
    public func addConstraintsToImage(_ imageView: UIImageView, view: UIView, parent: AnyObject) {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        imageView.topAnchor.constraint(equalTo: parent.bottomAnchor, constant: 42.0).isActive = true
        imageView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        imageView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 520.0).isActive = true
    }
}
