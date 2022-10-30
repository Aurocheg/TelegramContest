//
//  AccessConstraints.swift
//  TelegramContest
//
//  Created by Aurocheg on 12.10.22.
//

import UIKit

final class AccessConstraints: UIView {
    public func addConstraintsToContainer(_ accessContainerView: UIView, view: UIView) {
        accessContainerView.translatesAutoresizingMaskIntoConstraints = false
        
        accessContainerView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        accessContainerView.heightAnchor.constraint(equalToConstant: 266.0).isActive = true
        accessContainerView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        accessContainerView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
    }
    
    public func addConstraintsToAnimationView(_ animationView: UIView, containerView: UIView) {
        animationView.translatesAutoresizingMaskIntoConstraints = false
        
        animationView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        animationView.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
        animationView.widthAnchor.constraint(equalToConstant: 144.0).isActive = true
        animationView.heightAnchor.constraint(equalToConstant: 144.0).isActive = true
    }
    
    public func addConstraintsToLabel(_ accessLabel: UILabel, containerView: UIView, parent: AnyObject) {
        accessLabel.translatesAutoresizingMaskIntoConstraints = false
        
        accessLabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        accessLabel.topAnchor.constraint(equalTo: parent.bottomAnchor, constant: 20.0).isActive = true
    }
    
    public func addConstraintsToButton(_ button: UIButton, containerView: UIView, parent: AnyObject) {
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 16.0).isActive = true
        button.topAnchor.constraint(equalTo: parent.bottomAnchor, constant: 28.0).isActive = true
        button.widthAnchor.constraint(equalTo: containerView.widthAnchor, constant: -32.0).isActive = true
        button.heightAnchor.constraint(equalToConstant: 50.0).isActive = true
    }

}
