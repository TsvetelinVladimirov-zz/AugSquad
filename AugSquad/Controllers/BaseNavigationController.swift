//
//  BaseNavigationController.swift
//  Swift 3.0 Snippets
//
//  Created by Tsvetelin Vladimirov on 12/16/16.
//  Copyright © 2016 Tsvetelin Vladimirov. All rights reserved.
//

import UIKit

class BaseNavigationController: UINavigationController {
    
    // MARK: - OVERRIDE
    
    override init(rootViewController rootController: UIViewController) {
        super.init(rootViewController: rootController)
        
        setup()
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setup()
    }
    
    // MARK: - METHODS
    
    // MARK: fileprivate
    
    fileprivate func setup() {
        
        navigationBar.barTintColor = .black
        navigationBar.isTranslucent = false
        navigationBar.barStyle = .black
        navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.orange]
    }
}
