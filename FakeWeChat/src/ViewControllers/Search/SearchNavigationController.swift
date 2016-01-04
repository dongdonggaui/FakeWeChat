//
//  SearchNavigationController.swift
//  FakeWeChat
//
//  Created by huangluyang on 16/1/4.
//  Copyright © 2016年 huangluyang. All rights reserved.
//

import UIKit

class SearchNavigationController: UINavigationController, UIGestureRecognizerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let pan = UIScreenEdgePanGestureRecognizer(target: self, action: "panGestureHandle:")
        pan.edges = .Left
        pan.delegate = self
        view.addGestureRecognizer(pan)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - UIGestureRecognizerDelegate
    func gestureRecognizerShouldBegin(gestureRecognizer: UIGestureRecognizer) -> Bool {
        return viewControllers.count == 1
    }
    
    // MARK: - Event Response
    func panGestureHandle(pan: UIScreenEdgePanGestureRecognizer) {
        var progress = pan.translationInView(view).x / view.bounds.size.width
        progress = min(1.0, max(0.0, progress))
        
        if pan.state == UIGestureRecognizerState.Began {
            print("Began")
            self.simulatePushTransition.interactiveTransition = UIPercentDrivenInteractiveTransition()
            self.dismissViewControllerAnimated(true, completion: nil)
        } else if pan.state == UIGestureRecognizerState.Changed {
            self.simulatePushTransition.interactiveTransition?.updateInteractiveTransition(progress)
            print("Changed")
        } else if pan.state == UIGestureRecognizerState.Ended || pan.state == UIGestureRecognizerState.Cancelled {
            if progress > 0.3 {
                self.simulatePushTransition.interactiveTransition?.finishInteractiveTransition()
            } else {
                self.simulatePushTransition.interactiveTransition?.cancelInteractiveTransition()
            }
            print("Ended || Cancelled")
            self.simulatePushTransition.interactiveTransition = nil
        }
    }
    
    // MARK: - Properties
    lazy var simulatePushTransition: SimulatePushTransition = {
        return self.transitioningDelegate as! SimulatePushTransition
    }()
}
