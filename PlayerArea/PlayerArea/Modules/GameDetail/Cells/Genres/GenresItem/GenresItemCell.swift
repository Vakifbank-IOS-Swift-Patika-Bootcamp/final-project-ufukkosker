//
//  GenresItemCell.swift
//  PlayerArea
//
//  Created by Ufuk Köşker on 16.12.2022.
//

import UIKit

class GenresItemCell: UICollectionViewCell {

    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var categoryNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        containerView.layer.cornerRadius = 8
    }
    
    func config(with model: GenresModel) {
        guard let name = model.name
        else { return }
        categoryNameLabel.text = name
    }
}
