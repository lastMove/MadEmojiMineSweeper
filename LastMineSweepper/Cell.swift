//
//  cellType.swift
//  LastMineSweepper
//
//  Created by jason akakpo on 09/03/2017.
//  Copyright © 2017 MTT. All rights reserved.
//

import Foundation


class Cell {
    let position:Position
    var type:CellType
    var state: CellState


    init(position: Position, type: CellType, state: CellState) {
        self.position = position
        self.type = type
        self.state = state
    }
}
