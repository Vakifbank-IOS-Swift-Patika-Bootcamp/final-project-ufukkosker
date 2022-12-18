//
//  DescriptionCell.swift
//  PlayerArea
//
//  Created by Ufuk Köşker on 16.12.2022.
//

import UIKit

class DescriptionCell: UITableViewCell {

    @IBOutlet private weak var gameDescriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func config(with description: String?) {
        guard let description = description
        else { return }
        gameDescriptionLabel.text = description
    }
}
