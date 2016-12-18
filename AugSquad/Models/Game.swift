//
//  Game.swift
//  AugSquad
//
//  Created by Tsvetelin Vladimirov on 12/17/16.
//  Copyright © 2016 Tsvetelin Vladimirov. All rights reserved.
//

import Foundation

enum Winner {
    case firstTeam
    case secondTeam
    case draw
}

class Game {
    
    // MARK: - PROPERTIES
    
    // MARK: internal
    
    internal var firstTeam: Team!
    internal var secondTeam: Team!
    internal var dateAndTime: String!
    internal var id: String = ""
    internal var winner = Winner.draw
    
    internal var h2hHome: String = "0.0%"
    internal var h2hAway: String = "0.0%"
    internal var homeRecord: String = "0.0%"
    internal var awayRecord: String = "0.0%"
    internal var favorite: String = "0.0%"
    internal var againstTheOdds: String = "0.0%"
    internal var ladder: String = "0.0%"
    internal var plusMinOdds: String = "0.0%"
    internal var daysBreak: String = "0.0%"
    internal var dayOfMatch: String = "0.0%"
    internal var last5Matches: String = "0.0%"
    internal var wildCard: String = "0.0%"
    
    internal var predictedWonOdds: String = "0"
    internal var predictedDrawOdds: String = "0"
    internal var predictedLostOdds: String = "0"
    
    internal var predictedTeamAHT: String = "0"
    internal var predictedTeamAFT: String = "0"
    internal var predictedTeamBHT: String = "0"
    internal var predictedTeamBFT: String = "0"
    internal var predictedTeamName: String = ""
    
    init(data: NSDictionary) {
        
        firstTeam = Team()
        secondTeam = Team()
        if let value = data["away_team_name"] as? String {
            secondTeam.name = value
        }
        
        if let value = data["home_team_name"] as? String {
            firstTeam.name = value
        }
        
        if let value = data["shortNameAway"] as? String {
            secondTeam.shortName = value
        }
        
        if let value = data["shortNameHome"] as? String {
            firstTeam.shortName = value
        }
        
        if let value = data["date"] as? String {
            dateAndTime = value
        }
        
        if let value = data["time"] as? String {
            if !value.isEmpty {
                dateAndTime = dateAndTime + ", " + value
            }
        }
        
        if let value = data["fixtureID"] as? String {
            id = value
        }
        
        if let value = data["teamARank"] as? String {
            firstTeam.rank = value
        }
        
        if let value = data["teamBRank"] as? String {
            secondTeam.rank = value
        }
        
        if let value = data["teamA"] as? String {
            firstTeam.id = value
        }
        
        if let value = data["teamB"] as? String {
            secondTeam.id = value
        }
        
        if let value = data["teamA_Odds"] as? String {
            if value == "WON" {
                winner = .firstTeam
            } else if value == "LOST" {
                winner = .secondTeam
            } else {
                winner = .draw
            }
        }
    }
    
    func getPredictionFromData(data: NSDictionary) {
        
        if let value = data["h2hhome"] as? String {
            h2hHome = value
        }
        
        if let value = data["h2haway"] as? String {
           h2hAway = value
        }
        
        if let value = data["homerecord"] as? String {
            homeRecord = value
        }
        
        if let value = data["awayrecord"] as? String {
           awayRecord = value
        }
        
        if let value = data["favorite"] as? String {
           favorite = value
        }
        
        if let value = data["againstTheOdds"] as? String {
           againstTheOdds = value
        }
        
        if let value = data["ladder"] as? String {
           ladder = value
        }
        
        if let value = data["plusMinOdds"] as? String {
           plusMinOdds = value
        }
        
        if let value = data["daysBreak"] as? String {
           daysBreak = value
        }
        
        if let value = data["dayOfMatch"] as? String {
           dayOfMatch = value
        }
        
        if let value = data["last5Matches"] as? String {
           last5Matches = value
        }
        
        if let value = data["predictedWonOdds"] as? String {
           predictedWonOdds = value
        }
        
        if let value = data["predictedDrawOdds"] as? String {
           predictedDrawOdds = value
        }
        
        if let value = data["predictedLostOdds"] as? String {
           predictedLostOdds = value
        }
        
        if let value = data["predictedTeamAHT"] as? String {
           predictedTeamAHT = value
        }
        
        if let value = data["predictedTeamAFT"] as? String {
           predictedTeamAFT = value
        }
        
        if let value = data["predictedTeamBHT"] as? String {
           predictedTeamBHT = value
        }
        
        if let value = data["predictedTeamBFT"] as? String {
           predictedTeamBFT = value
        }
        
        if let value = data["predictedTeamName"] as? String {
            predictedTeamName = value
        }
    }
}
