//
//  File.swift
//  MadMineSweepper
//
//  Created by jason akakpo on 10/03/2017.
//  Copyright © 2017 MTT. All rights reserved.
//

import Foundation

typealias GridSize = (width:Int, height:Int)
enum GameDifficulty {
    case easy
    case normal
    case hard

    var minesCount: Int {
        switch self {
        case .easy:
            return 10
        case .normal:
            return 20
        case .hard:
            return 50
        }
    }
    var size: GridSize {
        switch self {
        case .easy:
            return GridSize(width: 10, height:10)
        case .normal:
            return GridSize(width: 10, height:10)
        case .hard:
            return GridSize(width:11, height:11)
        }
    }
}
