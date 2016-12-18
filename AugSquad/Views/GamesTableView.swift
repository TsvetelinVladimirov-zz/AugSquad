//
//  GamesTableView.swift
//  Swift 3.0 Snippets
//
//  Created by Tsvetelin Vladimirov on 12/16/16.
//  Copyright © 2016 Tsvetelin Vladimirov. All rights reserved.
//

import UIKit

class GamesTableView: UITableView {
    
    // MARK: - OVERRIDE
    
    override init(frame: CGRect, style: UITableViewStyle) {
        super.init(frame: frame, style: style)
        
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setup()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        
    }
    
    // MARK: - METHODS
    
    // MARK: fileprivate
    
    fileprivate func setup() {
        
        register(GameTableViewCell.self, forCellReuseIdentifier: "GameTableViewCell")
        cellLayoutMarginsFollowReadableWidth = false
        separatorInset = .zero
        layoutMargins = .zero
    }
}
