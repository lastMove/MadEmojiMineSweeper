//
//  CellView.swift
//  MadMineSweepper
//
//  Created by jason akakpo on 12/03/2017.
//  Copyright © 2017 MTT. All rights reserved.
//

import Foundation
import UIKit

protocol SelectedCellDelegate {
    func cellSelected(cell: Cell) -> Void
}
class CellView: UICollectionViewCell {
    @IBOutlet weak var label: UILabel!
    var cell: Cell!
    var delegate:SelectedCellDelegate?
    @IBAction func cellTapped(_ sender: Any) {
        delegate?.cellSelected(cell: cell)
    }
    func updateView() {

        if cell.state == .discovered {
            label.backgroundColor = UIColor.discoveredCellColor
            self.backgroundColor = UIColor.discoveredCellBorderColor
        } else {
            label.backgroundColor = UIColor.hiddenCellColor
            self.backgroundColor = UIColor.black
        }
        switch (cell.state, cell.type) {
        case (.hidden, _):
            label.text = ""
        case (.flagged, _):
            label.text = "🚩"
        case (.discovered, let .empty(surroundingBombsCount)):
            if (surroundingBombsCount == 0) {
                label.text = ""
                return
            }

            label.textColor = colorsForNumber(minesCount: surroundingBombsCount)
            label.text = "\(surroundingBombsCount)"
        case (.discovered, .bomb):
            label.text = "💣"
        }
    }

    func colorsForNumber(minesCount: Int) -> UIColor {
        switch minesCount {
        case 1:
            return UIColor.blue
        case 2:
            return UIColor(hex6:  0x4CD964)
        case 3:
            return UIColor(hex6:  0xFF3B30)
        case 4:
            return UIColor(hex6:  0xC644FC)
        case 5:
            return UIColor(hex6:  0xFF9500)
        case 6:
            return UIColor(hex6:  0x81F3FD)
        case 8:
            return UIColor(hex6:  0xC7C7CC)
        default:
            return UIColor.black
        }
    }

}
