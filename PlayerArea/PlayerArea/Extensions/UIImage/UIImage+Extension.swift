//
//  UIImage+Extension.swift
//  PlayerArea
//
//  Created by Ufuk Köşker on 17.12.2022.
//

import UIKit

extension UIImage {
    static var pc: UIImage {
        return UIImage(named: "windows")!
    }
    static var ps: UIImage {
        return UIImage(named: "playstation")!
    }
    static var xbox: UIImage {
        return UIImage(named: "xbox")!
    }
    static var nintendo: UIImage {
        return UIImage(named: "nintendo")!
    }
    static var linux: UIImage {
        return UIImage(named: "linux")!
    }
    static var macos: UIImage {
        return UIImage(named: "apple")!
    }
    static var android: UIImage {
        return UIImage(named: "android")!
    }
    static var ios: UIImage {
        return UIImage(named: "apple")!
    }
    static var web: UIImage {
        return UIImage(named: "web")!
    }
    static var wiiU: UIImage {
        return UIImage(named: "wiiU")!
    }
    static var star: UIImage {
        return UIImage(systemName: "star")!.withTintColor(.systemYellow)
    }
    static var starFill: UIImage {
        return UIImage(systemName: "star.fill")!.withTintColor(.systemYellow)
    }
}
