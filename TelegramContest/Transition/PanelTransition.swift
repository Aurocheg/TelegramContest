//
//  PanelTransition.swift
//  TelegramContest
//
//  Created by Aurocheg on 16.10.22.
//

import Foundation
import UIKit

class PanelTransition: NSObject, UIViewControllerTransitioningDelegate {
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return ColorPresentationController(presentedViewController: presented, presenting: presenting ?? source)
    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return PresentAnimation()
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return DismissAnimation()
    }
}
