//
//  AccessConstraints.swift
//  TelegramContest
//
//  Created by Aurocheg on 12.10.22.
//

import UIKit

final class AccessConstraints: UIView {

    public func addConstraintsToImageView(_ accessImageView: UIImageView, view: UIView) {
        accessImageView.translatesAutoresizingMaskIntoConstraints = false
        
        accessImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 290.0).isActive = true
        accessImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        accessImageView.widthAnchor.constraint(equalToConstant: 144.0).isActive = true
        accessImageView.heightAnchor.constraint(equalToConstant: 144.0).isActive = true
    }
    
    public func addConstraintsToLabel(_ accessLabel: UILabel, view: UIView, parent: AnyObject) {
        accessLabel.translatesAutoresizingMaskIntoConstraints = false
        
        accessLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        accessLabel.topAnchor.constraint(equalTo: parent.bottomAnchor, constant: 20.0).isActive = true
    }
    
    public func addConstraintsToButton(_ button: UIButton, view: UIView, parent: AnyObject) {
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16.0).isActive = true
        button.topAnchor.constraint(equalTo: parent.bottomAnchor, constant: 28.0).isActive = true
        button.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -32.0).isActive = true
        button.heightAnchor.constraint(equalToConstant: 50.0).isActive = true
    }

}
