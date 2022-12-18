//
//  CategoryItemCell.swift
//  PlayerArea
//
//  Created by Ufuk Köşker on 12.12.2022.
//

import UIKit

class CategoryItemCell: UICollectionViewCell {

    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var categoryNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        containerView.layer.cornerRadius = 8
    }
    
    func config(with model: CategoryListResult) {
        guard let name = model.name
        else { return }
        containerView.backgroundColor = model.isSelected ? .systemBlue : .tertiarySystemBackground
        categoryNameLabel.text = name
    }
}
