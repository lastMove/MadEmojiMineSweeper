//
//  GridView.swift
//  MadMineSweepper
//
//  Created by jason akakpo on 12/03/2017.
//  Copyright © 2017 MTT. All rights reserved.
//

import Foundation
import UIKit

class GridView: UICollectionView {

    var gridDelegate: SelectedCellDelegate?
    var grid: Grid? {
        didSet {
            configureView()
            self.updateView()

        }
    }

    func configureView() {
        self.delegate = self
        self.dataSource = self
        self.updateView()
    }
    func updateView() {
        DispatchQueue.main.async {
            self.reloadData()
        }
    }
}




extension GridView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return grid?.getAllCells().count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cellView = collectionView.dequeueReusableCell(withReuseIdentifier: "CellView", for: indexPath) as! CellView
        cellView.cell = grid?.getAllCells()[indexPath.row]

        cellView.updateView()
        cellView.delegate = self
        return cellView
    }

}

extension GridView: SelectedCellDelegate {
    func cellSelected(cell: Cell) {
        gridDelegate?.cellSelected(cell: cell)
    }
}

extension GridView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let grid = grid else {
            return CGSize(width:10.0, height: 10.0);
        }
        let gridSize = grid.difficulty.size
        let screenWidth = UIScreen.main.bounds.size.width
        return CGSize(width: screenWidth / CGFloat(gridSize.width) , height: screenWidth  / CGFloat(gridSize.height))
    }
}
