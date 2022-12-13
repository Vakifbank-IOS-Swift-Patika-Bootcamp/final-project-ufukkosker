//
//  GameItemCell.swift
//  PlayerArea
//
//  Created by Ufuk Köşker on 13.12.2022.
//

import UIKit

class GameItemCell: UITableViewCell {
    
    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var gameImageView: UIImageView!
    @IBOutlet private weak var gameNameLabel: UILabel!
    @IBOutlet private weak var gameRatingLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        containerView.layer.cornerRadius = 8
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func config(with model: GameListResult) {
        guard let imageUrl = model.backgroundImage,
              let name = model.name,
              let rating = model.rating
        else { return }
        gameImageView.downloaded(with: imageUrl)
        gameNameLabel.text = name
        gameRatingLabel.text = String(rating)
    }
}
