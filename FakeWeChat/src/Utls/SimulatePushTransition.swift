//
//  SimulatePushTransition.swift
//  FakeWeChat
//
//  Created by huangluyang on 16/1/1.
//  Copyright © 2016年 huangluyang. All rights reserved.
//

import UIKit

enum ModalPresentType: Int {
    case Present
    case Dismiss
}

class SimulatePushTransition: NSObject, UIViewControllerTransitioningDelegate, UIViewControllerAnimatedTransitioning {

    // MARK: - UIViewControllerTransitioningDelegate
    func interactionControllerForDismissal(animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return interactiveTransition
    }
    
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        modalPresentType = .Present
        return self
    }
    
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        modalPresentType = .Dismiss
        return self
    }
    
    // MARK: - UIViewControllerAnimatedTransitioning
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return 0.2
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView()!
        
        let from = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)!
        let to = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)!
        
        var destView: UIView!
        var destTransform = CGAffineTransformIdentity
        let windowWidth = UIApplication.tq_windowWidth()
        
        if modalPresentType == .Present {
            destView = to.view
            destView.transform = CGAffineTransformMakeTranslation(windowWidth, 0)
            containerView.addSubview(destView)
        } else {
            destView = from.view
            destTransform = CGAffineTransformMakeTranslation(windowWidth, 0)
        }
        
        UIView.animateWithDuration(transitionDuration(transitionContext), animations: { () -> Void in
            destView.transform = destTransform
            }) { (completed) -> Void in
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled())
        }
    }
    
    // MARK: - Properties
    var interactive = false
    var modalPresentType: ModalPresentType = .Present
    var interactiveTransition: UIPercentDrivenInteractiveTransition?
}
