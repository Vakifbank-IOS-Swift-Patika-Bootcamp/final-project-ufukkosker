//
//  StoreItemCell.swift
//  PlayerArea
//
//  Created by Ufuk Köşker on 17.12.2022.
//

import UIKit

class StoreItemCell: UICollectionViewCell {

    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var storeNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        containerView.layer.cornerRadius = 8
    }
    
    func config(with model: StoresModel) {
        guard let name = model.store?.name
        else { return }
        storeNameLabel.text = name
    }
}
