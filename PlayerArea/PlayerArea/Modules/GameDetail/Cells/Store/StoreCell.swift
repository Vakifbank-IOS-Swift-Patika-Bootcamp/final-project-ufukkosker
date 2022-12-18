//
//  StoreCell.swift
//  PlayerArea
//
//  Created by Ufuk Köşker on 17.12.2022.
//

import UIKit

class StoreCell: UITableViewCell {

    @IBOutlet private weak var storeCollectionView: UICollectionView!
    var stores: [StoresModel] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupStoreCollectionView()
    }
    
    private func setupStoreCollectionView() {
        let genresItemCellName = String(describing: StoreItemCell.self)
        let genresItemCellNib = UINib(nibName: genresItemCellName, bundle: .main)
        storeCollectionView.register(genresItemCellNib, forCellWithReuseIdentifier: genresItemCellName)
        
        storeCollectionView.delegate = self
        storeCollectionView.dataSource = self
    }
}

extension StoreCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return stores.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: StoreItemCell.self), for: indexPath) as? StoreItemCell {
            cell.config(with: stores[indexPath.row])
            return cell
        }
        return UICollectionViewCell()
    }
}

extension StoreCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let storeItem = stores[indexPath.row]
        guard let name = storeItem.store?.name
        else { return CGSize() }
        return CGSize(width: name.size(withAttributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 16, weight: .bold)]).width + 25, height: 30)
    }
}
