//
//  GamesViewController.swift
//  Swift 3.0 Snippets
//
//  Created by Tsvetelin Vladimirov on 12/16/16.
//  Copyright © 2016 Tsvetelin Vladimirov. All rights reserved.
//

import UIKit

class GamesViewController: BaseViewController {
    
    // MARK: - PROPERTIES
    
    // MARK: internal
    
    internal var games = [Game]() {
        didSet {
            gamesTableView.reloadData()
        }
    }
    
    // MARK: fileprivate
    
    // MARK: private
    
    private var gamesTableView: GamesTableView! {
        didSet {
            gamesTableView.delegate = self
            gamesTableView.dataSource = self
            view.addSubview(gamesTableView)
        }
    }
    
    // MARK: - override
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Games"
        gamesTableView = GamesTableView()
        
        activityIndicator.startAnimating()
        APIManager.getTeams { (games) in
            self.activityIndicator.stopAnimating()
            self.games = games
        }
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        gamesTableView.frame = view.bounds
    }
    
    // MARK: - METHODS
    
    // MARK: internal
    
    // MARK: fileprivate
    
    // MARK: private
}

extension GamesViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 120
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        let gameDetailsController = GameDetailsViewController()
        gameDetailsController.game = games[indexPath.row]
        navigationController?.pushViewController(gameDetailsController, animated: true)
    }
}

extension GamesViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return games.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "GameTableViewCell") as! GameTableViewCell
        
        let game = games[indexPath.row]
        
        cell.firstImage = APIManager.getTeamImageFromId(id: game.firstTeam.id)
        cell.secondImage = APIManager.getTeamImageFromId(id: game.secondTeam.id)
        cell.firstTeamName = game.firstTeam.shortName
        cell.secondTeamName = game.secondTeam.shortName
        cell.date = game.dateAndTime
        
        return cell
    }
}

extension UIView {
    
    func border() {
//        layer.borderWidth = 1
    }
}
