//
//  GameDetailsViewController.swift
//  AugSquad
//
//  Created by Tsvetelin Vladimirov on 12/17/16.
//  Copyright © 2016 Tsvetelin Vladimirov. All rights reserved.
//

import UIKit

class GameDetailsViewController: BaseViewController {
    
    // MARK: - PROPERTIES
    
    // MARK: internal
    
    internal var game: Game!
    
    // MARK: fileprivate
    
    fileprivate var stats = [(name: String, value: Int)]()
    
    fileprivate var shouldInitializeSecondColumn: Bool = false
    fileprivate var pickedValue: (statIndex: Int, name: String, value: Int) = (0, "", 0)
    
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
    
    private var predictButton: UIButton! {
        didSet {
            predictButton.backgroundColor = .black
            predictButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
            predictButton.setTitle("Predict results", for: .normal)
            predictButton.setTitleColor(.orange, for: .normal)
            predictButton.setTitleColor(.gray, for: .disabled)
            predictButton.addTarget(self, action: #selector(predictButtonPressed), for: .touchUpInside)
            view.addSubview(predictButton)
        }
    }
    
    private var percentLabel: UILabel! {
        didSet {
            percentLabel.text = "100%"
            percentLabel.layer.borderWidth = 1
            percentLabel.textColor = .orange
            percentLabel.textAlignment = .center
            view.addSubview(percentLabel)
        }
    }
    
    private var startYear: Int = 2000
    private var endYear: Int = 2014
    
    private var startYearLabel: UILabel! {
        didSet {
            startYearLabel.text = "\(startYear)"
            startYearLabel.textAlignment = .center
            view.addSubview(startYearLabel)
        }
    }
    
    private var endYearLabel: UILabel! {
        didSet {
            endYearLabel.text = "\(endYear)"
            endYearLabel.textAlignment = .center
            view.addSubview(endYearLabel)
        }
    }
    
    private var yearSlider: UISlider! {
        didSet {
            yearSlider.tintColor = .orange
            yearSlider.addTarget(self, action: #selector(yearSliderValueChanged(slider:)), for: .valueChanged)
            yearSlider.isContinuous = false
            view.addSubview(yearSlider)
        }
    }
    
    private var weightsTableView: PredictionWeightsTableView! {
        didSet {
            weightsTableView.delegate = self
            weightsTableView.dataSource = self
            view.addSubview(weightsTableView)
        }
    }
    
    fileprivate var cancelViewButton: UIButton! {
        didSet {
            guard cancelViewButton != nil else {
                return
            }
            
            cancelViewButton.backgroundColor = UIColor.black.withAlphaComponent(0.3)
            cancelViewButton.addTarget(self, action: #selector(pickerCancelButtonPressed), for: .touchUpInside)
            view.addSubview(cancelViewButton)
        }
    }
    
    fileprivate var pickerWrapperView: UIView! {
        didSet {
            guard pickerWrapperView != nil else {
                return
            }
            
            pickerWrapperView.backgroundColor = .white
            pickerWrapperView.layer.borderWidth = 1
            pickerWrapperView.layer.borderColor = UIColor.orange.cgColor
            cancelViewButton.addSubview(pickerWrapperView)
        }
    }
    
    fileprivate var picker: UIPickerView! {
        didSet {
            guard picker != nil else {
                return
            }
            
            picker.dataSource = self
            picker.delegate = self
            picker.showsSelectionIndicator = true
            pickerWrapperView.addSubview(picker)
        }
    }
    
    fileprivate var pickerDoneButton: UIButton! {
        didSet {
            guard pickerDoneButton != nil else {
                return
            }
            
            pickerDoneButton.layer.borderWidth = 0.3
            pickerDoneButton.setTitleColor(.black, for: .normal)
            pickerDoneButton.setTitle("Done", for: .normal)
            pickerDoneButton.addTarget(self, action: #selector(pickerDoneButtonPressed), for: .touchUpInside)
            pickerWrapperView.addSubview(pickerDoneButton)
        }
    }
    
    fileprivate var pickerCancelButton: UIButton! {
        didSet {
            guard pickerCancelButton != nil else {
                return
            }
            
            pickerCancelButton.layer.borderWidth = 0.3
            pickerCancelButton.setTitleColor(.black, for: .normal)
            pickerCancelButton.setTitle("Cancel", for: .normal)
            pickerCancelButton.addTarget(self, action: #selector(pickerCancelButtonPressed), for: .touchUpInside)
            pickerWrapperView.addSubview(pickerCancelButton)
        }
    }
    
    // MARK: - override
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Details"
        
        cell = GameTableViewCell()
        percentLabel = UILabel()
        predictButton = UIButton()
        startYearLabel = UILabel()
        endYearLabel = UILabel()
        yearSlider = UISlider()
        weightsTableView = PredictionWeightsTableView()
        getStatsFromGame(game: game)
        weightsTableView.reloadData()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        cell.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 100)
        yearSlider.frame = CGRect(x: startYearLabel.frame.maxX, y: cell.frame.maxY, width: endYearLabel.frame.minX - startYearLabel.frame.maxX, height: 40)
        startYearLabel.frame = CGRect(x: 0, y: cell.frame.maxY, width: 50, height: yearSlider.frame.height)
        endYearLabel.frame = CGRect(x: view.frame.width - 50, y: cell.frame.maxY, width: 50, height: yearSlider.frame.height)
        percentLabel.frame = CGRect(x: view.frame.width - 50, y: view.frame.height - 44, width: 50, height: 44)
        predictButton.frame = CGRect(x: 0, y: view.frame.height - 44, width: percentLabel.frame.minX, height: 44)
        weightsTableView.frame = CGRect(x: 0, y: yearSlider.frame.maxY, width: view.frame.width, height: predictButton.frame.minY - yearSlider.frame.maxY)
        cancelViewButton?.frame = view.bounds
        pickerWrapperView?.frame = CGRect(x: view.frame.width / 2 - 100, y: view.frame.height / 2 - 75, width: 200, height: 150)
        picker?.frame = CGRect(x: 0, y: 0, width: pickerWrapperView.frame.width, height: pickerWrapperView.frame.height - 30)
        pickerDoneButton?.frame = CGRect(x: pickerWrapperView.frame.width / 2, y: picker.frame.maxY, width: picker.frame.width / 2, height: 30)
        pickerCancelButton?.frame = CGRect(x: picker.frame.minX, y: picker.frame.maxY, width: picker.frame.width / 2, height: 30)
    }
    
    // MARK: - METHODS
    
    // MARK: internal
    
    internal func predictButtonPressed() {
        let years = endYear - startYear
        let sliderYear = round(Float(years) * yearSlider.value)
        let newStartYear = Int(Float(startYear) + sliderYear)
        var allYears = ""
        for value in newStartYear...endYear {
            if value != endYear {
                allYears += ("\(value)" + ",")
            } else {
                allYears += "\(value)"
            }
        }
        
        let wildCardTeamId = pickedValue.name == game.firstTeam.shortName ? game.firstTeam.id : game.secondTeam.id
        
        let params: NSArray = [stats[0].value, stats[1].value, stats[2].value, stats[3].value, stats[4].value, stats[5].value, stats[6].value, stats[7].value, stats[8].value, stats[9].value, wildCardTeamId, game.firstTeam.id, game.secondTeam.id, allYears, game.id]
        
        getDetailsForFixture(params: params)
    }
    
    internal func yearSliderValueChanged(slider: UISlider) {
        
        let years = endYear - startYear
        let sliderYear = round(Float(years) * slider.value)
        let newStartYear = Int(Float(startYear) + sliderYear)
        
        startYearLabel.text = "\(newStartYear)"
    }
    
    internal func pickerDoneButtonPressed() {
        
        if shouldInitializeSecondColumn {
            let name = picker.selectedRow(inComponent: 0) == 0 ? game.firstTeam.shortName : game.secondTeam.shortName
            
            pickedValue = (pickedValue.statIndex, name, picker.selectedRow(inComponent: 1))
        } else {
            pickedValue = (pickedValue.statIndex, pickedValue.name, picker.selectedRow(inComponent: 0))
        }
        
        stats[pickedValue.statIndex].name = pickedValue.name
        stats[pickedValue.statIndex].value = pickedValue.value * 5
        weightsTableView.reloadData()
        
        var percent: Int = 0
        for stat in stats {
            percent += stat.value
        }
        
        if percent != 100 {
            predictButton.isEnabled = false
        } else {
            predictButton.isEnabled = true
        }
        
        percentLabel.text = "\(percent)"
        
        pickerCancelButtonPressed()
    }
    
    internal func pickerCancelButtonPressed() {
        
        cancelViewButton.removeFromSuperview()
        cancelViewButton = nil
        pickerWrapperView = nil
        picker = nil
        pickerDoneButton = nil
        pickerCancelButton = nil
    }
    
    // MARK: fileprivate
    
    // MARK: private
    
    private func getDetailsForFixture(params: NSArray) {
        
        activityIndicator.stopAnimating()
        activityIndicator.startAnimating()
        APIManager.getFixtureDetailsForGame(game: game, params: params) { Void in
            self.activityIndicator.stopAnimating()
            let predictionController = PredictionViewController()
            predictionController.game = self.game
            self.navigationController?.pushViewController(predictionController, animated: true)
        }
    }
    
    private func getStatsFromGame(game: Game) {
        
        stats = [("H2H Home", 10), ("H2H Away", 10), ("Home Record", 10), ("Away Record", 10), ("Starting Favourite", 10), ("Against The Odds", 10), ("Ladder Position", 10), ("+/- Odds", 10), ("Days Break", 5), ("Day Of Match", 5), ("Last 5 Matches", 5), ("Wild Card", 5)]
    }
}

extension GameDetailsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        shouldInitializeSecondColumn = indexPath.row == stats.count - 1
        
        pickedValue.statIndex = indexPath.row
        pickedValue.name = stats[indexPath.row].name
        
        cancelViewButton = UIButton()
        pickerWrapperView = UIView()
        picker = UIPickerView()
        pickerDoneButton = UIButton()
        pickerCancelButton = UIButton()
    }
}

extension GameDetailsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 60
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return stats.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "PredictionWeightsCell") as! PredictionWeightsCell
        cell.weight = "\(stats[indexPath.row].value)%"
        cell.weightName = stats[indexPath.row].name
        
        return cell
    }
}

extension GameDetailsViewController: UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if shouldInitializeSecondColumn {
            switch component {
            case 0:
                switch row {
                case 0:
                    return game.firstTeam.shortName
                case 1:
                    return game.secondTeam.shortName
                default:
                    return ""
                }
            case 1:
                return "\(row * 5)%"
            default:
                return ""
            }
        } else {
            return "\(row * 5)%"
        }
    }
}

extension GameDetailsViewController: UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        
        if shouldInitializeSecondColumn {
            return 2
        } else {
            return 1
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        if shouldInitializeSecondColumn {
            switch component {
            case 0:
                return 2
            case 1:
                return 21
            default:
                return 0
            }
        } else {
            return 21
        }
    }
}
