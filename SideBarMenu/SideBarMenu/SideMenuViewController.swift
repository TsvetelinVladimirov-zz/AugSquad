//
//  ViewController.swift
//  SideBarMenu
//
//  Created by Dimitar Kostov on 7/28/15.
//  Copyright (c) 2015 158ltd.com. All rights reserved.
//

import UIKit

/**
Enum structure for opening/closing side menu

- BothCollapsed:      case no side menu opened
- LeftPanelExpanded:  case left side menu opened
*/
enum SlideOutState {
    case BothCollapsed
    case LeftPanelExpanded
}

/**
enum structure to determine which Panel should show

- Left:  Left Panel
- Right: Right Panel
*/
enum Position {
    case Left
    case None
}

class SideMenuViewController: UIViewController, HomeVCDelegate {
    
    let CENTER_PANEL_EXPANDED_OFFSET: CGFloat = UIScreen.mainScreen().bounds.width - ( UIScreen.mainScreen().bounds.width - 50 )

    
    var leftVC: LeftVC? = LeftVC()
    var homeVC = HomeVC()
    var navController = UINavigationController()
    private var movingLeft: Bool!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.greenColor()
        
        setupViewControllers()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    //MARK: - Panel's logic
    private var currentState: SlideOutState = .BothCollapsed {
        didSet {
            let shouldShowShadow = currentState != .BothCollapsed
            showShadowForCenterViewController(shouldShowShadow)
            
            // disable user interactions on opening side menu, enable on closing
            if currentState != .BothCollapsed {
                homeVC.view.userInteractionEnabled = false
            } else {
                homeVC.view.userInteractionEnabled = true
            }
        }
    }

    /**
    shadow for conten view controller depending on the direction
    :param: shouldShowShadow    determining if shadow should be shown
    */
    private func showShadowForCenterViewController(shouldShowShadow: Bool) {
        if (shouldShowShadow) {
            navController.view.layer.shadowOpacity = 0.8
        } else {
            navController.view.layer.shadowOpacity = 0.0
        }
    }
    
    //MARK: - ContentVCDelegate methods
    
    /**
    Opening/closing side menu trough navigation bar buttons
    
    :param: position determine which side should be opened/closed
    */
    func toggleSideMenu(position: Position) {
        
        if position == .Left {
            let notAlreadyExpanded = (currentState != .LeftPanelExpanded)
            
            if notAlreadyExpanded {
                addSideMenuViewController(&leftVC, identfier: "LeftVC")
            }
            
            animateLeftPanel(shouldExpand: notAlreadyExpanded)
        }
        //In case we are in edditing mode (keyboard was shown), we cancel it on opening the side menus
        self.view.endEditing(true)
    }

    
    /**
    *   Setting up and adding UIViewController for left and right panel
    */
    private func addSideMenuViewController(inout controller: LeftVC?, identfier: String) {
        if controller == nil {
            controller = self.storyboard?.instantiateViewControllerWithIdentifier(identfier) as? LeftVC
            
            if controller != nil {
                view.insertSubview(controller!.view, atIndex: 0)
                addChildViewController(controller!)
                controller!.didMoveToParentViewController(self)
            } else {
                print("crash: missing SideMenuViewController")
            }
        }
    }
    
    func setupViewControllers() {
        
        
//        addSideMenuViewController(&self.leftVC, identfier: "LeftVC")
        
        self.leftVC = self.storyboard?.instantiateViewControllerWithIdentifier("LeftVC") as? LeftVC
        self.view.addSubview(leftVC!.view)
        self.addChildViewController(leftVC!)
        leftVC!.didMoveToParentViewController(self)

        
        addHomeViewController(&navController, storyboardID: "NavigationController")
        
    }
    
    func addHomeViewController(inout navigationController: UINavigationController, storyboardID: String) {
        
        navigationController = storyboard!.instantiateViewControllerWithIdentifier(storyboardID) as! UINavigationController
        self.view.addSubview(navigationController.view)
        self.addChildViewController(navigationController)
        navigationController.didMoveToParentViewController(self)
        
        //creating and configuring static panGesture to open/close side menus
        addTargetWithView(navigationController.view, target: self, selector: "handlePanGesture:")
        
        if let homeVC = navigationController.viewControllers[0] as? HomeVC {
            homeVC.view.backgroundColor = UIColor.purpleColor()
            homeVC.delegate = self
        }
    }
    
    func menuButtonPressed() {
        
        if navController.view.frame.origin.x == 0 {
            navController.view.frame = CGRectMake(navController.view.frame.size.width - 50, 0, navController.view.frame.size.width, navController.view.frame.size.height)
        } else {
            navController.view.frame = CGRectMake(0, 0, navController.view.frame.size.width, navController.view.frame.size.height)
        }
    }
    
    static let panGestureRecognizer: UIPanGestureRecognizer = UIPanGestureRecognizer()
    
    func addTargetWithView(view: UIView, target: AnyObject, selector: Selector) {
        SideMenuViewController.panGestureRecognizer.addTarget(target, action: selector)
        view.addGestureRecognizer(SideMenuViewController.panGestureRecognizer)
    }
    
    private func animateLeftPanel(shouldExpand shouldExpand: Bool) {
        
        if (shouldExpand) {
            currentState = .LeftPanelExpanded
            
            animateCenterPanelXPosition(targetPosition: CGRectGetWidth(navController.view.frame) - CENTER_PANEL_EXPANDED_OFFSET)
        } else {
            
            animateCenterPanelXPosition(targetPosition: 0) { _ in
                self.currentState = .BothCollapsed
                
                if self.leftVC != nil {
                    self.leftVC!.view.removeFromSuperview()
                }
                self.leftVC = nil
            }
        }
    }
    
    /**
    animation for center content panel
    
    :param: targetPosition  CGFloat - position of the panel
    :param: completion      completion block to finish the animation
    */
    private func animateCenterPanelXPosition(targetPosition targetPosition: CGFloat, completion: ((Bool) -> Void)! = nil) {
        
        UIView.animateWithDuration(0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .CurveEaseInOut, animations: {
            self.navController.view.frame.origin.x = targetPosition
            }, completion: completion)
    }

}

extension SideMenuViewController {
    
    //Warning this function needs to be with protected accessor, currently no protected at Swift 1.2
    func handlePanGesture(recognizer: UIPanGestureRecognizer) {
        
        if recognizer.view == nil {
           print("Somehow we managed to screw up again")
            return
        }
        
        //In case we are in edditing mode, we cancel it on opening the side menus
        self.view.endEditing(true)
        
        //determining the direction of scroll
        let velocity = (recognizer.velocityInView(view).x > 0)
        
        /**
        *  recognizer handler depending on current state
        */
        switch(recognizer.state) {
        case .Began:
            if (currentState == .BothCollapsed) {
                if (velocity) {
                    movingLeft = false
                    addSideMenuViewController(&leftVC, identfier: "LeftVC")

                }
                
                showShadowForCenterViewController(true)
            }
        case .Changed:
            if(velocity) {
                if movingLeft == true {
                    recognizer.view!.center.x = min(min(recognizer.view!.center.x + recognizer.translationInView(view).x, recognizer.view!.frame.size.width/2), recognizer.view!.frame.width*1.5 - CENTER_PANEL_EXPANDED_OFFSET)
                } else {
                    recognizer.view!.center.x = min(recognizer.view!.center.x + recognizer.translationInView(view).x, recognizer.view!.frame.width*1.5 - CENTER_PANEL_EXPANDED_OFFSET)
                }
            } else {
                if movingLeft == false {
                    recognizer.view!.center.x = max(max(recognizer.view!.center.x + recognizer.translationInView(view).x, recognizer.view!.frame.size.width/2), -recognizer.view!.frame.width*0.5 + CENTER_PANEL_EXPANDED_OFFSET)
                } else {
                    recognizer.view!.center.x = max(recognizer.view!.center.x + recognizer.translationInView(view).x, -recognizer.view!.frame.width*0.5 + CENTER_PANEL_EXPANDED_OFFSET)
                }
            }
            recognizer.setTranslation(CGPointZero, inView: view)
        case .Ended: if (leftVC != nil) { animateLeftPanel(shouldExpand: velocity) }
        default: break
        }
    }
    
    
}

