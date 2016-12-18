//
//  View.swift
//  Swift 3.0 Snippets
//
//  Created by Tsvetelin Vladimirov on 11/25/16.
//  Copyright © 2016 Tsvetelin Vladimirov. All rights reserved.
//

import UIKit

class View: UIView {
    
    init() {
        super.init(frame: CGRect.zero)
        
        setup()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setup()
    }
    
    private func setup() {
        
        backgroundColor = .white
        clipsToBounds = false
        tag = 0
    }
}
