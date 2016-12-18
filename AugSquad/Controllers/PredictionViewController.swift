//
//  PredictionViewController.swift
//  AugSquad
//
//  Created by Tsvetelin Vladimirov on 12/17/16.
//  Copyright © 2016 Tsvetelin Vladimirov. All rights reserved.
//

import UIKit

class PredictionViewController: BaseViewController {
    
    // MARK: - PROPERTIES
    
    // MARK: internal
    
    internal var game: Game!
    
    // MARK: fileprivate
    
    // MARK: private
    
    private var cell: GameTableViewCell! {
        didSet {
            cell.firstImage = APIManager.getTeamImageFromId(id: game.firstTeam.id)
            cell.secondImage = APIManager.getTeamImageFromId(id: game.secondTeam.id)
            cell.firstTeamName = game.firstTeam.shortName
            cell.secondTeamName = game.secondTeam.shortName
            cell.date = game.dateAndTime
            view.addSubview(cell)
        }
    }
    
    private var matchWinnerLabel: UILabel! {
        didSet {
            matchWinnerLabel.numberOfLines = 2
            matchWinnerLabel.backgroundColor = .orange
            matchWinnerLabel.layer.borderWidth = 0.5
            matchWinnerLabel.font = UIFont.boldSystemFont(ofSize: 15)
            matchWinnerLabel.text = "Match winner\n" + game.predictedTeamName
            matchWinnerLabel.textAlignment = .center
            view.addSubview(matchWinnerLabel)
        }
    }
    
    private var wonLabel: UILabel! {
        didSet {
            wonLabel.textAlignment = .center
            wonLabel.text = "$" + game.predictedWonOdds
            view.addSubview(wonLabel)
        }
    }
    
    private var drawLabel: UILabel! {
        didSet {
            drawLabel.textAlignment = .center
            drawLabel.text = "$" + game.predictedDrawOdds
            view.addSubview(drawLabel)
        }
    }
    
    private var loseLabel: UILabel! {
        didSet {
            loseLabel.textAlignment = .center
            loseLabel.text = "$" + game.predictedLostOdds
            view.addSubview(loseLabel)
        }
    }
    
    private var hTScoreLabel: UILabel! {
        didSet {
            hTScoreLabel.backgroundColor = .orange
            hTScoreLabel.textAlignment = .center
            hTScoreLabel.layer.borderWidth = 1
            hTScoreLabel.text = "Half Time Score"
            view.addSubview(hTScoreLabel)
        }
    }
    
    private var hTLeftLabel: UILabel! {
        didSet {
            hTLeftLabel.textAlignment = .center
            hTLeftLabel.text = game.predictedTeamAHT
            view.addSubview(hTLeftLabel)
        }
    }
    
    private var hTRightLabel: UILabel! {
        didSet {
            hTRightLabel.textAlignment = .center
            hTRightLabel.text = game.predictedTeamBHT
            view.addSubview(hTRightLabel)
        }
    }
    
    private var fTScoreLabel: UILabel! {
        didSet {
            fTScoreLabel.backgroundColor = .orange
            fTScoreLabel.layer.borderWidth = 1
            fTScoreLabel.textAlignment = .center
            fTScoreLabel.text = "Full Time Score"
            view.addSubview(fTScoreLabel)
        }
    }
    
    private var fTLeftLabel: UILabel! {
        didSet {
            fTLeftLabel.textAlignment = .center
            fTLeftLabel.text = game.predictedTeamAFT
            view.addSubview(fTLeftLabel)
        }
    }
    
    private var fTRightLabel: UILabel! {
        didSet {
            fTRightLabel.textAlignment = .center
            fTRightLabel.text = game.predictedTeamBFT
            view.addSubview(fTRightLabel)
        }
    }
    
    // MARK: - override
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cell = GameTableViewCell()
        matchWinnerLabel = UILabel()
        wonLabel = UILabel()
        drawLabel = UILabel()
        loseLabel = UILabel()
        hTScoreLabel = UILabel()
        hTLeftLabel = UILabel()
        hTRightLabel = UILabel()
        fTScoreLabel = UILabel()
        fTLeftLabel = UILabel()
        fTRightLabel = UILabel()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        cell.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 100)
        matchWinnerLabel.frame = CGRect(x: 0, y: cell.frame.maxY, width: view.frame.width, height: 50)
        wonLabel.frame = CGRect(x: 0, y: matchWinnerLabel.frame.maxY, width: view.frame.width / 3, height: 30)
        drawLabel.frame = CGRect(x: view.frame.width / 3, y: matchWinnerLabel.frame.maxY, width: view.frame.width / 3, height: 30)
        loseLabel.frame = CGRect(x: view.frame.width / 3 * 2, y: matchWinnerLabel.frame.maxY, width: view.frame.width / 3, height: 30)
        hTScoreLabel.frame = CGRect(x: 0, y: drawLabel.frame.maxY, width: view.frame.width, height: 30)
        hTLeftLabel.frame = CGRect(x: 0, y: hTScoreLabel.frame.maxY, width: view.frame.width / 2, height: 30)
        hTRightLabel.frame = CGRect(x: view.frame.width / 2, y: hTScoreLabel.frame.maxY, width: view.frame.width / 2, height: 30)
        fTScoreLabel.frame = CGRect(x: 0, y: hTLeftLabel.frame.maxY, width: view.frame.width, height: 30)
        fTLeftLabel.frame = CGRect(x: 0, y: fTScoreLabel.frame.maxY, width: view.frame.width / 2, height: 30)
        fTRightLabel.frame = CGRect(x: view.frame.width / 2, y: fTScoreLabel.frame.maxY, width: view.frame.width / 2, height: 30)
    }
    
    // MARK: - METHODS
    
    // MARK: internal
    
    // MARK: fileprivate
    
    // MARK: private
}
