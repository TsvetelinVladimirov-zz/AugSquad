//
//  APIManager.swift
//  Swift 3.0 Snippets
//
//  Created by Tsvetelin Vladimirov on 12/16/16.
//  Copyright © 2016 Tsvetelin Vladimirov. All rights reserved.
//

import Foundation
import Alamofire

var LeagueID = 7
var RoundID = 1

class APIManager {
    
    static func getTeams(completion: @escaping ((_: [Game]) -> Void)) {
        
        Alamofire.request("http://perach.net/CUSTOM/predictor/apis/eplApiV1.php?action=getFixtureListByRoundID&round_id=\(RoundID)&leagueID=\(LeagueID)").responseString { (response: DataResponse<String>) in
            
            guard let result = response.result.value else {
                return
            }
            
            let dic = APIManager.convertStringToDictionary(text: result)
            print("fixture:\n", dic!)
            let gamesData = dic?["fixture_list"] as? [NSDictionary]
            
            guard gamesData != nil else {
                return
            }
            
            var games = [Game]()
            
            for data in gamesData! {
                games.append(Game(data: data))
            }
            
            completion(games)
        }
    }
    
    static func getFixtureDetailsForGame(game: Game, params: NSArray, completion: @escaping (() -> Void)) {
        
        Alamofire.request("http://perach.net/CUSTOM/predictor/apis/eplPredictResult.php?&fixture_round=1&predictionID=&year=\(params[14])&fixtureID=\(params[13])&leagueID=\(LeagueID)&h2hAtHomeWeight=\(params[0])&h2hAtAwayWeight=\(params[1])&homeRecordWeight=\(params[2])&awayRecordWeight=\(params[3])&ladderWeight=\(params[4])&plusMinOddsWeight=\(params[5])&daysBreakWeight=\(params[6])&last5MatchWeight=\(params[7])&favoriteWeight=\(params[7])&againstFavWeight=\(params[8])&dayOfMatchWeight=\(params[8])&wildCardWeight=\(params[9])&wildCardTeam=\(params[10])&teamA=\(params[11])&teamB=\(params[12])").responseString { (response: DataResponse<String>) in
            
            guard let result = response.result.value else {
                return
            }
            
            let dic = APIManager.convertStringToDictionary(text: result)
            print("Fixture details: \n", dic!)
            
            game.getPredictionFromData(data: dic!)
            
            completion()
        }
    }
    
    static func getTeamImageFromId(id: String) -> UIImage? {
        
        return UIImage(named: id)
    }
    
    static func convertStringToDictionary(text: String) -> NSDictionary? {
        if let data = text.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? NSDictionary
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }
}
