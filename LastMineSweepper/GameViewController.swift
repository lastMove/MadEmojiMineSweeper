//
//  GameViewController.swift
//  MadMineSweepper
//
//  Created by jason akakpo on 10/03/2017.
//  Copyright © 2017 MTT. All rights reserved.
//

import Foundation
import UIKit

class GameViewController: UIViewController {

    @IBOutlet weak var timeLabel: UILabel!
    var gameTimer: Timer!
    var flagMode: Bool = false {
        didSet {
            updateFlagButton()
        }
    }

    @IBOutlet weak var gridView: GridView!
    var gameEngine: GameEngine!

    @IBOutlet weak var flagButton: UIButton!

    override func viewDidAppear(_ animated: Bool) {

        super.viewDidAppear(animated)
        if gameEngine == nil {
            promptNewGame()
        }
    }
    @IBAction func newGameTapped(_ sender: Any) {
        gameTimer.invalidate()
        promptNewGame()
    }
    func updateTimeLabel() {
        timeLabel.text = gameEngine?.elapsedTime.digitalString() ?? 0.0.digitalString()
    }
}

extension GameViewController: GameEngineDelegate {

    func didLoose() {
        gameTimer.invalidate()

        let ac = UIAlertController(title: "Perdu !", message: "Dommage, Rééssayez !", preferredStyle: .alert);
        ac.addAction(UIAlertAction(title: "Rééssayer, J'y arriverai !", style: .default, handler: { (action) in
            self.promptNewGame()
        }))
        self.present(ac, animated: true, completion: nil)
    }
    func didWin(time: TimeInterval) {
        gameTimer.invalidate()
        let ac = UIAlertController(title: "Victoire", message: "Vous avez gagné ! en \(time.digitalString()) secondes", preferredStyle: .alert);
        ac.addAction(UIAlertAction(title: "Cool, Une Autre !", style: .default, handler: { (action) in
            self.promptNewGame()
        }))
        self.present(ac, animated: true, completion: nil)
    }
}

// MARK : - Create new Game 

extension GameViewController {

    func newGame(difficulty: GameDifficulty) {
        gameEngine = GameEngine(difficulty: difficulty)
        gameEngine.delegate = self
        gridView.gridDelegate = self
        gridView.grid = gameEngine.grid
        flagMode = false
        flagButton.backgroundColor = .gray
        gameTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(updateTimeLabel), userInfo: nil, repeats: true)

        gridView.updateView()

    }
    func promptNewGame() {
        let ac = UIAlertController(title: "Difficulté ?", message: nil, preferredStyle: .actionSheet)
        ac.addAction(UIAlertAction(title: "Fastoche", style: .default, handler: { (action) in
            self.newGame(difficulty: .easy)
        }))
        ac.addAction(UIAlertAction(title: "Normal", style: .default, handler: { (action) in
            self.newGame(difficulty: .normal)
        }))
        ac.addAction(UIAlertAction(title: "Mad !", style: .default, handler: { (action) in
            self.newGame(difficulty: .hard)
        }))
        self.present(ac, animated: true, completion: nil)
    }
}
// MARK : - Manage FlagSelector
extension GameViewController {

    func updateFlagButton() {
        flagButton.layer.borderWidth = 3;
        if flagMode {
            flagButton.layer.borderColor = UIColor.red.cgColor
        } else {
            flagButton.layer.borderColor = UIColor.clear.cgColor
        }

    }
    @IBAction func flagButtonTapped(_ sender: UIButton) {
        flagMode = !flagMode

    }

    
}

extension GameViewController: SelectedCellDelegate {
    func cellSelected(cell: Cell) {
        gameEngine.cellSelected(cell: cell, flagMode: flagMode)
        gridView.updateView()
    }
}
