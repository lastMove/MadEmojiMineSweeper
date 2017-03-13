//
//  GameEngine.swift
//  MadMineSweepper
//
//  Created by jason akakpo on 10/03/2017.
//  Copyright © 2017 MTT. All rights reserved.
//

import Foundation

class GameEngine {
    let grid:Grid
    let startingDate: Date
    var delegate: GameEngineDelegate?

    init(difficulty: GameDifficulty) {
        grid = Grid(difficulty: difficulty)
        startingDate =  Date();
        // generateMap
    }
    var elapsedTime: TimeInterval {
        return abs(startingDate.timeIntervalSinceNow)
    }
    func cellSelected(cell: Cell, flagMode: Bool) {
        guard (cell.state != .discovered) else {
            // la cell selectionnée est déjà révelée donc on ne fait rien
            return
        }
        if flagMode {
            grid.flag(cell: cell)
        } else {
            grid.reveal(cell: cell)
        }

        if !checkLoose() {
            checkWin()
        }

    }
    // on peut aussi gagner en flaggant toutes les mines (et juste les mines)
    private func checkAllMineFlagged() -> Bool {
        let flaggedCells = grid.getAllCells().filter { return $0.state == .flagged }
        let flaggedCellsWithBomb = grid.getAllCells().filter { return $0.type == .bomb && $0.state == .flagged }
        let bombCells = grid.getAllCells().filter { return $0.type == .bomb }
        // on gagne si : 
        // - il y a autant de cells avec un drapeau que de cells avec un drapeau + une bombe => Toutes les cells flaggés contienne une bombe
        // - et si il y a autant de cells flaggés que de bombes
        let isWin = flaggedCells.count == flaggedCellsWithBomb.count && flaggedCellsWithBomb.count == bombCells.count
        return isWin
    }

    func checkOnyBombUndiscovered() -> Bool{
        // filtre les cells pour ne garder que celles qui ne sont pas découvertes ET ne sont pas des bombes (si il n'y en a aucune, c'est gagné)
        let undiscoveredNonBombCells = grid.getAllCells().filter { (cell) -> Bool in
            return cell.state != .discovered && cell.type != .bomb
        }
        return undiscoveredNonBombCells.count == 0
    }
    @discardableResult func checkWin() -> Bool {

        let isWin = checkAllMineFlagged() || checkOnyBombUndiscovered()
        if isWin {
            delegate?.didWin(time: elapsedTime)
        }
        return isWin
    }
    func checkLoose() -> Bool {
        let isLoose = grid.getAllCells().filter { (cell) -> Bool in
            return cell.state == .discovered && cell.type == .bomb
            }.count > 0
        if isLoose {
            delegate?.didLoose()
        }
        return isLoose
    }



}

protocol GameEngineDelegate {

    func didLoose()
    func didWin(time: TimeInterval)
    
}
