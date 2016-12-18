//
//  PredictionWeightsCell.swift
//  AugSquad
//
//  Created by Tsvetelin Vladimirov on 12/18/16.
//  Copyright © 2016 Tsvetelin Vladimirov. All rights reserved.
//

import UIKit

class PredictionWeightsCell: UITableViewCell {
    
    // MARK: - PROPERTIES
    
    // MARK: internal
    
    internal var weight: String! {
        didSet {
            weightLabel.text = weight
        }
    }
    
    internal var weightName: String! {
        didSet {
            weightNameLabel.text = weightName
        }
    }
    
    // MARK: private
    
    private var weightLabel: UILabel! {
        didSet {
            weightLabel.textAlignment = .center
            addSubview(weightLabel)
        }
    }
    
    private var weightNameLabel: UILabel! {
        didSet {
            addSubview(weightNameLabel)
        }
    }
    
    // MARK: - OVERRIDE
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setup()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let offset: CGFloat = 8
        
        weightLabel.frame = CGRect(x: frame.width - 50 - offset, y: 0, width: 50, height: frame.height)
        weightNameLabel.frame = CGRect(x: offset, y: 0, width: weightLabel.frame.minX - offset*2, height: frame.height)
    }
    
    // MARK: - METHODS
    
    // MARK: fileprivate
    
    fileprivate func setup() {
        
        layoutMargins = .zero
        weightLabel = UILabel()
        weightNameLabel = UILabel()
    }
}
