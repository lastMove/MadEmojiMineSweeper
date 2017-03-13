//
//  CellType.swift
//  MadMineSweepper
//
//  Created by jason akakpo on 10/03/2017.
//  Copyright © 2017 MTT. All rights reserved.
//

import Foundation

enum CellType {
    case empty(surrondingsBombs: Int)
    case bomb
}


extension CellType: Equatable {
    static func ==(lhs: CellType, rhs: CellType) -> Bool {
        switch (lhs, rhs) {
        case (.bomb, .bomb):
            return true
        case (let .empty(bombs1), let .empty(bombs2)):
            return bombs1 == bombs2
        default:
            return false
        }
    }

}
