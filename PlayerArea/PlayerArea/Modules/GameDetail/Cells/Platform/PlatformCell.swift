//
//  PlatformCell.swift
//  PlayerArea
//
//  Created by Ufuk Köşker on 16.12.2022.
//

import UIKit

class PlatformCell: UITableViewCell {

    @IBOutlet private weak var stackView: UIStackView!
    @IBOutlet private weak var platformButton: UIButton!
    @IBOutlet private weak var minimumRequirementLabel: UILabel!
    @IBOutlet private weak var recommendedRequirementLabel: UILabel!
    var platformModel: PlatformsModel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        setupPlatformButton()
        setupRequirementLabelHide()
    }
    
    func config(with model: PlatformsModel) {
        platformModel = model
        dump(platformModel)
        setupPlatformButton()
        setupRequirements()
        setupRequirementLabelHide()
    }
    
    private func setupPlatformButton() {
        platformButton.layer.cornerRadius = 8
        guard let platformName = platformModel?.platform?.name,
              let platform = platformModel?.platform?.slug
        else { return }
        platformButton.setTitle(platformName, for: .normal)
        platformButton.setImage(platform.icon.withRenderingMode(.alwaysOriginal), for: .normal)
        platformButton.setTitleColor(platform.tintColor, for: .normal)
        platformButton.backgroundColor = platform.backgroundColor
    }
    
    private func setupRequirements() {
        if let minimumRequirement = platformModel?.requirements?.minimum,
           let recommendedRequirement = platformModel?.requirements?.recommended {
            minimumRequirementLabel.text = minimumRequirement
            recommendedRequirementLabel.text = recommendedRequirement
            self.isUserInteractionEnabled = true
        } else {
            self.isUserInteractionEnabled = false
        }
    }
    
    private func setupRequirementLabelHide() {
        guard let isShown = platformModel?.isShown
        else { return }
        self.minimumRequirementLabel.isHidden = isShown ? false : true
        self.recommendedRequirementLabel.isHidden = isShown ? false : true
    }
}
