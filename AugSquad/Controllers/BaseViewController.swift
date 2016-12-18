//
//  BaseViewController.swift
//  Swift 3.0 Snippets
//
//  Created by Tsvetelin Vladimirov on 11/25/16.
//  Copyright © 2016 Tsvetelin Vladimirov. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    
    // MARK: - PROPERTIES
    
    // MARK: internal
    
    // MARK: fileprivate
    
    internal var activityIndicator: UIActivityIndicatorView! {
        didSet {
            activityIndicator.color = .gray
            activityIndicator.hidesWhenStopped = true
            UIApplication.shared.keyWindow?.addSubview(activityIndicator)
        }
    }
    
    // MARK: private
    
    // MARK: - override
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        activityIndicator = UIActivityIndicatorView()
        view.backgroundColor = .white
        activityIndicator = UIActivityIndicatorView()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        activityIndicator.stopAnimating()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        activityIndicator.frame = CGRect(x: view.frame.width / 2 - 15, y: view.frame.height / 2 - 15, width: 30, height: 30)
    }
    
    // MARK: - METHODS
    
    // MARK: internal
    
    // MARK: fileprivate
    
    // MARK: private
}
