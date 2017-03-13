//
//  Grid.swift
//  MadMineSweepper
//
//  Created by jason akakpo on 10/03/2017.
//  Copyright © 2017 MTT. All rights reserved.
//

import Foundation

class Grid {
    private var map:[[Cell]] = []
    let difficulty: GameDifficulty

    init(difficulty: GameDifficulty) {
        self.difficulty = difficulty
        generateGrid()
    }
    // affiche la grid dans la console
    func debugGrid() {
        map.forEach { (row) in
            var line = ""
            row.forEach({ (cell) in
                switch cell.type {
                case .bomb:
                    line += "💣 "
                case let .empty(surrondingsBombs):
                    line += "\(surrondingsBombs) "
                }
            })
            print(line);
        }
    }
    // cette fonction permet d'obtenir toutes les cells en tant que tableau simple (et pas en 2d)
    func getAllCells() -> [Cell] {
        return  map.reduce([], +)
    }

    func flag(cell: Cell) {

        if cell.state == .hidden {
        cell.state = .flagged
        } else if cell.state == .flagged {
            cell.state = .hidden
        }
    }

    // cette fonction revele la cellule ET si il s'agit d'une cellule vide (avec aucune bombe autour) recursivement toutes les cellules autour d'elle ...
     func reveal(cell: Cell) {
        guard cell.state != .flagged else {
            cell.state = .hidden
            return
        }
        cell.state = .discovered
        if  case .empty(let surrondingsBombs) = cell.type, surrondingsBombs == 0 {
            getSurrondingCells(cellPosition: cell.position).filter({ (cell) -> Bool in
                return cell.state != .discovered
            }).forEach(reveal) // recupere toutes les cellules autour de celle-ci qui ne sont pas révélées, puis les révèle (recursif)
        }
    }
    func generateGrid() {
        let size = difficulty.size
        let minesNumber = difficulty.minesCount

        // init the list of cells
        for y in 0..<size.height {
            var row = [Cell]();
            for x in 0..<size.width {
                let cell = Cell(position: Position(x: x, y: y), type: .empty(surrondingsBombs: 0), state: .hidden)
                row.append(cell);
            }
            map.append(row);

        }

        let bombPositions = generateRandomPositions(size: size, count: minesNumber)
        updateGridWithBombs(bombPositions: bombPositions)

    }

    private func updateGridWithBombs(bombPositions: Set<Position>) {
        for position in bombPositions {
            map[position.y][position.x].type = .bomb
        }
        for row in map {
            for cell in row where cell.type != .bomb {
                let numberOfSurroundingBombs = getSurroundingBombCount(position: cell.position)
                cell.type = .empty(surrondingsBombs: numberOfSurroundingBombs)
            
            }
        }
    }

    func getCell(for position: Position) -> Cell {
        return map[position.y][position.x]
    }

    func getSurroundingBombCount(position: Position) -> Int {
        return getSurrondingCells(cellPosition: position).filter({ (cell) -> Bool in
            return cell.type == .bomb
        }).count
    }
    func getSurrondingCells(cellPosition: Position) -> [Cell] {
        var positions:[Position] = []
        let size = difficulty.size

        for x in (cellPosition.x - 1)...(cellPosition.x + 1) {
            for y in (cellPosition.y - 1)...(cellPosition.y + 1) where x != cellPosition.x || y != cellPosition.y  {
                positions.append(Position(x: x, y: y))
            }
        }

        let validPositions = positions.filter { (position) -> Bool in
            return (position.x >= 0 && position.x < size.width) && (position.y >= 0 && position.y < size.height) && position != cellPosition
        }

        return validPositions.map(getCell) // Transforme le tableau de Positions en tableau de Cell grace a la magie de .map
    }

    // genere un tableau de 'Position' qui ne contient pas de doublons
    private func generateRandomPositions(size: GridSize, count: Int) -> Set<Position> {
        var positions: Set<Position> = [] // grace à l'utilisation d'un Set, il n'y aura pas de doublons

        while positions.count < count {
            let x = Int(arc4random_uniform(UInt32(size.width)))
            let y = Int(arc4random_uniform(UInt32(size.height)))
            positions.insert(Position(x: x, y: y))
        }
        return positions
        
    }
    
}
