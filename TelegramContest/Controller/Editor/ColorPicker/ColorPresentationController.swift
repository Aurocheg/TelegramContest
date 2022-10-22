//
//  ColorPickerController.swift
//  TelegramContest
//
//  Created by Aurocheg on 15.10.22.
//

import UIKit

class ColorPresentationController: UIPresentationController {
    override var frameOfPresentedViewInContainerView: CGRect {
        let bounds = containerView!.bounds
        let height = bounds.height
        let width = bounds.width
        var constant = 30.0
        var rect = CGRect()

        if height >= 896.0 {
            constant = 10.0
            rect = CGRect(x: 0, y: height / 4 + constant, width: width, height: height * 2 - constant)
        } else if height >= 812.0 && height < 896.0 {
            constant = 50.0
            rect = CGRect(x: 0, y: height / 4 - constant, width: width, height: height * 2 + constant)
        } else {
            constant = 200.0
            rect = CGRect(x: 0, y: height / 3 - constant, width: width, height: height * 2 + constant)
        }
        
        return rect
    }
    
    override func presentationTransitionWillBegin() {
        super.presentationTransitionWillBegin()
        containerView?.addSubview(presentedView!)
    }
    
    override func containerViewDidLayoutSubviews() {
        super.containerViewDidLayoutSubviews()
        presentedView?.frame = frameOfPresentedViewInContainerView
    }
}
