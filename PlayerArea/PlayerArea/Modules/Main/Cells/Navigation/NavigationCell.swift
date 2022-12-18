//
//  NavigationCell.swift
//  PlayerArea
//
//  Created by Ufuk Köşker on 13.12.2022.
//

import UIKit

protocol NavigationCellProtocol: AnyObject {
    func didTappedBackButton(with link: String)
    func didTappedNextButton(with link: String)
}

class NavigationCell: UITableViewCell {

    @IBOutlet private weak var backButton: UIButton!
    @IBOutlet private weak var nextButton: UIButton!
    
    weak var delegate: NavigationCellProtocol?
    private var backLink: String = ""
    private var nextLink: String = ""
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func config(with model: GameListResponseModel) {
        if let backLink = model.previous {
            backButton.isHidden = false
            self.backLink = backLink
        } else {
            backButton.isHidden = true
        }
        if let nextLink = model.next {
            nextButton.isHidden = false
            self.nextLink = nextLink
        } else {
            nextButton.isHidden = true
        }
    }
    
    @IBAction func didTappedBackButton(_ sender: Any) {
        delegate?.didTappedBackButton(with: backLink)
    }
    
    @IBAction func didTappedNextButton(_ sender: Any) {
        delegate?.didTappedNextButton(with: nextLink)
    }
}
