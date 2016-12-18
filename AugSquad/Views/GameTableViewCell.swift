//
//  GameTableViewCell.swift
//  Swift 3.0 Snippets
//
//  Created by Tsvetelin Vladimirov on 12/16/16.
//  Copyright © 2016 Tsvetelin Vladimirov. All rights reserved.
//

import UIKit

class GameTableViewCell: UITableViewCell {
    
    // MARK: - PROPERTIES
    
    // MARK: internal
    
    internal var firstImage: UIImage! {
        didSet {
            firstImageView.image = firstImage
        }
    }
    
    internal var secondImage: UIImage! {
        didSet {
            secondImageView.image = secondImage
        }
    }
    
    internal var firstTeamName: String! {
        didSet {
            firstTeamNameLabel.font = UIFont.boldSystemFont(ofSize: 15)
            firstTeamNameLabel.text = firstTeamName
        }
    }
    
    internal var secondTeamName: String! {
        didSet {
            secondTeamNameLabel.font = UIFont.boldSystemFont(ofSize: 15)
            secondTeamNameLabel.text = secondTeamName
        }
    }
    
    internal var date: String! {
        didSet {
            dateLabel.text = date
        }
    }
    
    // MARK: private
    
    private var firstImageView: UIImageView! {
        didSet {
            firstImageView.border()
            firstImageView.contentMode = .scaleAspectFit
            contentView.addSubview(firstImageView)
        }
    }
    
    private var firstTeamNameLabel: UILabel! {
        didSet {
            firstTeamNameLabel.border()
            firstTeamNameLabel.textAlignment = .center
            contentView.addSubview(firstTeamNameLabel)
        }
    }
    
    private var secondImageView: UIImageView! {
        didSet {
            secondImageView.border()
            secondImageView.contentMode = .scaleAspectFit
            contentView.addSubview(secondImageView)
        }
    }
    
    private var secondTeamNameLabel: UILabel! {
        didSet {
            secondTeamNameLabel.border()
            secondTeamNameLabel.textAlignment = .center
            contentView.addSubview(secondTeamNameLabel)
        }
    }
    
    private var vsImageView: UIImageView! {
        didSet {
            vsImageView.image = UIImage(named: "vs")
            vsImageView.contentMode = .scaleAspectFit
            contentView.addSubview(vsImageView)
        }
    }
    
    private var dateLabel: UILabel! {
        didSet {
            dateLabel.border()
            dateLabel.font = UIFont.boldSystemFont(ofSize: 12)
            dateLabel.textAlignment = .center
            contentView.addSubview(dateLabel)
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
        
        let labelHeight: CGFloat = 20
        let offset: CGFloat = 8
        let vsSize: CGFloat = 50
        
        contentView.frame = CGRect(x: offset, y: offset, width: frame.width - offset*2, height: frame.height - offset*2)
        firstImageView.frame = CGRect(x: 0, y: 0, width: contentView.frame.height - labelHeight, height: contentView.frame.height - labelHeight)
        firstTeamNameLabel.frame = CGRect(x: firstImageView.frame.minX, y: contentView.frame.height - labelHeight, width: firstImageView.frame.width, height: labelHeight)
        secondImageView.frame = CGRect(x: contentView.frame.width - (contentView.frame.height - labelHeight), y: 0, width: contentView.frame.height - labelHeight, height: contentView.frame.height - labelHeight)
        secondTeamNameLabel.frame = CGRect(x: secondImageView.frame.minX, y: contentView.frame.height - labelHeight, width: secondImageView.frame.width, height: labelHeight)
        
        vsImageView.frame = CGRect(x: (contentView.frame.width - vsSize) / 2, y: (contentView.frame.height - vsSize) / 2, width: vsSize, height: vsSize)
        dateLabel.frame = CGRect(x: firstTeamNameLabel.frame.maxX + offset, y: contentView.frame.height - labelHeight - offset, width: secondTeamNameLabel.frame.minX - firstTeamNameLabel.frame.maxX - offset*2, height: labelHeight)
    }
    
    fileprivate func setup() {
        
        firstImageView = UIImageView()
        firstTeamNameLabel = UILabel()
        secondImageView = UIImageView()
        secondTeamNameLabel = UILabel()
        vsImageView = UIImageView()
        dateLabel = UILabel()
        
        layoutMargins = .zero
    }
}
