//
//  HeaderCell.swift
//  PlayerArea
//
//  Created by Ufuk Köşker on 16.12.2022.
//

import UIKit

class HeaderCell: UITableViewCell {
    
    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var gameImageView: UIImageView!
    @IBOutlet private weak var gameNameLabel: UILabel!
    @IBOutlet private weak var gameRatingLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        gameImageView.kf.indicatorType = .activity
        containerView.layer.cornerRadius = 8
    }
    
    func config(with model: GameDetailResponseModel) {
        guard let imageUrl = model.backgroundImage,
              let name = model.name,
              let rating = model.rating
        else { return }
        gameImageView.downloadImage(with: imageUrl)
        gameNameLabel.text = name
        gameRatingLabel.text = String(rating)
    }
}
