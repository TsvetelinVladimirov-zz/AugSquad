//
//  PredictionWeightsTableView.swift
//  AugSquad
//
//  Created by Tsvetelin Vladimirov on 12/18/16.
//  Copyright © 2016 Tsvetelin Vladimirov. All rights reserved.
//

import UIKit

class PredictionWeightsTableView: UITableView {
    
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
        
        register(PredictionWeightsCell.self, forCellReuseIdentifier: "PredictionWeightsCell")
        cellLayoutMarginsFollowReadableWidth = false
        separatorInset = .zero
        layoutMargins = .zero
    }
}
