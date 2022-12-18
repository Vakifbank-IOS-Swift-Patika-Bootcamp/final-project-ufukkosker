//
//  AddNoteButtonCell.swift
//  PlayerArea
//
//  Created by Ufuk Köşker on 18.12.2022.
//

import UIKit

class AddNoteButtonCell: UITableViewCell {

    @IBOutlet private weak var addNoteButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        addNoteButton.layer.cornerRadius = 8
    }
}
