//
//  GenresCell.swift
//  PlayerArea
//
//  Created by Ufuk Köşker on 16.12.2022.
//

import UIKit

class GenresCell: UITableViewCell {

    @IBOutlet private weak var genresCollectionView: UICollectionView!
    var genres: [GenresModel] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupGenresCollectionView()
    }
    
    private func setupGenresCollectionView() {
        let genresItemCellName = String(describing: GenresItemCell.self)
        let genresItemCellNib = UINib(nibName: genresItemCellName, bundle: .main)
        genresCollectionView.register(genresItemCellNib, forCellWithReuseIdentifier: genresItemCellName)
        
        genresCollectionView.delegate = self
        genresCollectionView.dataSource = self
    }
}

extension GenresCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return genres.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: GenresItemCell.self), for: indexPath) as? GenresItemCell {
            cell.config(with: genres[indexPath.row])
            return cell
        }
        return UICollectionViewCell()
    }
}

extension GenresCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let categoryItem = genres[indexPath.row]
        guard let name = categoryItem.name
        else { return CGSize() }
        return CGSize(width: name.size(withAttributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 16, weight: .bold)]).width + 25, height: 30)
    }
}
