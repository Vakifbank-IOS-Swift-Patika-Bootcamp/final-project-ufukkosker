//
//  CategoryListCell.swift
//  PlayerArea
//
//  Created by Ufuk Köşker on 12.12.2022.
//

import UIKit

class CategoryListCell: UITableViewCell {

    @IBOutlet private weak var categoryCollectionView: UICollectionView!
    
    var categoryItems: [CategoryListResult] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        categoryCollectionView.delegate = self
        categoryCollectionView.dataSource = self
        registerCategoryItemCell()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    private func registerCategoryItemCell() {
        let categoryItemCellName = String(describing: CategoryItemCell.self)
        let categoryItemCellNib = UINib(nibName: categoryItemCellName, bundle: .main)
        categoryCollectionView.register(categoryItemCellNib, forCellWithReuseIdentifier: categoryItemCellName)
    }
}

extension CategoryListCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categoryItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let categoryItem = categoryItems[indexPath.row]
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: CategoryItemCell.self), for: indexPath) as? CategoryItemCell {
            cell.config(with: categoryItem)
            return cell
        }
        return UICollectionViewCell()
    }
}

extension CategoryListCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if categoryItems[indexPath.row].isSelected {
            categoryItems[indexPath.row].isSelected = false
        } else {
            if let index = categoryItems.firstIndex(where: { $0.isSelected == true }) {
                categoryItems[index].isSelected = false
                let indexPath = IndexPath(item: index, section: 0)
                collectionView.reloadItems(at: [indexPath])
            }
            categoryItems[indexPath.row].isSelected = true
        }
        let indexPath = IndexPath(item: indexPath.row, section: 0)
        collectionView.reloadItems(at: [indexPath])
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let categoryItem = categoryItems[indexPath.row]
        guard let name = categoryItem.name
        else { return CGSize() }
        return CGSize(width: name.size(withAttributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 16, weight: .bold)]).width + 25, height: 30)
    }
}
