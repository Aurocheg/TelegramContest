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
        let halfHeight = bounds.height / 2
        return CGRect(x: 0, y: halfHeight / 2, width: bounds.width, height: halfHeight * 2)
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
