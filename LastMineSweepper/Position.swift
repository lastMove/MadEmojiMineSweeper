//
//  Position.swift
//  MadMineSweepper
//
//  Created by jason akakpo on 10/03/2017.
//  Copyright © 2017 MTT. All rights reserved.
//

import Foundation


struct Position {
    let x: Int
    let y: Int
}
// Position doit se conformer au Type Hashable pour pouvoir etre stocké dans un 'Set' et pouvoir etre comparé 

extension Position: Hashable {
    var hashValue: Int {
        return x.hashValue ^ y.hashValue
    }
    
    static func == (lhs: Position, rhs: Position) -> Bool {
        return lhs.x == rhs.x && lhs.y == rhs.y
    }
}

