//
//  UIImageView+Extension.swift
//  PlayerArea
//
//  Created by Ufuk Köşker on 13.12.2022.
//

import UIKit
import Kingfisher

extension UIImageView {
    func downloadImage(with urlString: String){
        guard let url = URL.init(string: urlString) else { return }
        let resource = ImageResource(downloadURL: url)
        let activityInd = UIActivityIndicatorView()
        activityInd.center = CGPoint(x: self.frame.size.width  / 2,
                                     y: self.frame.size.height / 2)
        self.addSubview(activityInd)
        activityInd.startAnimating()
        DispatchQueue.main.async {
            KingfisherManager.shared.retrieveImage(with: resource, options: nil, progressBlock: nil) { result in
                switch result {
                case .success(let value):
                    self.image = value.image
                    activityInd.stopAnimating()
                case .failure:
                    break
                }
            }
        }
    }
}
