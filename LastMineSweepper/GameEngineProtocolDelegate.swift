//
//  GameEngineProtocolDelegate.swift
//  MadMineSweepper
//
//  Created by jason akakpo on 13/03/2017.
//  Copyright © 2017 MTT. All rights reserved.
//

import Foundation

protocol GameEngineDelegate {

    func didLoose()
    func didWin(time: TimeInterval)
}
