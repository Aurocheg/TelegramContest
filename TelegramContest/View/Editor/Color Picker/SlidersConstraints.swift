//
//  SlidersConstraints.swift
//  TelegramContest
//
//  Created by Aurocheg on 16.10.22.
//

import UIKit

final class SlidersConstraints: UIView {
    public func addConstraintsToSliderLabel(_ sliderLabel: UILabel, view: UIView, parent: AnyObject? = nil, topConstant: CGFloat = 28.0, heightConstant: CGFloat = 18.0, leftConstant: CGFloat? = nil) {
        sliderLabel.translatesAutoresizingMaskIntoConstraints = false
    
        if let parent = parent {
            sliderLabel.topAnchor.constraint(equalTo: parent.bottomAnchor, constant: topConstant).isActive = true
        } else {
            sliderLabel.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        }
        
        if let leftConstant = leftConstant {
            sliderLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: leftConstant).isActive = true
        } else {
            sliderLabel.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        }
        
        sliderLabel.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        sliderLabel.heightAnchor.constraint(equalToConstant: heightConstant).isActive = true
    }
    
    public func addConstraintsToHexLabel(_ hexLabel: UILabel, parent: UITextField, slider: UISlider) {
        hexLabel.translatesAutoresizingMaskIntoConstraints = false
        
        hexLabel.topAnchor.constraint(equalTo: slider.bottomAnchor, constant: 35.0).isActive = true
        hexLabel.rightAnchor.constraint(equalTo: parent.leftAnchor, constant: -12).isActive = true
        hexLabel.heightAnchor.constraint(equalToConstant: 22.0).isActive = true
    }
    
    public func addConstraintsToSlider(_ slider: UISlider, view: UIView, parent: UILabel, leftConstant: CGFloat? = nil) {
        slider.translatesAutoresizingMaskIntoConstraints = false
        
        slider.topAnchor.constraint(equalTo: parent.bottomAnchor, constant: 4.0).isActive = true
        
        if let leftConstant = leftConstant {
            slider.leftAnchor.constraint(equalTo: view.leftAnchor, constant: leftConstant).isActive = true
            slider.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7).isActive = true
        } else {
            slider.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
            slider.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.75).isActive = true
        }
        
        slider.heightAnchor.constraint(equalToConstant: 36.0).isActive = true
    }
    
    public func addConstraintsToSliderTF(_ sliderTF: UITextField, view: UIView, parent: AnyObject, rightConstant: CGFloat? = nil, topConstant: CGFloat = 4.0) {
        sliderTF.translatesAutoresizingMaskIntoConstraints = false
        
        sliderTF.topAnchor.constraint(equalTo: parent.bottomAnchor, constant: topConstant).isActive = true
        
        if let rightConstant = rightConstant {
            sliderTF.rightAnchor.constraint(equalTo: view.rightAnchor, constant: rightConstant).isActive = true
        } else {
            sliderTF.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        }

        sliderTF.widthAnchor.constraint(equalToConstant: 77.0).isActive = true
        sliderTF.heightAnchor.constraint(equalToConstant: 36.0).isActive = true
    }
}
