//
//  NoteItemCell.swift
//  PlayerArea
//
//  Created by Ufuk Köşker on 19.12.2022.
//

import UIKit

class NoteItemCell: UITableViewCell {

    @IBOutlet private weak var gameNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setupCell(title: String) {
        gameNameLabel.text = title
    }
}
